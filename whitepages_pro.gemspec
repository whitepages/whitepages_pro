# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'whitepages_pro/version'

Gem::Specification.new do |s|
  s.name = 'whitepages_pro'
  s.version = WhitepagesPro::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Matt Woodward']
  s.email = ['mwoodward@whitepages.com']
  s.homepage = 'https://github.com/whitepages/whitepages_pro'
  s.summary = 'Ruby interfaces for WhitePagesPRO web services.'
  s.description = "WhitePagesPRO provides lookup and anti-fraud APIs. For API access, please contact pro-sales@whitepages.com"
  s.licenses = ['BSD']
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc']

  s.files = Dir.glob("{lib,spec}/**/*") + ['README.rdoc', 'LICENSE.txt', 'Rakefile']
  s.require_paths = ['lib']
end
