# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{smart_field_constraints}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Pfeifer"]
  s.date = %q{2009-06-08}
  s.description = %q{Intelligently applies a maxlength attribute for text fields based on column constraints and validations}
  s.email = %q{aaron@pluginaweek.org}
  s.files = ["lib/smart_field_constraints", "lib/smart_field_constraints/extensions", "lib/smart_field_constraints/extensions/validations.rb", "lib/smart_field_constraints/extensions/form_helper.rb", "lib/smart_field_constraints.rb", "test/unit", "test/unit/validations_test.rb", "test/helpers", "test/helpers/form_helper_test.rb", "test/app_root", "test/app_root/app", "test/app_root/app/models", "test/app_root/app/models/user.rb", "test/app_root/vendor", "test/app_root/vendor/plugins", "test/app_root/vendor/plugins/tags", "test/app_root/vendor/plugins/tags/lib", "test/app_root/vendor/plugins/tags/lib/tag.rb", "test/app_root/vendor/plugins/tags/init.rb", "test/app_root/db", "test/app_root/db/migrate", "test/app_root/db/migrate/001_create_users.rb", "test/app_root/db/migrate/002_create_tags.rb", "test/app_root/config", "test/app_root/config/environment.rb", "test/test_helper.rb", "CHANGELOG.rdoc", "init.rb", "LICENSE", "Rakefile", "README.rdoc"]
  s.has_rdoc = true
  s.homepage = %q{http://www.pluginaweek.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pluginaweek}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Intelligently applies a maxlength attribute for text fields based on column constraints and validations}
  s.test_files = ["test/unit/validations_test.rb", "test/helpers/form_helper_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
