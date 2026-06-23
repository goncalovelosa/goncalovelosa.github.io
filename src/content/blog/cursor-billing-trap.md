---
title: "A $130 Charge for Code Nobody Wrote"
description: "Cursor users report surprise on-demand charges and locked accounts. The billing transparency crisis in AI coding tools is reaching a tipping point."
pubDate: 2026-06-22
category: "AI"
tags: ["ai", "coding"]
heroImage: "./cursor-billing-trap/images/VISUAL_1_cover_1.png"
mediumUrl: "https://medium.com/@gvelosa/cursor-billing-trap-TBD"
canonicalUrl: "https://medium.com/@gvelosa/cursor-billing-trap-TBD"
---

A developer woke up on June 19th to find $130 in charges from their Cursor Pro subscription. They hadn't been at their computer. The editor wasn't open. The model that generated the charges, Claude Opus 4.7 at max effort, had apparently been running agent tasks through the night.

The user also reported finding malware on their system, which means this specific incident was probably a compromised session rather than a billing bug. On its own, that makes this a security story. But it surfaced a question worth asking: why did Cursor's billing system allow $130 in charges to accumulate against an inactive account without flagging the anomaly? AWS and Stripe both have anomaly detection for unusual spending patterns. Cursor apparently does not.

They posted about it on Reddit. Within hours, other Cursor users shared similar stories. One had their $20 Pro plan hit with extra on-demand charges after the system auto-set a spending limit of exactly $41. Another burned through 50% of their $60 monthly budget in four days doing "minor PineScript changes." The complaints kept piling up.

This isn't a story about a bug. It's about a billing system that a million developers depend on, designed in a way that makes surprise charges a feature instead of an accident.

## How Cursor billing works

Cursor replaced its flat "500 fast requests per month" model in June 2025. The old system was simple: you got a fixed allowance, and when you hit the cap, the tool stopped working. Predictable, but economically unsustainable. AI inference at frontier-model quality costs real money, and Cursor was reportedly subsidizing up to 75% of compute costs under the flat-rate model.

The replacement is credit-based. Your $20 Pro subscription includes $20 of API credits. Simple tasks like Tab completions barely register against the pool. Premium models like Claude Sonnet, Claude Opus, and GPT-4o consume credits faster, proportional to their compute cost. At higher tiers, Pro+ ($60/month) and Ultra ($200/month), the credit pool scales proportionally.

![Two paper receipts on a dark wooden surface — one short and crumpled at $20, one absurdly long trailing off frame past $130](./cursor-billing-trap/images/VISUAL_2_chart_1.png)
*The same $20/month plan, two very different bills. On-demand billing kicks in when subscription credits run out.*

This is a fair system in principle. Light users pay less. Heavy users pay more. The economics make sense when you consider that Cursor crossed $1 billion in annual recurring revenue in November 2025 with over a million paying developers, according to the company's own Series D announcement. The $29.3 billion valuation depends on getting billing right at scale.

These billing issues primarily affect individual Pro and Pro+ subscriptions. Teams ($40/user/month) and Enterprise customers have admin-controlled spending caps, pooled credits, and centralized billing dashboards. The surprise-charge scenarios described here are structurally less likely on managed plans. But most individual developers are on Pro, and that's where the friction lives.

But the system has a feature that most users discover only after they've been charged: on-demand billing.

When your included credits run out, Cursor doesn't stop. It switches to on-demand pricing automatically. Your card keeps getting charged for every token until you manually disable the feature or hit your spending limit. And that limit? Users report the system pre-fills it with a calculated default instead of requiring you to explicitly opt in.

## The $41 problem

One Reddit user, posting as u/Fun_Net7931, described discovering unexpected on-demand charges on their $20 Pro plan. When they contacted support to dispute them, the response was that on-demand usage had been enabled with a limit that was first set to $50, then changed to exactly $41.

The user's argument was straightforward: why would anyone manually type $41 as a spending limit? The number looks calculated, like the system derived it from some prorated formula. Cursor's support pointed to UI logs showing the user had "confirmed" the setting.

Whether the system pre-filled this number or the user clicked through a prompt they didn't fully understand is genuinely unclear. The larger issue is what happened when the user tried to protect themselves: they reported being unable to set the on-demand limit to $0 to prevent any future charges. Cursor reportedly would not allow it.

A $20/month subscription that cannot be hard-capped at $20 is a subscription with no ceiling. The on-demand billing toggle exists, but according to user reports, the minimum spending limit is above zero. This claim comes from a single Reddit post and hasn't been independently verified. But the fact that it's even plausible tells you something about the billing UX.

![A car dashboard speedometer with needle pinned past redline, warning amber glow, no speed limit sign visible](./cursor-billing-trap/images/VISUAL_3_diagram_1.png)
*Cursor's on-demand billing has no hard cap. Users report being unable to set a spending limit of $0.*

