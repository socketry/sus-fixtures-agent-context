# Getting Started

This guide explains how to use the `sus-fixtures-agent-context` gem to test agent contexts.

## Installation

Add the gem to your project:

```bash
bundle add sus-fixtures-agent-context
```

You will need a locally accessible Ollama server to use this gem, as it relies on the `Async::Ollama` client to interact with agents. Make sure you have Ollama installed and running.

### GitHub Actions

In order to use this gem in GitHub Actions, you can set up a workflow that includes the Ollama server. Here is an example of how to configure your `.github/workflows/test.yml`:

```yaml
steps:
	- name: Set up Ollama
		run: |
			docker run -d --name ollama -p 11434:11434 ollama/ollama:latest
			sleep 10 # Wait for the server to start

	- name: Run tests
		run: bundle exec sus
```

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
