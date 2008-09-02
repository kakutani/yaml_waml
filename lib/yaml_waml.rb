require "yaml"

class String
  def is_binary_data?
    false
  end
end

ObjectSpace.each_object(Class) do |klass|
  klass.class_eval do
    if method_defined?(:to_yaml) && !method_defined?(:to_yaml_with_decode)
      def to_yaml_with_decode(*args)
        result = to_yaml_without_decode(*args)
        if result.kind_of? String
          # decode to workaround
          result.gsub(/\\x(\w{2})/){
            [Regexp.last_match.captures.first.to_i(16)].pack("C")}
        elsif result.kind_of? StringIO
          str = result.string
          # decode to workaround
          str.gsub!(/\\x(\w{2})/){
            [Regexp.last_match.captures.first.to_i(16)].pack("C")}
          result.rewind
          result.write str
          result
        else
          result
        end
      end
      alias_method :to_yaml_without_decode, :to_yaml
      alias_method :to_yaml, :to_yaml_with_decode
    end
  end
end
