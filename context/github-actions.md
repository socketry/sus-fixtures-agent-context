# GitHub Actions

This guide explains how to integrate the `sus-fixtures-agent-context` gem with GitHub Actions for testing agent contexts.

## Workflow

In order to use this gem in GitHub Actions, you can set up a workflow that includes the Ollama server. Here is an example of how to configure your `.github/workflows/test-agent-context.yaml`:

```yaml
name: Test Agent Context

on:
  push:
    paths:
      - 'context/**'
      - 'test/.agent/**'
  pull_request:
    paths:
      - 'context/**'
      - 'test/.agent/**'

permissions:
  contents: read

jobs:
  test:
    name: Agent Context
    runs-on: ubuntu-latest
    
    services:
      ollama:
        image: ollama/ollama
        ports:
          - 11434:11434
    
    steps:
    - uses: actions/checkout@v4
    - uses: ruby/setup-ruby@v1
      with:
        ruby-version: ruby
        bundler-cache: true
    
    - name: Pull Model
      run: bundle exec bake async:ollama:pull
    
    - name: Run tests
      timeout-minutes: 30
      run: bundle exec sus test/.agent/context
```

Note that the timeout is set to 30 minutes to allow sufficient time for the Ollama server to start and for the tests to run.
