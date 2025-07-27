# Getting Started

This guide explains how to use the `sus-fixtures-agent-context` gem to test agent contexts.

## Installation

Add the gem to your project:

```bash
bundle add sus-fixtures-agent-context
```

You will need a locally accessible Ollama server to use this gem, as it relies on the `Async::Ollama` client to interact with agents. Make sure you have Ollama installed and running.

## Testing Agent Contexts

This gem provides a convenient way to test whether a given context is sufficient for an agent to perform a task. It uses the `Async::Ollama` client to interact with agents. So you will need to have an Ollama server running and accessible.

```ruby
include Sus::Fixtures::Agent::Context

it "can use the with_agent_context fixture" do
	# The path is relative to the working directory by default.
	with_agent_context("context/getting-started.md") do |session|
		response = session.call("Write an expectation that checks if an `array` contains an `item`.")
		expect(response).to be ==~ /expect\(array\).to be(:include?, item\)/
	end
end
```

It is recommended that you put these tests in `test/.agent/context` directory, and they must be run explicitly with `sus test/.agent/context`. By default, `sus` will not recurse into directories starting with a dot, so this is an acceptable way to organize your tests.
