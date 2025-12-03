#!/bin/bash

# Morpheus API Test Script
# Usage: ./test-api.sh YOUR_API_KEY

if [ -z "$1" ]; then
    echo "❌ Error: API key required"
    echo "Usage: ./test-api.sh YOUR_API_KEY"
    exit 1
fi

API_KEY="$1"
BASE_URL="https://api.mor.org/api/v1"

echo "🚀 Testing Morpheus API Gateway"
echo "================================"
echo ""

# Test 1: List Models
echo "📋 Test 1: List Models"
echo "Endpoint: GET $BASE_URL/models"
echo ""
RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" \
    -X GET "$BASE_URL/models" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json")

HTTP_CODE=$(echo "$RESPONSE" | grep "HTTP_CODE:" | cut -d: -f2)
BODY=$(echo "$RESPONSE" | sed '/HTTP_CODE:/d')

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ Status: $HTTP_CODE OK"
    echo "$BODY" | python3 -m json.tool 2>/dev/null | head -20
    MODEL_COUNT=$(echo "$BODY" | python3 -c "import sys, json; print(len(json.load(sys.stdin).get('data', [])))" 2>/dev/null)
    echo "..."
    echo "Total models: $MODEL_COUNT"
else
    echo "❌ Status: $HTTP_CODE"
    echo "$BODY" | python3 -m json.tool 2>/dev/null || echo "$BODY"
fi

echo ""
echo "================================"
echo ""

# Test 2: Chat Completion
echo "💬 Test 2: Chat Completion"
echo "Endpoint: POST $BASE_URL/chat/completions"
echo ""
RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" \
    -X POST "$BASE_URL/chat/completions" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
        "model": "llama-3.3-70b",
        "messages": [
            {"role": "user", "content": "Say hello in one sentence!"}
        ],
        "max_tokens": 50
    }')

HTTP_CODE=$(echo "$RESPONSE" | grep "HTTP_CODE:" | cut -d: -f2)
BODY=$(echo "$RESPONSE" | sed '/HTTP_CODE:/d')

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ Status: $HTTP_CODE OK"
    echo "$BODY" | python3 -m json.tool 2>/dev/null
else
    echo "❌ Status: $HTTP_CODE"
    echo "$BODY" | python3 -m json.tool 2>/dev/null || echo "$BODY"
fi

echo ""
echo "================================"
echo ""

# Test 3: CORS Check
echo "🔒 Test 3: CORS Configuration"
echo "Endpoint: GET https://api.mor.org/cors-check"
echo ""
RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" \
    -X GET "https://api.mor.org/cors-check" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Origin: http://localhost:8080")

HTTP_CODE=$(echo "$RESPONSE" | grep "HTTP_CODE:" | cut -d: -f2)
BODY=$(echo "$RESPONSE" | sed '/HTTP_CODE:/d')

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ Status: $HTTP_CODE OK"
    echo "$BODY" | python3 -m json.tool 2>/dev/null
else
    echo "❌ Status: $HTTP_CODE"
    echo "$BODY" | python3 -m json.tool 2>/dev/null || echo "$BODY"
fi

echo ""
echo "================================"
echo "✨ Testing complete!"
echo ""












