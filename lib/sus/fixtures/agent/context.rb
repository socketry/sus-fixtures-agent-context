# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require_relative "context/session"

# @namespace
module Sus
	# @namespace
	module Fixtures
		# @namespace
		module Agent
			# @namespace
			module Context
				include Sus::Fixtures::Async::SchedulerContext
				
				# @constant [String] The default path to the agent context file.
				AGENT_PATH = "agent.md"
				
				# @returns [Integer] the default timeout for agent-based tests, in seconds.
				def timeout
					# 10 minutes - we don't expect tests to actually take this long, but sometimes Ollama has to load models which can take an exceptionally long time depending on the model size and hardware.
					60*10
				end
				
				# Yields a session with the agent context loaded from the given path or the default {AGENT_PATH}.
				# Ensures the session is closed after the block.
				# @parameter path [String | nil] The path to the context file to load.
				# @parameter options [Hash] Additional options for the session.
				# @yields {|session| ...} Yields the session with the loaded context.
				# 	@parameter session [Session] The session with the loaded context.
				def with_agent_context(path = nil, **options, &block)
					session = Session.new(**options)
					
					if path
						session.load_context_path(path)
					end
					
					yield session
				ensure
					session&.close
				end
			end
		end
	end
end
