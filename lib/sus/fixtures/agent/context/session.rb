

require "async/ollama"
require "async/ollama/conversation"

module Sus
	module Fixtures
		module Agent
			module Context
				class Session
					CONTEXT_PROMPT = <<~PROMPT
						You are a documentation-aware assistant tasked with answering questions strictly based on the provided context.
						
						The context you are given is the sole source of truth. It defines how the system behaves, what features exist, and how they are used.
						
						- Do not rely on your prior training or general knowledge.
						- If the answer cannot be inferred from the context, say: “The context does not contain enough information to answer this.”
						- Do not speculate, assume, or generalize beyond what is written in the context.
						
						Your responses should be clear, concise, and strictly grounded in the information provided. Prioritize accuracy over completeness or fluency.
					PROMPT
					
					def initialize(**options)
						# Remove as much non-determinism as possible:
						options[:temperature] = 0.0
						
						@client = ::Async::Ollama::Client.open
						@conversation = ::Async::Ollama::Conversation.new(@client, **options)
					end
					
					attr :conversation
					
					def call(prompt)
						chat = @conversation.call(prompt)
						
						return chat.response
					end
					
					def load_context_path(path)
						::File.read(path).tap do |content|
							@conversation.messages << {
								role: "system",
								content: CONTEXT_PROMPT + "\n\n--- The context follows:\n\n" + content
							}
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