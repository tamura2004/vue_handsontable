namespace :doit do
  desc "各種一次処理や確認用"
  task dump: :environment do
    Member.find_each do |member|
      p member.name
    end
  end

  task makejson: :environment do
    class JsonPresenter
      attr_reader :fiber, :json, :model

      def initialize(model)
        @model = model
        @fiber = Fiber.new do
          str = Jbuilder.encode { |json| 
            Fiber.yield json
          }
          Fiber.yield str
        end
        @json = @fiber.resume
      end

      def self.j(model)
        new(model).json
      end

      def json.target
        fiber.resume
      end

    end

    json = JsonPresenter.j("hoge")
    json.set! :hoge, :fuga
    puts json.target
  end

end
