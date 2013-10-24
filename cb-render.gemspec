lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cb-render/version'

Gem::Specification.new do |s|
  s.name = "cb-render"
  s.version = CB::Render::VERSION
  s.authors = ["Adrien THERY", "Nicolas NARDONE", "Sebastien NEUSCH"]
  s.email = 'contact@contentbird.com'
  s.summary = "Helper JS and CSS to render contentbird objects including usage of Redcarpet, Pygments and Rainbow"
  s.homepage = "http://github.com/contentbird/cb-render"
  s.license = ""

  s.add_runtime_dependency     'sass-rails',  '= 4.0'
  s.add_runtime_dependency     'pygments.rb', '~> 0.5'
  s.add_runtime_dependency     'redcarpet',   '~> 3.0'

  s.files      = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
end
