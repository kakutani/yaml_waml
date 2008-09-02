# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + "/spec_helper"
BLANK = " "
context "Japanese text" do
  specify "String should output string" do
    "あ".to_yaml.should == <<-EXPECTED
--- "あ"
    EXPECTED
  end

  specify "Array-ed string should output string" do
    ['あ','い'].to_yaml.should == <<-EXPECTED
---#{BLANK}
- "あ"
- "い"
    EXPECTED
  end

  specify "Hash-ed string should output string" do
    {'日本語' => ['出力']}.to_yaml.should == <<-EXPECTED
---#{BLANK}
"日本語":#{BLANK}
- "出力"
    EXPECTED
  end

  specify "mixed Array should output string" do
    actual = [["あ", "い"], {"う" => ["え"]}, Struct.new(:name).new("お")]
    actual.to_yaml.should == <<-EXPECTED
---#{BLANK}
- - "あ"
  - "い"
- "う":#{BLANK}
  - "え"
- !ruby/struct:#{BLANK}
  name: "お"
    EXPECTED
  end
end
