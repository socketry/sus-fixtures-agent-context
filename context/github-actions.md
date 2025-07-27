# GitHub Actions

This guide explains how to integrate the `sus-fixtures-agent-context` gem with GitHub Actions for testing agent contexts.

## Workflow

In order to use this gem in GitHub Actions, you can set up a workflow that includes the Ollama server. Here is an example of how to configure your `.github/workflows/test.yml`:

```yaml
name: Test Agent Context

on: [push, pull_request]

permissions:
  contents: read

jobs:
  test:
    name: Agent Context
    runs-on: ${{matrix.os}}-latest
    continue-on-error: ${{matrix.experimental}}
    
    services:
      ollama:
        image: ollama/ollama
        ports:
          - 11434:11434
    
    strategy:
      matrix:
        os:
          - ubuntu
        
        ruby:
          - "3.4"
        
        experimental: [false]
        
        include:
          - os: ubuntu
            ruby: head
            experimental: true
    
    steps:
    - uses: actions/checkout@v4
    - uses: ruby/setup-ruby@v1
      with:
        ruby-version: ${{matrix.ruby}}
        bundler-cache: true
    
    - name: Pull Model
      run: bundle exec bake async:ollama:pull
    
    - name: Run tests
      timeout-minutes: 30
      run: bundle exec sus test/.agent/context
```

Note that the timeout is set to 30 mintues to allow sufficient time for the Ollama server to start and for the tests to run.
