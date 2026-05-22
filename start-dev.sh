#!/bin/bash

# Mintlify Dev Server Starter Script
# This script ensures the correct Node.js version is used

# Source nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Delete prefix if needed
nvm use --delete-prefix v20.18.3 --silent 2>/dev/null

# Use Node 20.18.3
nvm use 20.18.3

# Ensure nvm's Node takes precedence over Homebrew/system Node
export PATH="$NVM_DIR/versions/node/v20.18.3/bin:$PATH"

# Verify Node version
echo "✓ Using Node version: $(node --version)"
echo "✓ Using npm version: $(npm --version)"
echo "✓ Starting Mintlify dev server..."
echo ""

# Run Mintlify dev server using npx to ensure correct Node version
exec npx mintlify@latest dev
