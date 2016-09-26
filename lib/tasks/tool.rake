require 'fileutils'

module FileUtils
  def self.sed_i(file, pattern, replacement)
    File.open(file, "r") do |f_in|
      buf = f_in.read
      buf.gsub!(pattern, replacement)
      puts "-" * 80
      puts buf
      puts "-" * 80
      File.open(file, "w") do |f_out|
        f_out.write(buf)
      end
    end
  end

  def self.overwrite(file, replacement)
    puts "-" * 80
    puts replacement
    puts "-" * 80
    File.open(file, "w") do |f_out|
      f_out.write(replacement)
    end
  end

end

namespace :tool do
  desc "モデル一覧作成"
  task :model_generators => :environment do
    models = Rails.root.join("app","models").children.each do |path|
      next if path.extname != ".rb"
      model = path.basename(".rb").to_s.classify.constantize

      print "rails g rspec:model "
      print model.name
      begin
        model.columns.each do |col|
          next if col.name =~ /_at$/
          next if col.name == "id"
          print " %s:%s" % [col.name, col.type]
        end
      rescue
      end
      puts
    end
  end

  desc "モデルスペック一括修正"
  task :models => :environment do
    Rails.root.join("spec","models").children.each do |path|
      modelname = path.basename(".rb").to_s.gsub(/_spec/,"")
      pattern = /pending.*$/
      replacement = "subject{FactoryGirl.build :#{modelname}}\n"
      replacement += "\tit{should be_valid}\n"
      FileUtils.sed_i path.to_s, pattern, replacement
    end
  end

  desc "ルーティングスペック一括修正"
  task :modify_routing_spec => :environment do
    Rails.root.join("spec","routing").children.each do |path|
      modelname = path.basename(".rb").to_s.gsub(/_spec/,"")

      pattern = /it.*new.*\n.*\n.*end\n/
      replacement = ""
      FileUtils.sed_i path.to_s, pattern, replacement

      pattern = /it.*edit.*\n.*\n.*end\n/
      replacement = ""
      FileUtils.sed_i path.to_s, pattern, replacement
    end
  end

  desc "コントローラスペック一括修正"
  task :modify_controller_spec => :environment do
    Rails.root.join("spec","controllers").children.each do |path|
      modelname = path.basename(".rb").to_s.gsub(/_spec/,"")

      pattern = /describe.*#new(.*\n){5}.*end\n/
      replacement = ""
      FileUtils.sed_i path.to_s, pattern, replacement

      pattern = /describe.*#edit(.*\n){5}.*end\n/
      replacement = ""
      FileUtils.sed_i path.to_s, pattern, replacement

      pattern = /skip.*attributes valid.*$/
      replacement = "FactoryGirl.attributes_for :#{modelname}"
      FileUtils.sed_i path.to_s, pattern, replacement

      pattern = /_controller/
      replacement = ""
      FileUtils.sed_i path.to_s, pattern, replacement

    end
  end

  desc "リクエストスペック一括修正"
  task :requests => :environment do
    TEMPLATE = <<-EOD
require 'rails_helper'

RSpec.describe "Attendances", type: :request do
  let(:id){1}
  let(:params){{attendance: attributes_for(:attendance)}}
  before{create :attendance, id: id}

  describe "GET /attendances" do
    it{should == 200}
  end

  describe "GET /attendances/:id" do
    it{should == 200}
  end

  describe "POST /attendances" do
    it {should == 200}
  end

  describe "PATCH /attendances/1" do
    it{should == 200}
  end

  describe "DELETE /attendances/1" do
    it{should == 200}
  end
end
    EOD

    Rails.root.join("spec","requests").find do |path|
      next unless path.file?
      next unless path.to_s =~ /_spec/

      plus_name = path.basename(".rb").to_s.gsub(/_spec/,"")
      model_name = plus_name.classify.pluralize
      single_name = plus_name.singularize

      next if single_name =~ /attendance/
      next if single_name =~ /seat/

      replace = TEMPLATE.gsub(/attendances/,plus_name)
      replace = replace.gsub(/Attendances/,model_name)
      replace = replace.gsub(/attendance/,single_name)

      FileUtils.overwrite(path.to_s, replace)
    end
  end


end
