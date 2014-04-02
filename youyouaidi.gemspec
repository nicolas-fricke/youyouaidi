Gem::Specification.new do |s|
  s.name        = 'youyouaidi'
  s.version     = '0.0.0'
  s.date        = '2014-04-02'
  s.summary     = "UUID class"
  s.description = "Youyouaidi offers a UUID class for parsing, validating and encoding UUIDs"
  s.authors     = ["Nicolas Fricke"]
  s.email       = %w(mail@nicolasfricke.de)
  s.files       = ["lib/youyouaidi.rb", "lib/youyouaidi/uuid.rb"]
  s.license     = 'MIT'

  s.add_development_dependency 'bundler', '~> 1.3'
end