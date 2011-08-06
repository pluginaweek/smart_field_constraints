$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'smart_field_constraints/version'

Gem::Specification.new do |s|
  s.name              = "smart_field_constraints"
  s.version           = SmartFieldConstraints::VERSION
  s.authors           = ["Aaron Pfeifer"]
  s.email             = "aaron@pluginaweek.org"
  s.homepage          = "http://www.pluginaweek.org"
  s.description       = "Intelligently applies a maxlength attribute for text fields based on column constraints and validations"
  s.summary           = "Automatic length constraints for text fields in ActionPack"
  s.require_paths     = ["lib"]
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- test/*`.split("\n")
  s.rdoc_options      = %w(--line-numbers --inline-source --title smart_field_constraints --main README.rdoc)
  s.extra_rdoc_files  = %w(README.rdoc CHANGELOG.rdoc LICENSE)
end
