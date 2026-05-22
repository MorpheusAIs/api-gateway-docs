# Mintlify Development Setup

## Issue: Node.js Version Compatibility

Mintlify requires Node.js v18 or v20 (LTS versions). Node.js v25+ is not supported and will cause errors.

## Solution: Use Node.js v20 with nvm

### Quick Start

1. **Navigate to the project directory:**
   ```bash
   cd /Users/prometheus/Documents/Morpheus/api-gateway-docs
   ```

2. **Use Node.js v20 (reads from .nvmrc automatically):**
   ```bash
   nvm use
   ```

3. **Start the Mintlify dev server:**
   ```bash
   npx mintlify@latest dev
   ```

### Alternative: Run in One Command

```bash
cd /Users/prometheus/Documents/Morpheus/api-gateway-docs && nvm use && npx mintlify@latest dev
```

## What We've Fixed

1. ✅ Created `.nvmrc` file with Node v20.18.3
2. ✅ Uninstalled incompatible global `mint` package
3. ✅ Set up Node v20 as an available version in nvm

## Why This Happens

- Your system has Node.js v25.2.1 installed via Homebrew
- Mintlify doesn't support Node v25+ yet
- The globally installed `mint` command was linked to the system Node version
- Using `npx` with `nvm use` ensures the correct Node version is used

## Troubleshooting

### Error: "mint dev is not supported on node versions 25+"

**Solution:** Make sure you run `nvm use` first:
```bash
nvm use
npx mintlify@latest dev
```

### Error: "nvm: command not found"

**Solution:** Install nvm first:
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
```

Then restart your terminal and install Node v20:
```bash
nvm install 20.18.3
```

### Still Having Issues?

1. **Check your current Node version:**
   ```bash
   node --version
   ```
   Should show `v20.18.3` after running `nvm use`

2. **Verify nvm is working:**
   ```bash
   nvm current
   ```
   Should show `v20.18.3`

3. **Start fresh in a new terminal:**
   - Open a new terminal window
   - Navigate to project directory
   - Run `nvm use && npx mintlify@latest dev`

## Viewing Your Site

Once the dev server starts successfully, you'll see:
```
✓ Mintlify is running on http://localhost:3000
```

Open your browser to view your documentation site with all the GEO optimizations!

## Production Deployment

For production, Mintlify's hosted service automatically uses the correct Node version. The `.nvmrc` file ensures compatibility if you're deploying elsewhere.

## Need Help?

If you're still experiencing issues, contact:
- Mintlify Support: https://mintlify.com/docs
- Or check their Discord community
