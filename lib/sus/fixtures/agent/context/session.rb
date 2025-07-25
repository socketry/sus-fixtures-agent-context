

require "async/ollama"

module Sus
	module Fixtures
		module Agent
			module Context
				class Session
					CONTEXT_PROMPT = <<~PROMPT
						This is a test. You are going to be provided with context from a file.
						You will then be asked questions and should use that context to answer them.
						Your answer must only use information from the provided context.
					PROMPT

					def initialize(model: nil)
						@model = model || "llama3"
						@client = ::Async::Ollama::Client.open
						@current = nil
					end

					def ask(question)
						if @current
							@current = @current.generate(question)
						else
							@current = @client.generate(question, model: @model)
						end
						
						return @current.response
					end
					
					def load_context_path(path)
						::File.read(path).tap do |content|
							ask(CONTEXT_PROMPT + "\n---\n\n#{content}")
						end
					end

					def close
						@client.close if @client
					end
				end
			end
		end
	end
end