To be fair to Cursor, on-demand billing exists because users asked for it. Developers hitting their credit limit mid-task wanted to keep coding instead of waiting for the cycle to reset. The feature solves a real problem. But the default should be a hard stop, with on-demand as an explicit opt-in that requires typing a dollar amount.

## The hidden cost multiplier

Even users who never enable on-demand billing are discovering that their credits vanish faster than expected. The culprit is model selection, specifically the gap between Composer 2.5 standard mode and Composer 2.5 Fast mode.

Standard mode costs roughly $0.50 per million input tokens and $2.50 per million output tokens, based on Moonshot AI's published Kimi K2.5 API pricing that Composer is built on. Fast mode costs $3.00 and $15.00 respectively. That is a 6x difference for the same model family.

![Three glass hourglasses on a dark workbench — one nearly empty, one half full, one cracked with sand spilling out](./cursor-billing-trap/images/VISUAL_4_illustration_1.png)
*Usage meters across AI coding tools are unreliable. The same week Cursor users reported billing chaos, Anthropic fixed a Claude Code tracking bug affecting 3% of premium users.*

The problem is that Cursor's agent system can automatically select Fast mode for subtasks without the user explicitly choosing it. A developer thinks they're using the standard model, but background agents route through Fast mode to speed up subtask completion. The dashboard shows 84% usage, and the user has no idea why their budget evaporated until someone on Reddit explains that agents call the expensive variant behind the scenes.

A separate Pro user reported their token allowance dropping from roughly 800 million to around 194 million between cycles. The community diagnosis: the first month included a promotional 2x usage bonus during Composer's launch week. When it expired, the budget appeared to crash.

Cursor doesn't prominently surface which model variant agents are selecting or what each variant costs per task. The dashboard shows usage as a percentage. You see 84%, but you have to do the math yourself to figure out that agents are routing through a model that costs 6x more than the one you thought you selected.

## The Anthropic parallel

The same week these Cursor complaints surfaced, Anthropic quietly fixed a usage tracking bug in Claude Code that affected approximately 3% of Max and Pro subscribers. For those users, weekly usage limits jumped by 20% or more, sometimes blocking messages entirely. Anthropic reset limits for affected accounts, though some users reported receiving only partial resets or none at all.

Two companies, two billing systems, same symptom: usage meters that developers cannot trust. When Anthropic's meter over-counts, users lose access to a tool they're paying for. When Cursor's meter is opaque, users lose money they didn't intend to spend.

The common thread is that AI coding tools have reached a scale where billing infrastructure is production-critical. Cursor has over a million paying developers. Claude Code is the terminal agent of choice for a large segment of professional engineers. When the meter breaks, the blast radius is enormous.

## What needs to change

The credit-based model is fine. Going back to flat-rate pricing would mean subsidizing heavy users or raising prices across the board.

But three things need to happen, and they're not complicated.

**Hard caps.** Users must be able to set a spending ceiling of $0. A subscription that cannot be capped at its sticker price is a subscription designed to overspend. If a user wants their $20 plan to cost exactly $20, the system should respect that.

**Agent cost visibility.** When a background agent selects an expensive model variant, the user should see it as it happens, before the budget is gone. The dashboard should show which model was used, what it cost, and whether the user explicitly selected it. A 6x cost multiplier applied silently by the agent system is a billing bug dressed up as a feature.

**Proactive warnings.** The dashboard exists, but it's buried in settings. When credits drop below 20%, users should get a notification before the system switches to on-demand billing. The current behavior, where on-demand activates silently when credits are exhausted, guarantees surprise charges by design.

## The broader pattern

Cursor's billing issues are not unique to Cursor. The AI tooling industry is moving through the same pricing evolution that cloud computing went through a decade ago: launch with an attractive flat rate, add usage limits, introduce overages, and eventually users face bills they didn't expect.

![A dark settings panel with a billing toggle switch glowing orange, a warning icon, and a numeric input field showing zero](./cursor-billing-trap/images/VISUAL_5_screenshot_1.png)
*The fix is simple: hard caps, clear warnings, and agent cost visibility. None of which exist today.*

We're somewhere between phases three and four right now. The tools are genuinely useful. The billing systems haven't caught up to the scale of adoption.

I run AI coding agents every day. I've written about the economics of these tools extensively. On the Artificial Analysis Coding Agent Index, a Composer 2.5 standard task costs roughly $0.07 in compute. Claude Opus at max effort costs $4.10 per task. The difference matters. But it only matters if you can see it, and if you can trust the meter enough to plan around it.

## What you can do today

If you use Cursor Pro, open Settings → Billing and check whether on-demand usage is enabled. If you don't want surprise charges, disable it. Check which model variant your agents are running — Composer 2.5 standard costs a fraction of Fast mode, and background agents can route through the expensive variant without asking. For teams, Cursor Teams and Enterprise plans offer admin-controlled spending caps that eliminate most of these scenarios.

Cursor is a $29 billion company whose billing UX reportedly prevents users from setting a spending limit of zero. Whether that's a bug or a design choice, it's worth asking why.
