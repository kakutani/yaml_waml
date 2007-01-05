require File.dirname(__FILE__) + "/spec_helper"

context "Japanese text" do
  specify "String should output string" do
    "あ".to_yaml.should_eql <<-EXPECTED
--- "あ"
    EXPECTED
  end
  
  specify "Array-ed string should output string" do
    ['あ','い'].to_yaml.should_eql <<-EXPECTED
--- 
- "あ"
- "い"
    EXPECTED
  end
  
  specify "Hash-ed string should output string" do
    {'日本語' => ['出力']}.to_yaml.should_eql <<-EXPECTED
--- 
"日本語": 
- "出力"
    EXPECTED
  end
  
  specify "mixed Array should output string" do
    actual = [["あ", "い"], {"う" => ["え"]}, Struct.new(:name).new("お")]
    actual.to_yaml.should_eql <<-EXPECTED
--- 
- - "あ"
  - "い"
- "う": 
  - "え"
- !ruby/struct: 
  name: "お"
    EXPECTED
  end
end
