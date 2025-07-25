
require_relative "context/session"

module Sus
	module Fixtures
		module Agent
			module Context
				AGENT_PATH = "agent.md"
				
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
