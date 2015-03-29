begin
  require 'bones'
rescue LoadError
  abort '### please install the "bones" gem ###'
end

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'logging/plugins/email'

task :default => 'test:run'
task 'gem:release' => 'test:run'

Bones {
  name         'logging-email'
  summary      'An email appender for the Ruby Logging framework'
  authors      'Tim Pease'
  email        'tim.pease@gmail.com'
  url          'http://rubygems.org/gems/logging-email'
  version      Logging::Plugins::Email::VERSION

  use_gmail

  depend_on 'logging',   '~> 2.0'

  depend_on 'flexmock',  '~> 1.0', :development => true
  depend_on 'bones-git', '~> 1.3', :development => true
}
