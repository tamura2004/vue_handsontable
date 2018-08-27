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

	require "csv"
	desc "import alloc"
	task :import => :environment do
		intra = Group.find(3)
		aso = JobTitle.find_by(name: "AS")

		CSV.foreach(Rails.root.join("tmp", "intranet_2018.csv")) do |row|
			month, _, _, group, _, flag, company, member_number, member_name, project_number, project_name, _, _, _, _, _, _, _, cost, _ = row
			puts row.join(",")

			member = nil
			if flag == "1"
				member_number = sprintf("%06d", member_number) if member_number.size <= 5
				member = Member.find_or_create_by(number: member_number, group: intra) do |m|
					m.name = member_name
					m.job_title_id = aso.id
				end
			else
				member = Member.find_or_create_by(number: member_number, group: intra) do |m|
					m.name = company
					m.job_title_id = aso.id
				end
			end

			MonthTypes.keys.each do |month|
				Work.find_or_create_by(month: month, member: member) do |w|
					w.cost = 1
				end
			end

			project = Project.find_or_create_by(number: project_number, group: intra) do |p|
				p.name = project_name
				p.end_month = "201903"
			end

			assign = Assign.find_or_create_by(member: member, project: project)

			Alloc.find_or_create_by(month: month, assign: assign) do |a|
				a.cost = cost
			end
		end
	end
end
