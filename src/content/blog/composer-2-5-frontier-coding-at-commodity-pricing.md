---
title: "Composer 2.5 is the AI coding model most developers should actually use"
description: "Cursor's new model ranks third on the Coding Agent Index but costs 10-60x less than the leaders. For most developers, that's the only ranking that matters."
pubDate: 2026-05-21
category: "AI"
tags: ["ai-coding", "cursor", "composer-2.5", "llm-benchmarks", "developer-tools"]
heroImage: "./composer-2-5-frontier-coding-at-commodity-pricing/./composer-2-5-frontier-coding-at-commodity-pricing/images/cost-comparison.png"
mediumUrl: "https://medium.com/@gvelosa/composer-2-5-TBD"
canonicalUrl: "https://medium.com/@gvelosa/composer-2-5-TBD"
---

![Cover: expensive models towering over a small but powerful beacon](./composer-2-5-frontier-coding-at-commodity-pricing/./composer-2-5-frontier-coding-at-commodity-pricing/images/cover.png)


![Cost per task: Composer 2.5 vs Opus 4.7 vs GPT-5.5](./composer-2-5-frontier-coding-at-commodity-pricing/./composer-2-5-frontier-coding-at-commodity-pricing/images/cost-comparison.png)

The AI coding space has a new problem, and it's a good one: too many models are getting too good.

Three days ago, Artificial Analysis updated their Coding Agent Index. Cursor's Composer 2.5 is sitting in third place with a score of 62. Claude Opus 4.7 leads at 66. GPT-5.5 is at 65. Those two models are genuinely better. Nobody's disputing that.

But here's the number that stopped me mid-scroll: Composer 2.5 standard costs $0.07 per task. Claude Opus 4.7 costs $4.10. GPT-5.5 costs $4.82.

Let me do the uncomfortable arithmetic. That's somewhere between 10x and 60x cheaper, depending on whether you're running Composer 2.5 in Fast mode ($0.44/task) or standard. And the performance gap? Four points on the index. A rounding error on SWE-Bench Multilingual, where Composer 2.5 hits 79.8% against Opus 4.7's 80.5%.

This isn't a story about the best model winning. It's a story about the best model most people can afford to actually use.

## The numbers that actually matter

I've been running AI coding agents daily for over a year now. My workflow involves spinning up agent sessions for everything from refactoring stale API endpoints to writing tests for code I wrote six months ago and can barely remember. On a heavy week, I'll fire off 50 to 70 agent sessions.

At GPT-5.5 pricing, that's $241 to $337 per week. At Claude Opus 4.7 pricing, $205 to $287. At Composer 2.5 standard, $3.50 to $4.90. At Composer 2.5 Fast, $22 to $31.

The difference between $300/week and $5/week isn't a rounding error. It's the difference between expense-reporting your AI tools and just paying for them yourself. It's the difference between thinking "should I spin up an agent for this?" and just doing it.

And for most of the tasks I throw at agents, the quality difference is barely perceptible. Composer 2.5 actually *beats* both frontier models on CursorBench v3.1 (63.2% vs. Opus 4.7's 61.6% and GPT-5.5's 59.2%). It ties Opus 4.7 on Terminal-Bench 2.0 at 69.3% vs. 69.4%. GPT-5.5 dominates that benchmark at 82.7%, I'll grant you, but I'm not running nuclear reactor control software. I'm refactoring CRUD endpoints and writing integration tests.

## What Cursor actually built

The technical story behind Composer 2.5 is worth paying attention to, because it signals where this market is going.

The base model is Kimi K2.5 from Moonshot AI, a mixture-of-experts architecture with 1 trillion total parameters but only ~32 billion active at any given inference step. That MoE design is doing exactly what it should: giving you a big model's knowledge with a smaller model's compute cost.

But here's the part that matters more. Cursor spent 85% of their compute budget on their own reinforcement learning and training pipeline. They generated 25 times more synthetic training tasks than they did for Composer 2. The result is a model that went from a score of 48 (Composer 2) to 62, a 14-point jump in a single generation. That's the kind of improvement curve that makes you lean forward in your chair.

![Benchmark comparison: SWE-Bench, CursorBench, Terminal-Bench](./composer-2-5-frontier-coding-at-commodity-pricing/./composer-2-5-frontier-coding-at-commodity-pricing/images/benchmark-bars.png)

The pricing reflects the architecture. Standard mode runs $0.50 per million input tokens and $2.50 per million output tokens. Fast mode costs $3.00/$15.00. For context, Claude Opus 4.7 pricing is an order of magnitude higher on both dimensions. Composer 2.5 Fast completes tasks in 6.7 minutes on average, making it the third-fastest model on the entire Index. Speed and cost aren't enemies here; they're allies.

Released May 18th, Composer 2.5 is available exclusively inside Cursor's IDE and CLI. That's a deliberate choice. Cursor isn't trying to be a general-purpose API provider. They're building the best coding experience inside the tool where you already write code.

## The value thesis in practice

Let me paint a picture of what this looks like in day-to-day development.

