---
title: "Composer 2.5 is the AI coding model most developers should actually use"
description: "At $20/month all three major AI coding tools cost the same. The difference is how far that budget goes. Composer 2.5 stretches your credits further than any competitor."
pubDate: 2026-06-03
category: "AI"
tags: ["ai-coding", "cursor", "composer-2.5", "deepseek-v4", "llm-benchmarks", "developer-tools"]
heroImage: "./composer-2-5-frontier-coding-at-commodity-pricing/images/cost-comparison.png"
mediumUrl: "https://medium.com/@gvelosa/composer-2-5-is-the-ai-coding-model-most-developers-should-actually-use-653a1ce9bf18"
canonicalUrl: "https://medium.com/@gvelosa/composer-2-5-is-the-ai-coding-model-most-developers-should-actually-use-653a1ce9bf18"
---
![Cover: a tiny brass washer casting an enormous warm shadow — small cost, massive impact](./composer-2-5-frontier-coding-at-commodity-pricing/images/cover.png)

The AI coding space has a new problem, and it's a good one: too many models are getting too good and too cheap, too fast.

When I first drafted this piece in late May, the Artificial Analysis Coding Agent Index had Cursor's Composer 2.5 sitting in third place with a score of 62. Claude Opus 4.7 led at 66. GPT-5.5 sat at 65. A tidy story: two expensive frontier models trading blows at the top, with a cheap upstart nipping at their heels.

Two weeks later, Anthropic shipped Opus 4.8. DeepSeek dropped V4-Pro with a 75% price cut. Moonshot open-sourced Kimi K2.6. The leaderboard reshuffled overnight.

Nobody mentions the real metric in the model wars: at $20/month, all three major AI coding tools cost the same. The difference isn't the subscription. It's how far that twenty bucks actually goes.

