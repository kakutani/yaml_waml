# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + "/spec_helper"
BLANK = " "
describe YAML, "#to_yaml" do
  describe "Japanese text" do
    it "String should output string" do
      "あ".to_yaml.should == <<-EXPECTED
--- "あ"
    EXPECTED
    end

    it "Array-ed string should output string" do
      ['あ','い'].to_yaml.should == <<-EXPECTED
---#{BLANK}
- "あ"
- "い"
    EXPECTED
    end

    it "Hash-ed string should output string" do
      {'日本語' => ['出力']}.to_yaml.should == <<-EXPECTED
---#{BLANK}
"日本語":#{BLANK}
- "出力"
    EXPECTED
    end

    it "mixed Array should output string" do
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
end

describe YAML, ".dump" do
  it "should output yaml string" do
    YAML.dump("あ").should == <<-EXPECTED
--- "あ"
    EXPECTED
  end

  it "should be StringIO-friendly" do
    actual = [["あ", "い"], {"う" => ["え"]}, Struct.new(:name).new("お")]
    io = StringIO.new
    YAML.dump(actual, io)
    io.string.should be_eql <<-EXPECTED
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
