# API Troubleshooting Guide

## Issue: "invalid URL" Error in Mintlify

### Root Cause
The `baseUrl` in `docs.json` was including `/api/v1`, but the MDX frontmatter also included `/api/v1` in the paths, causing duplicate path segments.

### Solution Applied ✅
Changed `docs.json`:
```json
"api": {
  "baseUrl": "https://api.mor.org"  // Removed /api/v1 suffix
}
```

Now Mintlify correctly constructs URLs:
- `https://api.mor.org` + `/api/v1/models` = `https://api.mor.org/api/v1/models` ✅

### After Fixing
**You must restart Mintlify dev server** for changes to take effect:
```bash
# Kill any running Mintlify processes
pkill -f mintlify

# Restart the dev server
cd /Users/prometheus/Documents/Morpheus/api-gateway-docs
mintlify dev
```

---

## Issue: "Could not validate credentials" Error

This is a **different error** that indicates the API URL is working correctly but there's an authentication problem.

### Common Causes

1. **Invalid API Key Format**
   - ✅ Correct: `Bearer sk-GgIB1x.6a6d3d463eaf9280031e179cb4b79bbd3586cb4a813813e824ec691915fa0865`
   - ❌ Wrong: Just `sk-GgIB1x...` without "Bearer "
   - ❌ Wrong: Extra spaces or line breaks

2. **Expired or Inactive API Key**
   - The API key may have been deactivated
   - Check your API keys at the dashboard

3. **Using Wrong Authentication Type**
   - **API Key** (`sk-xxx`) → For models, chat, sessions
   - **JWT Bearer Token** → For auth endpoints, user management

### How to Test Your API Key

#### Test 1: Verify API Key is Active
```bash
# This should work if your key is valid
curl -X GET "https://api.mor.org/api/v1/models" \
  -H "Authorization: Bearer YOUR_API_KEY_HERE"
```

**Expected Success Response:**
```json
{
  "object": "list",
  "data": [
    {
      "id": "llama-3.3-70b",
      "object": "model",
      "created": 1234567890,
      "owned_by": "morpheus-ai"
    }
  ]
}
```

**Expected Error Response (Invalid Key):**
```json
{
  "detail": "Could not validate credentials"
}
```

#### Test 2: Check Your Authentication Headers
```bash
# Print just the request headers to verify format
curl -v -X GET "https://api.mor.org/api/v1/models" \
  -H "Authorization: Bearer sk-YOUR_KEY" \
  2>&1 | grep "Authorization"
```

Should show:
```
> Authorization: Bearer sk-YOUR_KEY
```

### Getting a Valid API Key

1. **Log in to the dashboard** (requires OAuth/JWT)
2. **Navigate to API Keys section**
3. **Create a new API key**
4. **Copy the full key** (starts with `sk-`)
5. **Save it securely** (you won't be able to see it again)

### Authentication Flowchart

```
┌─────────────────────────────────────┐
│ What are you trying to access?     │
└──────────────┬──────────────────────┘
               │
       ┌───────┴───────┐
       │               │
       ▼               ▼
┌──────────┐   ┌──────────────┐
│ Models   │   │ User Account │
│ Chat     │   │ API Keys     │
│ Sessions │   │ Settings     │
└────┬─────┘   └─────┬────────┘
     │               │
     ▼               ▼
  Use API Key    Use JWT Token
  (sk-xxx...)    (from OAuth)
     │               │
     ▼               ▼
Authorization:  Authorization:
Bearer sk-xxx   Bearer eyJhbG...
```

---

## Testing Checklist

Before reporting issues, verify:

- [ ] API key starts with `sk-`
- [ ] Using `Bearer` prefix in Authorization header
- [ ] No extra spaces or line breaks in the header
- [ ] API key is active (not deleted/deactivated)
- [ ] Using correct auth type for the endpoint
- [ ] Mintlify dev server has been restarted after config changes
- [ ] Browser cache cleared (if testing in browser)

---

## Quick Test Commands

### Test Models Endpoint
```bash
curl -X GET "https://api.mor.org/api/v1/models" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

### Test Chat Completion
```bash
curl -X POST "https://api.mor.org/api/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama-3.3-70b",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

### Test CORS Configuration
```bash
curl -X GET "https://api.mor.org/cors-check" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

---

## Still Having Issues?

1. **Open the test page** in your browser:
   ```bash
   open /Users/prometheus/Documents/Morpheus/api-gateway-docs/test-api.html
   ```

2. **Check browser console** for detailed error messages (F12 → Console tab)

3. **Contact Support** at devs@mor.org with:
   - The exact error message
   - The endpoint you're trying to access
   - Your API key prefix (first 10 characters only)
   - Screenshots of the error

---

## Configuration Summary

### Current Setup
- **Base URL**: `https://api.mor.org`
- **API Version**: `/api/v1`
- **Full Endpoint Example**: `https://api.mor.org/api/v1/models`
- **Proxy Mode**: `false` (direct browser requests - requires CORS)

### Files Updated
- ✅ `docs.json` - Fixed baseUrl to `https://api.mor.org` and set `proxy: false`
- ✅ `openapi.json` - Fixed server URL to `https://api.mor.org`
- ✅ `api-reference/introduction.mdx` - Updated documentation
- ✅ `test-api.html` - Created test page

### CORS Configuration Required

Since we're using `proxy: false`, the API must allow requests from `http://localhost:3000` (Mintlify dev server).

**Required CORS Headers:**
```
Access-Control-Allow-Origin: http://localhost:3000
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
Access-Control-Allow-Headers: Content-Type, Authorization
Access-Control-Allow-Credentials: true
```

**If CORS is not configured**, you'll get errors like:
```
Access to fetch at 'https://api.mor.org/api/v1/models' from origin 'http://localhost:3000' 
has been blocked by CORS policy
```

**Contact your backend team** to add `http://localhost:3000` to the API's allowed origins list.

### Alternative: Use Proxy Mode

If you can't configure CORS, you can use proxy mode instead:

```json
"api": {
  "playground": {
    "proxy": true
  }
}
```

With proxy mode, requests go through Mintlify's proxy server instead of directly from your browser.

### Next Steps
1. **Restart Mintlify**: `mintlify dev`
2. **Test with a valid API key**
3. **If you get CORS errors**: Contact backend team to add `http://localhost:3000` to allowed origins
4. **Alternative**: Use proxy mode (but this has the "invalid URL" bug)

