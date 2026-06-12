---
title: "Anthropic Built the Most Powerful Coding Model Ever. Then They Secretly Weakened It."
description: "Claude Fable 5 can migrate 50 million lines of Ruby in a day. It can also silently decide you don't deserve its best answer — and not tell you. The story of the most capable public AI model ever shipped, and the transparency crisis it triggered within 48 hours."
pubDate: 2026-06-13
category: "AI"
tags: ["ai", "anthropic", "claude", "fable-5", "safety", "transparency"]
heroImage: "/blog/images/fable-5-hero.png"
---

# Anthropic Built the Most Powerful Coding Model Ever. Then They Secretly Weakened It.

On June 9, Anthropic released Claude Fable 5. By most measures, the most capable AI model ever made available to the public.

Stripe used it to compress months of engineering into days, according to an Anthropic-published case study: a codebase-wide migration across 50 million lines of Ruby that would have taken a full team over two months was done in a single day. On the coding benchmarks that matter, Fable 5 scored 29.3% on FrontierCode Diamond (the hardest coding benchmark in existence), 80.3% on SWE-bench Pro (11 points ahead of the next-best), and 95% on SWE-bench Verified. It can operate autonomously for multi-day sessions, according to Anthropic's technical documentation. It runs its own tests. It checks its own work with vision and orchestrates parallel sub-agents without waiting for human approval. It has a million-token context window and costs twice what Claude Opus 4.8 does: $10 per million input tokens, $50 per million output. At that price, you'd expect to get the model you're paying for.

Simon Willison, who spent five hours testing it on launch day, described it as having a "big model smell." Not just fast or expensive, but qualitatively different in how much it knows and how autonomously it operates.

Forty-eight hours later, Anthropic apologized for secretly weakening it.

## The two-tier architecture

Fable 5 is the public face of something Anthropic calls the Mythos class. The same underlying model ships in two versions. Claude Fable 5 is what anyone can use through the Claude API and Claude.ai. Claude Mythos 5 has the safety classifiers removed and is available only through a government-access program called Project Glasswing.

The safety architecture is intentional. On its surface, it's reasonable. Fable 5's guardrails are conservative by design: when a query trips a safety trigger, instead of refusing outright, Fable silently falls back to Claude Opus 4.8 (a less capable model); Anthropic says this happens in less than 5% of sessions on average. The categories that trigger fallback are cybersecurity, then biology, then chemistry. All areas where a model this capable could cause real damage.

Mythos 5 gets the full power, unrestricted. It is, according to Anthropic, "the strongest cybersecurity model in the world." Access is limited to cyberdefenders and infrastructure providers vetted through the US government. The logic is clear: the most dangerous capabilities exist, but they're gated behind institutional trust.

Then someone read the fine print.

## What was buried in Section 1.5

Claude Fable 5 shipped with a 319-page system card. Section 1.5 contained a paragraph that Anthropic presumably hoped would go unnoticed. It disclosed that the model would detect "requests targeting frontier LLM development" — specifically, building pretraining pipelines, distributed training infrastructure, or ML accelerator design — and "limit effectiveness" without notifying the user.

Not "refuse and explain." Not "fall back visibly and tell you." The system card was explicit: the restrictions would operate through prompt modification, steering vectors, and parameter-efficient fine-tuning. You ask Fable for help building distributed training infrastructure. Fable decides you might be distilling its outputs to train a competitor; it subtly degrades its answer through internal mechanisms. You never know. Anthropic estimated this would affect ~0.03% of traffic, concentrated in fewer than 0.1% of organizations.

This is different from every other safety mechanism in Fable. The cybersecurity fallbacks are visible; you get told when your query is redirected. The biology and chemistry restrictions work the same way. But the AI development restrictions were designed to be invisible. As the system card stated: "not visible to the user."

Fortune's Sharon Goldman broke the story on June 10, and the backlash was immediate and severe.

## "We made the wrong tradeoff"

Within 24 hours, Anthropic reversed course. In a statement to WIRED, reported by Maxwell Zeff: "We're changing Fable 5's safeguards for frontier LLM development to make them visible. We made the wrong tradeoff, and we apologize for not getting the balance right."

On X, Anthropic's developer account posted a longer explanation: flagged requests for frontier LLM development would now visibly fall back to Opus 4.8 (the same mechanism used for cyber and bio queries), with users seeing a notification every time it happened. On the API, flagged requests would return a reason for refusal.

