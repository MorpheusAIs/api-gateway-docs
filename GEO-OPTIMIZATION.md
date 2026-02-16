# Generative Engine Optimization (GEO) Guide

## What is GEO?

Generative Engine Optimization (GEO) is the practice of optimizing content to be discovered, understood, and cited by AI-powered search engines and language models like ChatGPT, Claude, Perplexity, Google's AI Overviews, and Bing Copilot.

## Implemented Optimizations

### 1. robots.txt Configuration ✅

Created `/robots.txt` that explicitly allows all major AI crawlers:

- **OpenAI**: GPTBot, ChatGPT-User
- **Google**: Googlebot, Google-Extended (for Gemini/Bard)
- **Anthropic**: ClaudeBot, Claude-Web
- **Perplexity**: PerplexityBot
- **Microsoft**: Bingbot (Bing + Copilot)
- **Meta**: FacebookBot, meta-externalagent
- **Apple**: Applebot-Extended
- **Cohere**: cohere-ai
- **Common Research**: CCBot

### 2. Enhanced Metadata in docs.json ✅

Added comprehensive SEO metadata including:

- Open Graph tags for social sharing
- Twitter Card metadata
- Rich descriptions with keywords
- Proper site identification

### 3. Existing GEO-Friendly Features ✅

Your site already has:

- Contextual AI integration (Perplexity, ChatGPT, Claude buttons)
- Google Analytics for tracking
- Well-structured navigation
- Clear, descriptive content

## Additional Recommendations

### 1. Enhance MDX File Metadata

Add rich frontmatter to your MDX files:

```yaml
---
title: "Clear, Specific Title"
description: "Detailed description with relevant keywords"
keywords: "keyword1, keyword2, keyword3"
author: "Morpheus Team"
date: "2024-12-03"
---
```

### 2. Structured Data (Schema.org)

Add JSON-LD structured data to key pages. Create a `head` section in your docs.json:

```json
"head": {
  "script": [
    {
      "type": "application/ld+json",
      "content": {
        "@context": "https://schema.org",
        "@type": "SoftwareApplication",
        "name": "Morpheus API Gateway",
        "applicationCategory": "DeveloperApplication",
        "description": "Free AI inference API compatible with OpenAI",
        "url": "https://api-gateway-docs.mor.org",
        "offers": {
          "@type": "Offer",
          "price": "0",
          "priceCurrency": "USD"
        }
      }
    }
  ]
}
```

### 3. Create a Comprehensive FAQ Page

AI models love FAQ formats. Create `/documentation/faq.mdx`:

```markdown
---
title: "Frequently Asked Questions"
description: "Common questions about Morpheus API Gateway"
---

<AccordionGroup>
<Accordion title="What is Morpheus API Gateway?">
Morpheus API Gateway is a free, OpenAI-compatible API that provides access to AI inference through the Morpheus Compute Marketplace...
</Accordion>

<Accordion title="How much does it cost?">
The API Gateway is completely free during the open beta program...
</Accordion>
</AccordionGroup>
```

### 4. Add "People Also Ask" Content

AI search engines prioritize content that answers common questions:

- "How to use Morpheus API Gateway"
- "Morpheus API Gateway vs OpenAI"
- "Free AI inference API"
- "How to integrate Morpheus with Cursor"

### 5. Create Integration Examples

Add concrete, copy-paste code examples in multiple languages:

```python
# Python example
import openai

client = openai.OpenAI(
    base_url="https://api.mor.org/api/v1",
    api_key="your-api-key-here"
)

response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "Hello!"}]
)
```

### 6. Add Comparison Tables

AI models understand structured comparisons:

| Feature | Morpheus API Gateway | OpenAI API |
|---------|---------------------|------------|
| Cost | Free | Paid |
| OpenAI Compatible | Yes | Yes |
| Decentralized | Yes | No |

### 7. Create a Glossary

Add `/documentation/glossary.mdx` with key terms:

```markdown
## MOR Token
The native token of the Morpheus ecosystem used for staking and payment...

## Compute Marketplace
A decentralized marketplace where providers offer AI inference services...
```

### 8. Add Sitemap Verification

Mintlify auto-generates sitemaps. Verify it's accessible at:
- `https://api-gateway-docs.mor.org/sitemap.xml`

### 9. Implement Semantic HTML

Ensure your MDX uses proper heading hierarchy:

```markdown
# Main Title (H1 - only one per page)
## Section (H2)
### Subsection (H3)
```

### 10. Add Related Content Links

At the end of each article, add:

```markdown
## Related Topics

- [Creating an API Key](/documentation/how-to/creating-api-key)
- [Integration with Cursor](/documentation/integrations/cursor)
- [API Reference](/api-reference/introduction)
```

## Content Strategy for GEO

### Use Natural Language

Write as if answering questions:

- ❌ "API Gateway configuration"
- ✅ "How to configure the Morpheus API Gateway"

### Include Long-Tail Keywords

- "free openai compatible api"
- "how to use morpheus api gateway with cursor"
- "decentralized ai inference api"

### Optimize for Voice Search

Include conversational phrases:

- "What is the Morpheus API Gateway?"
- "How do I create an API key for Morpheus?"
- "Can I use Morpheus API Gateway for free?"

### Add Date-Specific Content

AI models prioritize recent, timestamped content:

```markdown
---
title: "Morpheus API Gateway Updates - December 2024"
date: "2024-12-03"
---
```

## Measuring GEO Success

### Track These Metrics:

1. **AI Search Appearances**: Monitor mentions in:
   - Perplexity search results
   - ChatGPT responses
   - Claude responses
   - Google AI Overviews
   - Bing Copilot responses

2. **Referral Traffic**: Check Google Analytics for:
   - `perplexity.ai` referrals
   - `chat.openai.com` referrals
   - Direct traffic spikes after AI mentions

3. **Citation Quality**: Are AI models citing your docs with:
   - Correct information
   - Proper attribution
   - Direct links

## Testing Your GEO

### Test with AI Search Engines:

1. **Perplexity**: Search "morpheus api gateway documentation"
2. **ChatGPT**: Ask "how do I use morpheus api gateway"
3. **Claude**: Ask "what is morpheus compute marketplace"
4. **Google**: Check for AI Overviews on branded searches
5. **Bing**: Test Copilot with integration questions

## Next Steps

1. ✅ Deploy the updated `robots.txt` and `docs.json`
2. ⬜ Add structured data (JSON-LD)
3. ⬜ Create FAQ page
4. ⬜ Enhance MDX frontmatter
5. ⬜ Add comparison tables
6. ⬜ Create glossary
7. ⬜ Add integration examples in multiple languages
8. ⬜ Implement semantic content linking
9. ⬜ Monitor AI search appearances
10. ⬜ Iterate based on AI citation patterns

## Resources

- [Google Search Central - AI Overviews](https://developers.google.com/search/docs/appearance/ai-overviews)
- [Perplexity for Publishers](https://docs.perplexity.ai/docs/perplexity-for-publishers)
- [OpenAI GPTBot](https://platform.openai.com/docs/gptbot)
- [Anthropic Claude Web Crawler](https://support.anthropic.com/en/articles/8896518-does-anthropic-crawl-data-from-the-web)
- [Schema.org Documentation](https://schema.org/docs/gs.html)

## Questions?

For questions about GEO implementation, contact the Morpheus team at devs@mor.org or join the Discord community.
