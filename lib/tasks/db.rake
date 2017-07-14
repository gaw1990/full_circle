namespace :db do
  desc "Fix 'database is being accessed by other users'"
  task terminate: :environment do
    ActiveRecord::Base.connection.execute <<-SQL
      SELECT pg_terminate_backend(pid)
      FROM   pg_stat_activity
      WHERE  pid <> pg_backend_pid()
        AND  datname = '#{ActiveRecord::Base.connection.current_database}';
    SQL
  end
end

if Rails.env.production?
  Rake::Task['db:drop'].clear
else
  Rake::Task['db:drop'].enhance ['db:terminate'] if ENV['KILL_CONNECTIONS']
end

