# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "async/ollama"
require "async/ollama/conversation"

module Sus
	module Fixtures
		module Agent
			module Context
				# Manages a conversation session with an agent, loading context and handling prompts.
				class Session
					# @constant [String] The system prompt used to instruct the agent on how to use the provided context.
					CONTEXT_PROMPT = <<~PROMPT
						You are a documentation-aware assistant tasked with answering questions strictly based on the provided context.
						
						The context you are given is the sole source of truth. It defines how the system behaves, what features exist, and how they are used.
						
						- Do not rely on your prior training or general knowledge.
						- If the answer cannot be inferred from the context, say: “The context does not contain enough information to answer this.”
						- Do not speculate, assume, or generalize beyond what is written in the context.
						
						Your responses should be clear, concise, and strictly grounded in the information provided. Prioritize accuracy over completeness or fluency.
					PROMPT
					
					# Initializes a new session for agent context interaction.
					# @option :temperatuire [Float] The temperature for the agent's responses (default is 0.0 for deterministic responses).
					# @option :model [String] The model to use for the agent (default is "llama3.1").
					def initialize(**options)
						# Remove as much non-determinism as possible:
						options[:temperature] = 0.0
						
						@client = ::Async::Ollama::Client.open
						@conversation = ::Async::Ollama::Conversation.new(@client, **options)
					end
					
					# @attribute [::Async::Ollama::Conversation] The conversation object for this session.
					attr :conversation
					
					# Sends a prompt to the agent and returns the response.
					# @parameter prompt [String] The prompt to send to the agent.
					# @returns [String] The agent's response.
					def call(prompt)
						chat = @conversation.call(prompt)
						
						return chat.response
					end
					
					# Loads a context file and appends it to the conversation as a system message.
					# @parameter path [String] The path to the context file.
					def load_context_path(path)
						::File.read(path).tap do |content|
							@conversation.messages << {
								role: "system",
								content: CONTEXT_PROMPT + "\n\n--- The context follows:\n\n" + content
							}
						end
					end
					
					# Closes the underlying client connection.
					def close
						@client.close if @client
					end
				end
			end
		end
	end
end