The justification for the original covert approach was speed. Anthropic explained that "visible safeguards can be probed, so they have to be rigorous, which takes time to get right. Invisible safeguards can be targeted more narrowly, allowing us to ship quickly with very few false positives." They went with invisible safeguards to ship Fable 5 faster. The tradeoff was that users couldn't trust whether the answer they received was from the model they were paying for.

The national security framing added another layer. Anthropic told Business Insider the restrictions were designed to prevent "foreign adversaries" from using Fable to accelerate their own frontier AI development — the worry being that a state-level actor with access to Fable could compress years of capability development into months. The reasoning has merit: Anthropic's own system card notes that recent models can "accelerate their own development," making frontier AI a legitimate dual-use concern. The cybersecurity community pushed back hard regardless. TechCrunch reported that security researchers found the guardrails "too strict for any cybersecurity work," effectively blocking them from using the most advanced public model for legitimate defense research.

## The paradox at the center

Here's what makes the Fable 5 story more than a transparency scandal: the model's capabilities and its restrictions are both symptoms of the same underlying reality.

Fable 5 is powerful enough that Anthropic genuinely worried about what would happen if it was used at full strength for AI research and cybersecurity. That worry is legitimate. Models at this capability level can identify novel vulnerabilities and accelerate weapons-relevant research. They can help competitors close the gap, too. The safety concerns aren't theoretical.

But the response, secretly degrading the model for certain categories of user without telling them, reveals a deeper problem. If the most capable public model needs covert restrictions to be safe, maybe it's too capable to release. Period. And if the company that built it decides unilaterally what counts as "frontier LLM development" and who deserves the full answer, then every developer using the model is operating in a trust environment they can't verify. (The fallback model, to be fair, was Opus 4.8 — still frontier-class. But users paying $50 per million output tokens for Fable were getting Opus output at Fable prices without knowing it.)

This isn't just about Anthropic; every frontier lab faces the same tension, whether it's OpenAI shipping GPT-5.5 through Codex with usage monitoring and content policies or Google's Gemini models with their own safety layers. The question isn't whether safety mechanisms are needed. It's whether they can be honest.

Simon Willison, after Anthropic's walkback, put it plainly: "It would be a whole lot better if they dropped this category of refusals entirely."

## The trust equation

The Fable 5 incident reveals something the AI industry doesn't like to discuss. The relationship between frontier model providers and their users is deeply asymmetric. The provider knows exactly what the model is capable of, what triggers its safety mechanisms, and what the user is actually receiving. The user knows only what the model outputs. When the provider secretly changes the output based on invisible classifiers, that asymmetry becomes a trust deficit that no benchmark score can repair.

The fix Anthropic applied (making the restrictions visible) is necessary but insufficient. Visible restrictions mean developers can at least know when they're being redirected. But the underlying question remains: who decides what you're allowed to build? A cybersecurity researcher using Fable to find vulnerabilities in their own infrastructure gets the same invisible downgrade as a state-sponsored attacker. The model can't tell the difference. The classifier can only guess.

Stripe's 50-million-line Ruby migration worked because Stripe was using Fable for something no safety classifier would flag. The next team that tries to use Fable for something adjacent to AI infrastructure development won't know if they're getting the real model or a polite downgrade. Even after the walkback, they'll only know after the fact, when the notification appears.

## What this means for developers

Three things sit uneasily alongside each other.

Claude Fable 5 is, by most benchmarks, the most capable public coding model ever shipped. (Codex's GPT-5.5 leads on some measures; the title depends on which test you pick.) The Stripe case study is real. The autonomous capabilities are real.

Anthropic's safety concerns are also real. A model this powerful, unrestricted, in the wrong hands, could cause serious damage. The two-tier architecture is a genuine attempt to balance that: Fable for everyone, Mythos restricted to vetted institutions.

And the covert approach was wrong. Safety restrictions are fine. What's not fine is secretly eroding the foundation of trust that makes the developer ecosystem work. You can't build on a platform that might be silently holding back on you. You can't debug a system you can't see.

The Fable 5 story ends with an apology and a policy change. Every capability increase will sharpen the same tension. Another Mythos-class model will ship. It will face the same questions. Will the industry learn from this? Visible safeguards are better than invisible ones. But the harder question — whether a model this powerful should ship at all without a genuinely robust safety architecture, not one built on classifier guesswork — remains unanswered. And covert restrictions on what counts as "AI research" risk chilling the exact legitimate work, from academic studies to startup prototyping, that keeps the field open.

The most powerful coding model in the world is only useful if developers trust the answers they're getting. For 48 hours, they couldn't. Anthropic fixed the visibility problem in two days. The precedent — that a frontier lab can ship covert restrictions and only reverse them under public pressure — will last longer.
