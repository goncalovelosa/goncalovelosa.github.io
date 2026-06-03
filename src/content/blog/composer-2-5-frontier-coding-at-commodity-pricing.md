---
title: "Composer 2.5 is the AI coding model most developers should actually use"
description: "Cursor's model ranks third on the Coding Agent Index but costs 10-60x less than the leaders. With DeepSeek V4-Pro now competing on value, the question isn't which model is best — it's which model is best for your workflow."
pubDate: 2026-06-03
category: "AI"
tags: ["ai-coding", "cursor", "composer-2.5", "deepseek-v4", "llm-benchmarks", "developer-tools"]
heroImage: "./composer-2-5-frontier-coding-at-commodity-pricing/./composer-2-5-frontier-coding-at-commodity-pricing/images/cost-comparison.png"
mediumUrl: "https://medium.com/@gvelosa/composer-2-5-TBD"
canonicalUrl: "https://medium.com/@gvelosa/composer-2-5-TBD"
---

![Cover: a single gold coin casting an enormous shadow — small cost, massive impact](./composer-2-5-frontier-coding-at-commodity-pricing/./composer-2-5-frontier-coding-at-commodity-pricing/images/cover.png)

The AI coding space has a new problem, and it's a good one: too many models are getting too good and too cheap, too fast.

When I first drafted this piece in late May, the Artificial Analysis Coding Agent Index had Cursor's Composer 2.5 sitting in third place with a score of 62. Claude Opus 4.7 led at 66. GPT-5.5 sat at 65. A tidy story: two expensive frontier models trading blows at the top, with a cheap upstart nipping at their heels.

Two weeks later, Anthropic shipped Opus 4.8. DeepSeek dropped V4-Pro with a 75% price cut. Moonshot open-sourced Kimi K2.6. The leaderboard reshuffled overnight.

Here's the number that still stops me mid-scroll, even after all that: Composer 2.5 standard costs $0.07 per task. Claude Opus 4.8 costs over $4. DeepSeek V4-Pro, the new value champion, runs $0.35 per task. Composer 2.5 is still five times cheaper than the closest competition on the Coding Agent Index.

Let me do the uncomfortable arithmetic. Composer 2.5 standard is somewhere between 10x and 60x cheaper than the frontier models, depending on whether you're running it in Fast mode ($0.44/task) or standard. And the performance gap to the top? Four points on the Index. A rounding error on SWE-Bench Multilingual, where Composer 2.5 hits 79.8% against Opus 4.7's 80.5%.

This isn't a story about the best model winning. It's a story about the best model most people can afford to actually use, and why that category just got crowded.

## The numbers that actually matter

I've been running AI coding agents daily for over a year now. My workflow involves spinning up agent sessions for everything from refactoring stale API endpoints to writing tests for code I wrote six months ago and can barely remember. On a heavy week, I'll fire off 50 to 70 agent sessions.

At Opus 4.8 pricing, that's $200 to $280 per week. At GPT-5.5 pricing, $241 to $337. At DeepSeek V4-Pro, $17.50 to $24.50. At Composer 2.5 standard, $3.50 to $4.90. At Composer 2.5 Fast, $22 to $31.

The difference between $280/week and $5/week isn't a rounding error. It's the difference between expense-reporting your AI tools and just paying for them yourself. It's the difference between thinking "should I spin up an agent for this?" and just doing it.

![Cost comparison: three receipts of dramatically different lengths — $3.50 vs $280 vs $337 per week](./composer-2-5-frontier-coding-at-commodity-pricing/./composer-2-5-frontier-coding-at-commodity-pricing/images/cost-comparison.png)

DeepSeek V4-Pro has complicated this picture. At $0.435 per million input tokens and $0.87 per million output tokens after its permanent 75% price cut, it's the cheapest model on the Coding Agent Index that still delivers frontier-adjacent performance. It scored 80.6% on SWE-bench Verified, matching Claude Opus 4.6. On LiveCodeBench, its 93.5 is the highest of any model, period. MIT-licensed, open weights, 1M-token context window.

So why am I still writing about Composer 2.5? Because DeepSeek V4-Pro, for all its benchmark dominance, is a general-purpose model. You run it through an API or a generic agent harness. Composer 2.5 lives inside the IDE where you write code. It has been trained on Cursor's specific tool-use patterns and agentic workflow, tuned on 25x more synthetic coding tasks than its predecessor. The benchmarks that matter most for daily development — CursorBench v3.1, where Composer 2.5 scores 63.2% versus Opus 4.7's 61.6% — reflect that specialization.

