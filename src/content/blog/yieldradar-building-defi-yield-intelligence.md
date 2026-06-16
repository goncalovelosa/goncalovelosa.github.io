---
title: "YieldRadar: Building a DeFi Yield Intelligence Bot"
description: "How I built a multi-factor risk scoring system for 18K+ DeFi yield pools, from scratch to production Telegram bot."
pubDate: 2026-05-06
category: "DeFi"
tags: ["defi", "typescript", "telegram", "risk-scoring", "yield"]
---

Finding good DeFi yields is easy. Finding *safe* ones isn't.

There are 18,000+ liquidity pools across chains. Most yield aggregators show APY and nothing else. But APY without risk context is dangerous — that 200% yield might come from an unaudited contract with a rugpull-able token.

## The Problem

I wanted:
- Real-time monitoring of yield pools across multiple chains
- Risk assessment that goes beyond "APY looks good"
- Push notifications when opportunities match my criteria
- All from Telegram, because that's where I live

No existing tool did this. DeFiLlama has great data but no alerting. Trading bots on Telegram focus on buying/selling, not yield monitoring. Dashboard apps (DeBank, Zapper) require you to open them — no push.

## The Architecture

**Data pipeline:** DeFiLlama API → TypeScript ingestion → Redis caching → Multi-factor scoring engine → Telegram delivery

**Risk scoring factors:**
1. **Pool age** — new pools are riskier
2. **TVL stability** — volatile TVL = unstable yields
3. **Token security** — mintable, honeypot, proxy contracts (via GoPlus)
4. **APY sustainability** — comparing 24h vs 7d vs 30d APY trends
5. **Chain risk** — L2 vs L1 considerations

**Tech stack:** TypeScript, Node.js, SQLite (via better-sqlite3), Redis, Telegram Bot API, DeFiLlama API, GoPlus Security API

## What I Learned

- **Data normalization is the hard part.** Every chain reports APY differently. Some include fee APY, some don't. Some report in real terms, others in nominal. Normalizing 18K+ pools into a consistent format took more work than the entire scoring engine.
- **API rate limits are brutal.** GoPlus gives you 4K requests/day on free tier. When you're scoring thousands of pools, you need aggressive caching and smart queue management.
- **Telegram is a surprisingly good delivery surface.** Inline keyboards, digest formatting, user preferences — it's a full UX platform.

## What's Next

Pivoting from a Telegram bot to a proper API product. The data pipeline and scoring engine are the real value — wrapping them in a REST/GraphQL API for portfolio trackers and integrators to consume.

More on that soon.