Last Tuesday I was working on a feature that required touching seven files across a monorepo. I broke it into five agent tasks: scaffolding the module, writing the business logic, updating consumers, adding tests, and fixing the type errors from the first pass.

Five tasks. With GPT-5.5 that's about $24. With Composer 2.5 standard, it's $0.35. The Composer 2.5 output was clean enough that I accepted four of the five suggestions with minimal edits. The fifth needed a rewrite of the error handling, which... honestly, I've had to rewrite error handling on GPT-5.5 outputs too.

This is the point the benchmark-chasing misses. When you're running dozens of agent sessions a week, you're going to get some duds regardless of which model you use. The question isn't whether Model A produces 2% more correct completions than Model B on a curated benchmark. The question is whether you can afford to run the model long enough that its strengths compound.

![Weekly cost at 50 tasks per week](./composer-2-5-frontier-coding-at-commodity-pricing/./composer-2-5-frontier-coding-at-commodity-pricing/images/value-funnel.png)

At $0.07/task, you can run Composer 2.5 all day. You can use it for throwaway explorations. You can use it for tasks you'd otherwise just Google and copy-paste. You can use it without a budget approval, without a usage dashboard, without that little voice in your head saying "is this task worth $4.82?"

## Why third place might be the sweet spot

There's a broader dynamic at play here that I think the industry is just starting to internalize.

The AI coding market has been dominated by what I'd call the frontier fetish: the assumption that developers will always pay a premium for the smartest model available. And sure, there are scenarios where you want the absolute best. If I'm debugging a heisenbug in a distributed system at 2 AM, yes, give me Opus 4.7. If I'm generating a complex algorithm from scratch, GPT-5.5's Terminal-Bench dominance probably matters.

But most of my coding isn't that. Most of *anyone's* coding isn't that. Most coding is plumbing. Wiring APIs, writing boilerplate, adding logging, fixing lint errors, updating dependencies. The thousand small tasks that eat 80% of a developer's day. For that work, you don't need the smartest model on earth. You need one that's good enough, fast enough, and cheap enough that you never think twice about invoking it.

Composer 2.5 occupies that sweet spot with startling precision. It's close enough to frontier performance on most benchmarks that the difference won't change your workflow. It's fast enough that you're not staring at a spinner. And it's cheap enough that cost simply drops out of the equation.

## The competitive moat nobody talks about

Here's something I find fascinating: Cursor's strategy is nothing like Anthropic's or OpenAI's.

Anthropic and OpenAI are building general-purpose intelligence. Their coding performance is a side effect of building models that can reason about everything. Cursor is doing the opposite. They started with a coding environment, and they're building models specifically optimized for the work that happens inside that environment.

That specialization shows. Cursor spent 85% of their compute on proprietary RL training. They generated 25x more synthetic tasks than for Composer 2. They keep the model exclusive to their own IDE and CLI. This is a company that's not trying to win the general AI race. They're trying to own the coding experience end to end, using model quality, tight tooling integration, and aggressive pricing to get there.

The fact that they're reportedly training a larger model on SpaceXAI's Colossus 2 cluster suggests they're not done pushing the performance ceiling either. If the next model closes the remaining 4-point gap on the Index while maintaining anything close to current pricing, the "frontier fetish" starts to look like an expensive habit.

## Where it falls short

I want to be clear about the tradeoffs, because this isn't a puff piece.


Composer 2.5 is locked to Cursor's ecosystem. If you're a VS Code loyalist who refuses to switch, or if your team standardizes on JetBrains, you can't use it. Period. That's a real limitation and one that Cursor seems comfortable with, but it means the model's reach is limited by the IDE's market share.

The 4-point gap on the Coding Agent Index is real. On hard problems — complex multi-file refactors, tasks requiring deep reasoning about system architecture — I'd still reach for Opus 4.7. The benchmark numbers don't lie about where the ceiling is.

And the standard mode, while absurdly cheap, is slower than Fast. For interactive pair-programming where you want responses in seconds, you'll want Fast mode, which at $0.44/task is still 10x cheaper than the frontier models but no longer in "who cares about the cost" territory.

## The bottom line

I've been testing Composer 2.5 since it dropped, and here's my honest takeaway: it's the model I reach for first now. I keep Opus 4.7 available for the hard problems, but for the daily grind of software development, Composer 2.5 handles 85% of what I throw at it at a price that doesn't make me wince.

The AI coding market has spent two years obsessed with who has the smartest model. Cursor just made the case that the more interesting question is who has the smartest pricing. Seven cents a task. Sixty times cheaper than the leader. Close enough on performance that most developers won't notice the difference.

If you're already in Cursor, try Composer 2.5 for a week. Run every task through it that you'd normally send to Opus or GPT. Track how many outputs you accept versus rewrite. I think you'll find what I found: the model that costs pennies handles most of what the model that costs dollars does, and the savings compound into something that changes how you think about AI-assisted development.


The best model is the one you can afford to use without thinking about it. Right now, for most developers, that's Composer 2.5.
