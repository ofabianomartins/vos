Gem::Specification.new do |s|
  s.name        = 'vos'
  s.version     = '0.4.3'
  s.summary     = "Vos!"
  s.description = "A Vortual File System"
  s.authors     = ["Fabiano Martins"]
  s.email       = 'fabiano@investtools.com.br'
  s.files       = ["lib/vos.rb"]
  s.homepage    = 'https://github.com/fabianoinvesttools/vos'
  s.license     = 'MIT'

  s.add_development_dependency 'bundler', '~> 1.17.3'
  s.add_dependency 'aws-sdk-s3'
end
