require "sus/fixtures/async/scheduler_context"
require "sus/fixtures/agent/context"

describe Sus::Fixtures::Agent::Context do
	include Sus::Fixtures::Async::SchedulerContext
	
	def timeout
		nil
	end
	
	include Sus::Fixtures::Agent::Context
	
	let(:fixtures_path) {File.expand_path(".fixtures", __dir__)}
	
	with "sus context" do
		let(:context_path) {File.expand_path("sus.md", fixtures_path)}
		
		it "correctly implement an array expectation" do
			with_agent_context(context_path) do |session|
				response = session.call("How do I write a Sus expectation for checking if an Array `array` includes an `item`?")
				expect(response).to be(:include?, "expect(array).to be(:include?, item)")
			end
		end
		
		it "correctly implement a hash expectation" do
			# Try repeating several times and report on quality > 80% success is pass.
			with_agent_context(context_path) do |session|
				response = session.call("How do I write a Sus expectation for checking if a Hash `hash` includes a key `:key`?")
				inform session.conversation.token_count
				expect(response).to be(:include?, "expect(hash).to have_keys(:key)")
			end
		end
	end
end
