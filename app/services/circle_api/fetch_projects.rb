module CircleApi
  class FetchProjects
    include Verbalize::Action

    def call
      user_info = CircleCi::User.new.me
      projects = user_info.body['projects'].keys.map { |uri| uri.split('/').last }

      projects.each do |p|
        Project.find_or_create_by(name: p)
      end
    end
  end
end
