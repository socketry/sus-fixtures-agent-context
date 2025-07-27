
require_relative "context/session"

module Sus
	module Fixtures
		module Agent
			module Context
				AGENT_PATH = "agent.md"
				
				def self.included(base)
					base.include(Sus::Fixtures::Async::SchedulerContext)
				end
				
				def timeout
					# 10 minutes - we don't expect tests to actually take this long, but sometimes Ollama has to load models which can take an exceptionally long time depending on the model size and hardware.
					60*10
				end
				
				def with_agent_context(context = nil, **options, &block)
					session = Session.new(**options)
					
					if context
						session.load_context_path(context)
					elsif File.exist?(AGENT_PATH)
						session.load_context_path(AGENT_PATH)
					end

					yield session
				ensure
					session&.close
				end
			end
		end
	end
end
