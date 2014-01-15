# Encoding: UTF-8

require 'date'
require File.expand_path('../lib/refinery/newsletter_subscriptions/version', __FILE__)

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-newsletter_subscriptions'
  s.version           = '0.0.1'
  s.description       = 'Ruby on Rails Newsletter Subscriptions forms-extension for Refinery CMS'
  s.date              = Date.today.strftime("%Y-%m-%d")
  s.summary           = 'Newsletter Subscriptions forms-extension for Refinery CMS'
  s.authors           = ['Marek Labos']
  s.email             = 'nospam.keram@gmail.com'
  s.homepage          = 'https://www.github.com/muzicka/refinerycms-newsletter_subscriptions'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency    'refinerycms-core',     '~> 2.718.0.dev'
  s.add_dependency    'refinerycms-settings', '~> 2.718.0.dev'
end
