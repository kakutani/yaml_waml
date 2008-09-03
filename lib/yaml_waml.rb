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
        str = case result
              when String
                result
              when StringIO
                result.string
              else
                return result
              end
        str.gsub!(/\\x(\w{2})/){[$1].pack("H2")}
        return result
      end
      alias_method :to_yaml_without_decode, :to_yaml
      alias_method :to_yaml, :to_yaml_with_decode
    end
  end
end
