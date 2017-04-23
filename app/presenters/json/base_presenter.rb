class Json::BasePresenter
  attr_reader :object, :json
  alias_method :o, :object
  alias_method :j, :json

  def initialize(object, json)
    @object = object
    @json = json
  end

end
