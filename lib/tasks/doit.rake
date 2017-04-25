namespace :doit do
  desc "各種一次処理や確認用"
  task dump: :environment do
    Member.find_each do |member|
      p member.name
    end
  end

  task dumpproject: :environment do
  end

end