On the Artificial Analysis Coding Agent Index, a single Composer 2.5 standard task costs roughly $0.07 in compute (the Index defines a "standard task" as resolving a GitHub issue with an average of several thousand tokens of context). An Opus 4.7 max-effort task costs $4.10. Same monthly budget. A vastly different number of tasks before you hit the cap. And the performance gap? Four points on the Index (62 vs 66, measured against Opus 4.7; Opus 4.8's Coding Agent Index score was not yet available at the time of writing). A rounding error on SWE-Bench Multilingual, where Composer 2.5 hits 79.8% against Opus 4.7's 80.5%.

This isn't a story about the cheapest model winning. It's about getting more coding output per dollar, and why that calculation just got more interesting.

## The numbers that actually matter

I've been running AI coding agents daily for over a year now. My workflow involves spinning up agent sessions for everything from refactoring stale API endpoints to writing tests for code I wrote six months ago and can barely remember. On a heavy week, I'll fire off 50 to 70 agent sessions.

Most model comparisons miss the point: at $20/month, Cursor Pro, Claude Code Pro, and Codex Plus all cost the same. The difference isn't the sticker price. It's how much coding you get done before you hit the cap.

Cursor Pro includes $20 of model usage credits per month. Because Composer 2.5 standard mode costs roughly $0.50 per million input tokens and $2.50 per million output tokens, each agent task burns a tiny fraction of your budget. Running 50 to 70 tasks a week on Composer 2.5 standard barely makes a dent in those credits. Claude Code Pro gives you roughly 45 messages per 5-hour window at the time of writing — that replenishes multiple times per day, but heavy users report it feeling constraining during long afternoon sessions. Codex Plus gives you 20 to 100 messages per 5-hour window, depending on the model, with GPT-5.4 at the lower end.

The gap widens at higher tiers. Cursor Pro+ at $60/month gives you more included credits. Claude Code's Max 5x ($100/month) and Codex Pro 5x ($100/month) both offer 5x the base quota. At the top, Cursor Ultra ($200/month), Claude Max 20x ($200/month), and Codex Pro 20x ($200/month) all sit at the same price point. But because Composer 2.5's per-token costs are an order of magnitude lower than Opus or GPT models, each tier's credits buy you significantly more agent sessions in Cursor.

![Cost comparison: three receipts of dramatically different lengths — same $20 monthly budget, vastly different output](./composer-2-5-frontier-coding-at-commodity-pricing/images/cost-comparison.png)

DeepSeek V4-Pro has complicated this picture further. At $0.435 per million input tokens and $0.87 per million output tokens after its permanent 75% price cut, it's the cheapest model on the Coding Agent Index that still delivers frontier-adjacent performance. It scored 80.6% on SWE-bench Verified, matching Claude Opus 4.6 on that variant (note: SWE-bench Verified and SWE-Bench Multilingual are different benchmarks — scores across variants are not directly comparable). On LiveCodeBench, its 93.5 is the highest of any model, period. MIT-licensed, open weights, 1M-token context window. But DeepSeek lives in the API layer. You run it through an open harness like Aider or Continue, or call the API directly. It doesn't come bundled with any IDE or subscription.

So why am I still writing about Composer 2.5? Because DeepSeek V4-Pro, for all its benchmark dominance, is a general-purpose model behind an API endpoint. Composer 2.5 lives inside the IDE where you write code. It has been trained on Cursor's specific tool-use patterns and agentic workflow, tuned on 25x more synthetic coding tasks than its predecessor. On SWE-Bench Multilingual, Composer 2.5 hits 79.8% versus Opus 4.7's 80.5%. On Terminal-Bench 2.0, it ties Opus 4.7 at 69.3% vs. 69.4%. GPT-5.5 dominates that benchmark at 82.7% — a 13-point gap that genuinely matters for complex systems work. But for the CRUD-and-testing grind that fills most of my week, Composer 2.5's 69.3% is more than sufficient.

## What Cursor actually built

The technical story behind Composer 2.5 is worth paying attention to because it signals where this market is going.

The base model is Kimi K2.5 from Moonshot AI, a mixture-of-experts architecture with 1 trillion total parameters but only ~32 billion active at any given inference step. That MoE design is doing exactly what it should: giving you a big model's knowledge with a smaller model's compute cost.

But the part that matters more: Cursor spent 85% of their compute budget on their own additional training and reinforcement learning pipeline. They generated 25 times more synthetic training tasks than they did for Composer 2. The result is a model that went from a score of 48 (Composer 2) to 62, a 14-point jump in a single generation. That's the kind of improvement curve that makes you lean forward in your chair.

![Strategy: two toolboxes — one perfect tool vs a full practical set](./composer-2-5-frontier-coding-at-commodity-pricing/images/strategy.png)

The pricing reflects the architecture. Standard mode runs $0.50 per million input tokens and $2.50 per million output tokens. Fast mode costs $3.00/$15.00. For context, Claude Opus 4.8 pricing is an order of magnitude higher on both dimensions ($5/$25). Composer 2.5 Fast completes tasks in 6.7 minutes on average, making it the third-fastest model on the entire Index. Speed and cost aren't enemies here; they're allies.

Released May 18th, Composer 2.5 is available exclusively inside Cursor's IDE and CLI. That's a deliberate choice. Cursor isn't trying to be a general-purpose API provider. They're building the best coding experience inside the tool where you already write code.

## The new value landscape

Two weeks ago, the value story was simple: Composer 2.5 versus the expensive frontier. Now it's a three-way conversation, and pretending otherwise would be dishonest.

DeepSeek V4-Pro is the open-weight value king. At $0.35/task on the Coding Agent Index, its raw token costs rival Composer 2.5 Fast ($0.44/task), and it wins on benchmark ceiling. If you're running agents through an open harness like Aider or Continue, or calling the API directly, DeepSeek V4-Pro is the rational economic choice. The MIT license means you can fine-tune or self-host. The 1M-token context window handles anything you throw at it. It scored 80.6% on SWE-bench Verified and leads LiveCodeBench at 93.5.

Composer 2.5 is the integrated value king. Its per-token costs are the lowest of any model in a subscription IDE, roughly $0.07/task in standard mode, which means your Cursor Pro credits stretch far further than they would running Claude or GPT models. The IDE integration (inline edits, multi-file awareness, project-level context) isn't a nice-to-have. It's the thing that makes the difference between an agent that suggests code and an agent that writes code where you need it.

The frontier models (Opus 4.8, GPT-5.5) are the ceiling. When you need the absolute best reasoning, the highest scores on contamination-resistant benchmarks, or deep architectural analysis, you pay the premium. Opus 4.8 retained the same $5/$25 pricing as 4.7 while improving across coding, agentic tool use, and reasoning.

The question isn't which model is best. It's which model is best for the workflow you're actually running. And for most developers, most of the time, that workflow is inside an IDE, doing plumbing work, where a 4-point benchmark gap doesn't justify burning through your monthly budget in a week.

## The value thesis in practice

Let me paint a picture of what this looks like in day-to-day development.

Last Tuesday, I was working on a feature that required touching seven files across a monorepo. I broke it into five agent tasks: scaffolding, writing business logic, updating consumers, adding tests, and fixing type errors from the first pass.

Five tasks. In Claude Code Pro at $20/month, that's five of my roughly 45 messages per window — a meaningful chunk of a single afternoon's quota. In Codex Plus at $20/month, same story: each task eats into a limited message budget. In Cursor Pro at $20/month, those five Composer 2.5 standard tasks barely register against the credit pool. The Composer 2.5 output was clean enough that I accepted four of the five suggestions with minimal edits. The fifth needed a rewrite of the error handling, which… honestly, I've had to rewrite error handling on frontier model outputs too.

This is the point the benchmark-chasing misses. When you're running dozens of agent sessions a week, you're going to get some duds regardless of which model you use. The question isn't whether Model A produces 2% more correct completions than Model B on a curated benchmark. The question is whether you can get through a full workday without watching your quota counter tick down.

With Composer 2.5's low token costs inside a Cursor Pro plan, I can run agents all day without hitting my cap. I can use it for throwaway explorations. I can use it for tasks I'd otherwise just Google and copy-paste. I can use it without that little voice in my head saying, "Is this task worth burning a message?"

## The competitive moat nobody talks about

Here's something I find fascinating: Cursor's strategy is nothing like Anthropic's, OpenAI's, or even DeepSeek's.

Anthropic and OpenAI are building general-purpose intelligence. Their coding performance is a side effect of building models that can reason about everything. DeepSeek is building open-weight infrastructure. Their value play is commodity pricing on raw capability. Cursor is doing something different. They started with a coding environment, and they're building models specifically optimized for the work that happens inside that environment.

That specialization shows. Cursor spent 85% of its compute on proprietary RL training. They generated 25x more synthetic tasks than for Composer 2. They keep the model exclusive to their own IDE and CLI. This is a company that's not trying to win the general AI race or the open-weight race. They're trying to own the coding experience end to end, using model quality and aggressive pricing to get there.

The fact that they're reportedly training a larger model on SpaceXAI's Colossus cluster suggests they're not done pushing the performance ceiling either. If the next model closes the remaining gap to Opus 4.8 while maintaining anything close to current pricing, the "frontier fetish" starts to look like an expensive habit.

Cursor also shipped Auto-review run mode in late May, letting agents work longer with fewer approval prompts. And their June Teams pricing update split usage into Composer-specific and third-party pools, with a new Premium seat at $120/month that covers a full month of heavy agent usage. These aren't model improvements, but they're ecosystem improvements that make Composer 2.5 more practical for team adoption.

## Where it falls short

I want to be clear about the tradeoffs, because this isn't a puff piece.

Composer 2.5 is locked to Cursor's ecosystem. If you're a VS Code loyalist who refuses to switch, or if your team standardizes on JetBrains, you can't use it. Period. And unlike six months ago, there's now a genuine alternative: DeepSeek V4-Pro delivers comparable benchmark performance at low cost through any open agent harness, with MIT-licensed weights you can self-host. The ecosystem lock-in tradeoff is real in a way it wasn't when Composer 2.5 launched.

The 4-point gap on the Coding Agent Index is real. On hard problems (complex multi-file refactors, tasks requiring deep reasoning about system architecture), I'd still reach for Opus 4.8. The benchmark numbers don't lie about where the ceiling is.

And the standard mode, while absurdly cheap, is slower than Fast. It's also hidden behind a toggle that most users never find (hover over "Composer 2.5" in the model picker, click Edit, toggle Fast off). For interactive pair-programming where you want responses in seconds, you'll want Fast mode, which at $0.44/task burns through your credits faster but is still far more economical per task than running frontier models.

## What I reach for now

I've been testing Composer 2.5 since it dropped, and here's my honest takeaway: it's still the model I reach for first. I keep Opus 4.8 available for the hard problems, and I've added DeepSeek V4-Pro to my toolkit for tasks where I want open-weight flexibility. But for the daily grind of software development, Composer 2.5 handles 85% of what I throw at it, and my Cursor Pro credits last the full month.

The AI coding market has spent two years obsessed with who has the smartest model. Then DeepSeek asked who had the cheapest smart model. Cursor asked a different question: who has the smartest integrated model, the one that stretches your monthly budget furthest? Close enough on performance that most developers won't notice the difference. Cheap enough per token that you stop counting.

If you're already in Cursor, try Composer 2.5 for a week. Run every task through it that you'd normally send to Opus or GPT. Track how many outputs you accept versus how many you rewrite, and watch how your credit usage compares. If you're not in Cursor, try DeepSeek V4-Pro through Aider or Continue — at $0.35/task with open weights, it's the rational alternative for API-first workflows. Either way, think about how much coding you're actually getting done per dollar, not just which model tops the leaderboard.

The best model is the one you can use all day without thinking about cost. Right now that's Composer 2.5 inside Cursor, or DeepSeek V4-Pro through open tools if you care more about open-weight freedom than IDE integration. Either way, the frontier tax is optional.
