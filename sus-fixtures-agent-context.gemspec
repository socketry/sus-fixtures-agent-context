# frozen_string_literal: true

require_relative "lib/sus/fixtures/agent/context/version"

Gem::Specification.new do |spec|
	spec.name = "sus-fixtures-agent-context"
	spec.version = Sus::Fixtures::Agent::Context::VERSION
	
	spec.summary = "Test fixtures for running in Async."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.cert_chain  = ["release.cert"]
	spec.signing_key = File.expand_path("~/.gem/release.pem")
	
	spec.homepage = "https://github.com/socketry/sus-fixtures-async"
	
	spec.metadata = {
		"documentation_uri" => "https://socketry.github.io/sus-fixtures-async/",
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
		"source_code_uri" => "https://github.com/socketry/sus-fixtures-async.git",
	}
	
	spec.files = Dir.glob(["{context,lib}/**/*", "*.md"], File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 3.2"
	
	spec.add_dependency "async-ollama", "~> 0.8"
	spec.add_dependency "sus", "~> 0.10"
end
