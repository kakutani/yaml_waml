Gem::Specification.new do |s|
  s.name     = "yaml_waml"
  s.version  = "0.3.0"
  s.date     = "2008-09-03 20:00:00"
  s.summary  = "'to_yaml' workaround for multibyte UTF-8 string."
  s.email    = "shintaro@kakutani.com"
  s.homepage = "http://github.com/kakutani/yaml_waml/"
  s.description = "Plugin gem to workaround for fixing output result of 'to_yaml' method treats multibyte UTF-8 string(such as japanese) as binary. "
  s.has_rdoc = false
  s.authors  = ["KAKUTANI Shintaro"]
  s.files    = %w(init.rb install.rb lib/yaml_waml.rb MIT-LICENSE Rakefile README.rdoc tasks/yaml_waml_tasks.rake)
end
