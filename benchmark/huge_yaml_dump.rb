require 'benchmark'
require 'yaml'

class String
  def is_binary_data?
    false
  end
end

data = [ "あいうえお漢字" * 10000, "__BBBBBBBBBBBBBBB__", "あいうえお" * 10000 ]

yaml_str = data.to_yaml
Benchmark.bm do |x|
  x.report('original yaml_waml') {
    yaml_str.gsub(/\\x(\w{2})/) {
      [ Regexp.last_match.captures.first.to_i(16)].pack("C")
    }
  }

  x.report('using $1') {
    yaml_str.gsub(/\\x(\w{2})/) {
      [ $1.to_i(16) ].pack("C")
    }
  }

  x.report('with memoize') {
    memoize_of = {}
    yaml_str.gsub(/\\x(\w{2})/) {|s|
      memoize_of[s] ||= [ Regexp.last_match.captures.first.to_i(16)].pack("C")
    }
  }

  x.report('with memoize and $1') {
    memoize_of = {}
    yaml_str.gsub(/\\x(\w{2})/) {|s|
      memoize_of[s] ||= [ $1.to_i(16) ].pack("C")
    }
  }

  x.report('with symbol table ') {
    memoize_of = {}
    chars = %w( 0 1 2 3 4 5 6 7 8 9 A B C D E F )
    chars.each do |char1|
      chars.each do |char2|
        val = char1 + char2
        memoize_of["\\x#{val}"] = [ val.to_i(16) ].pack("C")
      end
    end
    yaml_str.gsub(/\\x\w{2}/) {|s|
      memoize_of[s]
    }
  }

  x.report('packing  multi chars') {
    regex = /\\x/
    # 100は結構てきとう。無条件に大きすぎると返って遅くなりそうな気がするので適当なサイズにしておく
    yaml_str.gsub(/(?:\\x(\w{2})){0,100}/) {|s|
      s.split(regex).compact.map {|s| s.to_i(16) }.pack("C*").gsub("\0", '')
    }
  }

end

# result on my environment( MacBook1.1 Intel Core Duo 1.83 GHz, 2GB), result is like that
#                         user     system      total        real
# original yaml_waml    2.610000   0.020000   2.630000 (  2.719135)
# using $1              2.090000   0.030000   2.120000 (  2.173170)
# with memoize          1.080000   0.010000   1.090000 (  1.135563)
# with memoize and $1   1.110000   0.020000   1.130000 (  1.231589)
# with symbol table     1.090000   0.010000   1.100000 (  1.129839)
# packing  multi chars  0.970000   0.010000   0.980000 (  1.019086)
