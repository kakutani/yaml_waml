require "yaml"

class String
  def is_binary_data?
    false
  end
end

yaml_waml = Module.new
class << yaml_waml
  def run
    workaround_to_yaml_with_decode
  end

  private
  def workaround_to_yaml_with_decode
    ObjectSpace.each_object(Class){|klass|
      klass.class_eval{
        if method_defined?(:to_yaml) && !method_defined?(:to_yaml_with_decode)
          def to_yaml_with_decode(*args)
            result = to_yaml_without_decode(*args)
            if result.kind_of? String
              # decode for workaround
              result.gsub(/\\x(\w{2})/){
                [Regexp.last_match.captures.first.to_i(16)].pack("C")}
            else
              result
            end
          end
          alias_method :to_yaml_without_decode, :to_yaml
          alias_method :to_yaml, :to_yaml_with_decode
        end
      }
    }
  end
end

yaml_waml.run
