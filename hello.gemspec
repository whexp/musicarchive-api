require "rake"

Gem::Specification.new do |s|
    s.name        = "contx_server"
    s.version     = "0.1.0"
    s.date        = "2015-09-21"
    s.summary     = "Hello API"
    s.authors     = ["Anthony Roy", "David Collom"]
    s.description = "API to respond Hello"
    s.email       = "anthony.roy@williamhill.com"
    s.files       = FileList[
        'lib/**/*.rb',
        'lib/**/*.yaml',
        'lib/**/*.erb',
        'lib/images/**/*',
        'lib/js/**/*',
        'bin/*'
    ].to_a

    s.executables << 'hello_api.ru'

    s.add_dependency('netaddr',           '1.5.0')
    s.add_dependency('rack',              '1.5.2')
    s.add_dependency('grape',             '0.6.1')

    s.add_development_dependency 'rspec', '~> 3.0'
    s.add_development_dependency 'rspec-core',              '~> 3.0'
    s.add_development_dependency 'rspec-mocks',             '~> 3.0'
    s.add_development_dependency 'rspec-expectations',      '~> 3.0'
    s.add_development_dependency 'rake',  '~> 10.3'
    s.add_development_dependency 'simplecov'
end
