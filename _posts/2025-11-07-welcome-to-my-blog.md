---
layout: post
title:  "Welcome to My Blog!"
date:   2025-12-28 12:00:00 +0800
categories: Agent
tags: [Gemini, Agent]
---

# Google Gemini Agent

## From Prompt to Action

This blog post introduces the Google Gemini Agent, a powerful tool that leverages Google's Gemini models to perform various tasks through natural language prompts. Whether you want to generate text, analyze data, or automate workflows, the Gemini Agent can help you achieve your goals efficiently.

### Environment Setup

Create an API key in [Google AI Studio](https://ai.google/studio).
Install the ADK package:
```bash
pip install google-adk
```
Import necessary modules:
```python
from google.adk.agents import Agent
from google.adk.models.google_llm import Gemini
from google.adk.runners import InMemoryRunner
from google.adk.tools import google_search
from google.genai import types
```

### How to Create an Agent

Three steps in total: Http Config, Agent Config, Runner Config.
1. **Http Config**: Set up the HTTP configuration. When it encounters transient errors, it will retry according to the specified parameters.
```python
retry_config=types.HttpRetryOptions(
    attempts=5,  # Maximum retry attempts
    exp_base=7,  # Delay multiplier
    initial_delay=1, # Initial delay before first retry (in seconds)
    http_status_codes=[429, 500, 503, 504] # Retry on these HTTP errors
)
```
2. **Agent Config**: Define the agent's behavior, including the model to use and the tools available. 

These are the main properties we'll set:

- **name** and **description**: A simple name and description to identify our agent.
- **model**: The specific LLM that will power the agent's reasoning. We'll use "gemini-2.5-flash-lite".
- **instruction**: The agent's guiding prompt. This tells the agent what its goal is and how to behave.
- **tools**: A list of [tools](https://google.github.io/adk-docs/tools/) that the agent can use. To start, we'll give it the `google_search` tool, which lets it find up-to-date information online.

To learn more, check out the documentation related to [agents in ADK](https://google.github.io/adk-docs/agents/).
```python

agent_config = Agent(
    name="helpful_assistant",
    model=Gemini(
        model="gemini-2.5-flash-lite",
        retry_options=retry_config
    ),
    description="A simple agent that can answer general questions.",
    instruction="You are a helpful assistant. Use Google Search for current info or if unsure.",
    tools=[google_search],
)
```

3. **Runner Config**: Finally, we set up the runner that will execute our agent's tasks. We'll use an in-memory runner for simplicity.
```python
runner = InMemoryRunner(agent=agent_config)
```

### Running the Agent
Now that we have our agent and runner set up, we can start using it to answer questions. Here's how to do that:
```python
response = runner.run("Who won the Nobel Prize in Literature in 2023?")
```

### Bonus: ADK Web Interface!
ADK also provides a web interface to interact with your agents visually. To launch the web interface, we first need to create a sample agent using the ADK CLI:
```bash
adk create sample-agent --model gemini-2.5-flash-lite --api_key $GOOGLE_API_KEY
```
get a URL to access the web interface.
```python
url_prefix = get_adk_proxy_url()
print(f"Access the ADK web interface at: {url_prefix}")
```
Launch the web interface with the url_prefix:
```
adk web --url_prefix {url_prefix}
```
To be noticed, this web interface don't have the tool function now, so the agent can't use tools like google search in web interface. 

## Agent Architectures