Composer 2.5 actually *beats* both frontier models on CursorBench v3.1, though I'll note that CursorBench is Cursor's own benchmark, so take that with appropriate salt. It ties Opus 4.7 on Terminal-Bench 2.0 at 69.3% vs. 69.4%. GPT-5.5 dominates that benchmark at 82.7%, I'll grant you, but I'm not running nuclear reactor control software. I'm refactoring CRUD endpoints and writing integration tests.

## What Cursor actually built

The technical story behind Composer 2.5 is worth paying attention to, because it signals where this market is going.

The base model is Kimi K2.5 from Moonshot AI, a mixture-of-experts architecture with 1 trillion total parameters but only ~32 billion active at any given inference step. That MoE design is doing exactly what it should: giving you a big model's knowledge with a smaller model's compute cost.

But here's the part that matters more. Cursor spent 85% of their compute budget on their own additional training and reinforcement learning pipeline. They generated 25 times more synthetic training tasks than they did for Composer 2. The result is a model that went from a score of 48 (Composer 2) to 62, a 14-point jump in a single generation. That's the kind of improvement curve that makes you lean forward in your chair.

![Strategy: two toolboxes — one perfect tool vs a full practical set](./composer-2-5-frontier-coding-at-commodity-pricing/./composer-2-5-frontier-coding-at-commodity-pricing/images/strategy.png)

The pricing reflects the architecture. Standard mode runs $0.50 per million input tokens and $2.50 per million output tokens. Fast mode costs $3.00/$15.00. For context, Claude Opus 4.8 pricing is an order of magnitude higher on both dimensions ($5/$25). Composer 2.5 Fast completes tasks in 6.7 minutes on average, making it the third-fastest model on the entire Index. Speed and cost aren't enemies here; they're allies.

Released May 18th, Composer 2.5 is available exclusively inside Cursor's IDE and CLI. That's a deliberate choice. Cursor isn't trying to be a general-purpose API provider. They're building the best coding experience inside the tool where you already write code.

## The new value landscape

Two weeks ago, the value story was simple: Composer 2.5 versus the expensive frontier. Now it's a three-way conversation, and pretending otherwise would be dishonest.

**DeepSeek V4-Pro** is the open-weight value king. At $0.35/task on the Coding Agent Index, it matches Composer 2.5 Fast ($0.44/task) and beats it on raw benchmark ceiling. If you're running agents through Claude Code, Codex CLI, or any open harness with API access, DeepSeek V4-Pro is the rational economic choice. The MIT license means you can fine-tune or self-host. The 1M-token context window handles anything you throw at it. It scored 80.6% on SWE-bench Verified and leads LiveCodeBench at 93.5.

**Composer 2.5** is the integrated value king. It's five times cheaper than DeepSeek per task if you run standard mode ($0.07 vs $0.35), and it benefits from Cursor's specialized training pipeline that no open harness can replicate. The IDE integration — inline edits, multi-file awareness, project-level context — isn't a nice-to-have. It's the thing that makes the difference between an agent that suggests code and an agent that *writes code where you need it*.

**The frontier models** (Opus 4.8, GPT-5.5) are the ceiling. When you need the absolute best reasoning, the highest scores on contamination-resistant benchmarks, or deep architectural analysis, you pay the premium. Opus 4.8 retained the same $5/$25 pricing as 4.7 while improving across coding, agentic tool use, and reasoning.

The question isn't which model is best. It's which model is best *for the workflow you're actually running*. And for most developers, most of the time, that workflow is inside an IDE, doing plumbing work, where a 4-point benchmark gap doesn't justify a 60x price multiplier.

## The value thesis in practice

Let me paint a picture of what this looks like in day-to-day development.

Last Tuesday I was working on a feature that required touching seven files across a monorepo. I broke it into five agent tasks: scaffolding, writing business logic, updating consumers, adding tests, and fixing type errors from the first pass.

Five tasks. With Opus 4.8 that's about $20. With DeepSeek V4-Pro, $1.75. With Composer 2.5 standard, $0.35. The Composer 2.5 output was clean enough that I accepted four of the five suggestions with minimal edits. The fifth needed a rewrite of the error handling, which... honestly, I've had to rewrite error handling on frontier model outputs too.

