namespace :db do
	desc "database backup"
	task :backup => :environment do

		# Evacuate the last latest backup
		if File.exist?("tmp/backup.sql")
			stat = File::Stat.new("tmp/backup.sql")
			timestamp = stat.mtime.strftime("%Y-%m-%d_%H-%M-%S")
			File.rename("tmp/backup.sql","tmp/backup_#{timestamp}.sql")
		end

		# backup latest database
		config = Rails.configuration.database_configuration
		database = config[Rails.env]["database"]
		`pg_dump -d #{database} > tmp/backup.sql`

		# Delete backup over 3 generations
		files = Dir.glob("tmp/backup_*.sql").sort.reverse
		files.each_with_index do |file, i|
			File.delete(file) if i >= 3
		end
	end 
end
