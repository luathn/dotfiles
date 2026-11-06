#!/bin/bash

url="https://openrouter.ai/api/v1/chat/completions"
model="qwen/qwen3.7-flash"
timeout_seconds=10

# Errors go to stdout so that they show in the zsh buffer (see ai_helper in zshrc)
fail() {
  echo "Error: $1"
  exit 1
}

command -v jq &> /dev/null || fail "jq is not installed."
[ -n "$OPENROUTER_API_KEY" ] || fail "OPENROUTER_API_KEY is not set."
[ $# -gt 0 ] || fail "No input provided."

# Send all arguments as one prompt. The key stays out of the process list.
response=$(
  jq -n --arg model "$model" --arg input "$*" '{
    model: $model,
    max_tokens: 500,
    reasoning: { enabled: false },
    messages: [{ role: "user", content: $input }]
  }' | curl -sS "$url" \
    --max-time "$timeout_seconds" \
    -H "Content-Type: application/json" \
    --variable %OPENROUTER_API_KEY \
    --expand-header "Authorization: Bearer {{OPENROUTER_API_KEY}}" \
    --data-binary @- 2>&1
) || fail "Request failed: $response"

content=$(jq -r '.choices[0].message.content // empty' <<< "$response" 2> /dev/null)
if [ -z "$content" ]; then
  fail "OpenRouter: $(jq -r '.error.message // empty' <<< "$response" 2> /dev/null || echo "$response")"
fi

echo "$content"