This is the point the benchmark-chasing misses. When you're running dozens of agent sessions a week, you're going to get some duds regardless of which model you use. The question isn't whether Model A produces 2% more correct completions than Model B on a curated benchmark. The question is whether you can afford to run the model long enough that its strengths compound.

At $0.07/task, you can run Composer 2.5 all day. You can use it for throwaway explorations. You can use it for tasks you'd otherwise just Google and copy-paste. You can use it without a budget approval or a usage dashboard, without that little voice in your head saying "is this task worth four dollars?"

## The competitive moat nobody talks about

Here's something I find fascinating: Cursor's strategy is nothing like Anthropic's, OpenAI's, or even DeepSeek's.

Anthropic and OpenAI are building general-purpose intelligence. Their coding performance is a side effect of building models that can reason about everything. DeepSeek is building open-weight infrastructure. Their value play is commodity pricing on raw capability. Cursor is doing something different. They started with a coding environment, and they're building models specifically optimized for the work that happens inside that environment.

That specialization shows. Cursor spent 85% of their compute on proprietary RL training. They generated 25x more synthetic tasks than for Composer 2. They keep the model exclusive to their own IDE and CLI. This is a company that's not trying to win the general AI race or the open-weight race. They're trying to own the coding experience end to end, using model quality and aggressive pricing to get there.

The fact that they're reportedly training a larger model on SpaceXAI's Colossus cluster suggests they're not done pushing the performance ceiling either. If the next model closes the remaining gap to Opus 4.8 while maintaining anything close to current pricing, the "frontier fetish" starts to look like an expensive habit.

Cursor also shipped Auto-review run mode in late May, letting agents work longer with fewer approval prompts. And their June Teams pricing update split usage into Composer-specific and third party pools, with a new Premium seat at $120/month that covers a full month of heavy agent usage. These aren't model improvements, but they're ecosystem improvements that make Composer 2.5 more practical for team adoption.

## Where it falls short

I want to be clear about the tradeoffs, because this isn't a puff piece.

Composer 2.5 is locked to Cursor's ecosystem. If you're a VS Code loyalist who refuses to switch, or if your team standardizes on JetBrains, you can't use it. Period. And unlike six months ago, there's now a genuine alternative: DeepSeek V4-Pro delivers comparable benchmark performance at low cost through any open agent harness, with MIT-licensed weights you can self-host. The ecosystem lock-in tradeoff is real in a way it wasn't when Composer 2.5 launched.

The 4-point gap on the Coding Agent Index is real. On hard problems (complex multi-file refactors, tasks requiring deep reasoning about system architecture), I'd still reach for Opus 4.8. The benchmark numbers don't lie about where the ceiling is.

And the standard mode, while absurdly cheap, is slower than Fast. It's also hidden behind a toggle that most users never find (hover over "Composer 2.5" in the model picker, click Edit, toggle Fast off). For interactive pair-programming where you want responses in seconds, you'll want Fast mode, which at $0.44/task is still 10x cheaper than the frontier models but no longer in "who cares about the cost" territory.

## What I reach for now

I've been testing Composer 2.5 since it dropped, and here's my honest takeaway: it's still the model I reach for first. I keep Opus 4.8 available for the hard problems, and I've added DeepSeek V4-Pro to my toolkit for tasks where I want open-weight flexibility. But for the daily grind of software development, Composer 2.5 handles 85% of what I throw at it at a price that doesn't make me wince.

The AI coding market has spent two years obsessed with who has the smartest model. Then DeepSeek asked who has the cheapest smart model. Cursor asked a different question: who has the smartest *integrated* model? Seven cents a task. Five times cheaper than DeepSeek. Sixty times cheaper than the leader. Close enough on performance that most developers won't notice the difference.

If you're already in Cursor, try Composer 2.5 for a week. Run every task through it that you'd normally send to Opus or GPT. Track how many outputs you accept versus rewrite. If you're not in Cursor, try DeepSeek V4-Pro through Claude Code or Codex — at $0.35/task with open weights, it's the rational alternative. Either way, stop paying frontier prices for plumbing work.

The best model is the one you can afford to use without thinking about it. Right now, that's either Composer 2.5 or DeepSeek V4-Pro, depending on whether you value IDE integration or open-weight freedom more. The frontier tax is optional.
