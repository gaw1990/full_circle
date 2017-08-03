class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.includes(:builds).find(params[:id])
    @most_test_failures = Test.includes(:test_cases).find(most_test_failures_ids)
  end


  def most_test_failures_ids
    ActiveRecord::Base.connection.execute(sql).values
  end

  def sql
    <<-SQL
      SELECT
        test_cases.test_id
      FROM
        test_cases
        JOIN tests USING (test_id)
        JOIN test_case_results ON (test_cases.test_case_result_id = test_case_results.id)
        JOIN builds USING (build_id)
        JOIN projects USING (project_id)
      WHERE
        test_cases.test_case_result_id = 3
        AND project_id = #{@project.id}
      GROUP BY
        test_cases.test_id
      ORDER BY
        count(test_cases) DESC
      LIMIT 10
    SQL
  end
end
