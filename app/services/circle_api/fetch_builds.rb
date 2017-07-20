module CircleApi
  class FetchBuilds
    include Verbalize::Action

    def call
      Project.where.not(name: 'monocle').each do |p|

        Rails.logger.info "fetching builds for #{p.name}"

        newest_build_number = CircleCi::Project.new('iloan', p.name).recent_builds(limit: 1).body.first['build_num']

        needed_builds = (1..newest_build_number).to_a - Build.where(project_id: p.project_id).pluck(:build_number)
        needed_builds.each do |b_num|

          Rails.logger.info "#{p.name}:#{b_num}: fetching build"

          build_details = CircleCi::Build.new 'iloan', p.name, nil, b_num
          build_get = build_details.get

          Rails.logger.info "#{p.name}:#{b_num}:status: #{build_get.body['status']}"

          build = p.builds.find_or_create_by(build_number: b_num, build_status_id: BuildStatus.find_or_create_by(status: build_get.body['status']).id, duration_milliseconds: build_get.body['build_time_milis'], run_at: build_get.body['usage_queued_at'])

          next unless ['success', 'fixed', 'failed'].include? build_get.body['status']

          uri = URI("https://circleci.com/api/v1.1/project/github/iloan/#{p.name}/#{b_num}/artifacts?circle-token=#{API_TOKENS['circle_ci']['token']}")

          Rails.logger.info "#{p.name}:#{b_num}: making call for artifacts @ #{uri}"
          response = Net::HTTP.get(uri)

          if response.length > 3
            Rails.logger.info "#{p.name}:#{b_num}: response was a not blank"

            urls = response.scan(/https:\/\/[^"']*/)
            rspec_artifact_string = urls.select { |url| url =~ /rspec.xml/ }.first

            if rspec_artifact_string

              Rails.logger.info "#{p.name}:#{b_num}: good artifact link for build"
              begin
                rspec_artifact_uri = URI(rspec_artifact_string)
                run_details = Net::HTTP.get(rspec_artifact_uri + "?circle-token=#{API_TOKENS['circle_ci']['token']}")

                noko_run_details = Nokogiri::XML(run_details)

                attrs = noko_run_details.document.children.first.attributes

                build.suite_type_id = SuiteType.find_or_create_by(suite_type: attrs['name'].value)
                build.run_at = attrs['timestamp'].value.to_time
                build.seed = noko_run_details.document.children.first.children[1].text.split(' ').last
                build.save
              rescue
                binding.pry
              end
            end
          end

          Rails.logger.info "#{p.name}:#{b_num}: fetching tests"
          test_cases = build_details.tests.body['tests']

          test_cases.each do |tc|
            Rails.logger.info "#{p.name}:#{b_num}:#{tc['name']}: status: #{tc['result']}"

            test = Test.find_or_create_by(test_name: tc['name'], file_name: tc['file'], class_name: tc['classname'])
            test_case = TestCase.create(
              test: test,
              build: build,
              duration_microseconds: (tc['run_time'] * 1000000),
              test_case_result: TestCaseResult.find_or_create_by(result: tc['result']),
              error_message: tc['message']
            )
          end
        end
      end
    end
  end
end
