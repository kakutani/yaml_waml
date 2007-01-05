require 'test/unit'
require File.dirname(__FILE__) + "/../lib/yaml_waml"

class YamlWamlTest < Test::Unit::TestCase
  def test_string_to_yaml
    assert_equal(<<-EXPECTED, "あ".to_yaml)
--- "あ"
    EXPECTED
  end
end
