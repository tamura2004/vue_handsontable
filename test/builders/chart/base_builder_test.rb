require "test_helper"

module Chart
  class BaseBuilderTest < ActiveSupport::TestCase
    setup do
      @builder = BaseBuilder.new
    end

    DEFAULT_CHART = {
      animationEnabled: true,
      theme: "theme4",
      title: {
        text: "",
        dockInsidePlotArea: true,
        fontSize: 16
      },
      legend: {
        reversed: true,
        dockInsidePlotArea: true,
        fontSize: 12,
        verticalAlign: "center"
      },
      axisX: {
        labelFontSize: 12
      },
      axisY: {
        labelFontSize: 12
      },
      data: []
    }

    test "chatjsの標準書式を持つ" do
      assert_equal DEFAULT_CHART, @builder.chart
    end

    instance_methods = %i[
      []=
      chart
    ]
  
    instance_methods.each do |method|
      test "インスタンスメソッド#{method}を持つ #{method}" do
        assert_respond_to @builder, method
      end
    end
  
    static_methods = %i[
      build
    ]
  
    static_methods.each do |method|
      test "スタティックメソッド#{method}を持つ #{method}" do
        assert_respond_to BaseBuilder, method
      end
    end
  end
end
