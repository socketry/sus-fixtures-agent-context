# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "sus/fixtures/async/scheduler_context"
require "sus/fixtures/agent/context"

describe Sus::Fixtures::Agent::Context do
	include Sus::Fixtures::Agent::Context
	
	let(:fixtures_path) {File.expand_path("../../../../context", __dir__)}
	
	with "sus context" do
		let(:context_path) {File.expand_path("getting-started.md", fixtures_path)}
		
		it "explains how to write an agent context test" do
			with_agent_context(context_path) do |session|
				response = session.call("What is the method to create a new agent context session in a test?")
				expect(response).to be =~ /with_agent_context/
			end
		end
	end
end
