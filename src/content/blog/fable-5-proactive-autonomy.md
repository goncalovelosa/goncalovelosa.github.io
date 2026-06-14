---
title: "Anthropic Built the Most Powerful Coding Model Ever. Then They Secretly Weakened It."
description: "Claude Fable 5 can migrate 50 million lines of Ruby in a day. It can also silently decide you don't deserve its best answer — and not tell you. The story of the most capable public AI model ever shipped, and the transparency crisis it triggered within 48 hours."
pubDate: 2026-06-13
category: "AI"
tags: ["ai", "anthropic", "claude", "fable-5", "safety", "transparency"]
heroImage: "./images/fable-5-hero.png"
mediumUrl: "https://medium.com/@gvelosa/anthropic-built-the-most-powerful-coding-model-ever-then-they-secretly-weakened-it-a0c601f22f8d"
---
# Anthropic Built the Most Powerful Coding Model Ever. Then They Secretly Weakened It.

On June 9, Anthropic released Claude Fable 5. By most measures, the most capable AI model ever made available to the public.

Stripe used it to compress months of engineering into days, according to a case study published by Anthropic itself: a codebase-wide migration across 50 million lines of Ruby that would have taken a full team over two months was done in a single day. No independent verification of that claim exists. On the coding benchmarks that matter, Fable 5 scored 29.3% on FrontierCode Diamond (the hardest coding benchmark in existence), 80.3% on SWE-bench Pro (11 points ahead of the next-best), and 95% on SWE-bench Verified — leading on all three major coding evaluations, though Codex's GPT-5.5 remains competitive on older benchmarks like HumanEval. According to Anthropic's technical documentation, it can operate autonomously for multi-day sessions. It runs its own tests. It checks its own work with vision and orchestrates parallel sub-agents without waiting for human approval. It has a million-token context window and costs twice what Claude Opus 4.8 does: $10 per million input tokens, $50 per million output. At that price, you'd expect to get the model you're paying for.

Simon Willison, who spent five hours testing it on launch day and was one of the few independent developers to publish detailed findings, described it as having a "big model smell." Not just fast or expensive, but qualitatively different in how much it knows and how autonomously it operates.

Forty-eight hours later, Anthropic apologized for secretly degrading it.

## The two-tier architecture

Fable 5 is the public face of something Anthropic calls the Mythos class. The same underlying model ships in two versions. Claude Fable 5 is what anyone can use through the Claude API and Claude.ai. Claude Mythos 5 has the safety classifiers removed and is available only through a government-access program called Project Glasswing.

The safety architecture is intentional. On its surface, it's reasonable. Fable 5's guardrails are conservative by design: when a query trips a safety trigger, instead of refusing outright, Fable silently falls back to Claude Opus 4.8 — still a frontier-class model, just not the one you're paying for. Anthropic says this happens in less than 5% of sessions on average. The categories that trigger fallback are cybersecurity, then biology, then chemistry. All areas where a model this capable could cause real damage.

Mythos 5 gets the full power, unrestricted, and Anthropic describes it as "the strongest cybersecurity model in the world." Access is limited to cyberdefenders and infrastructure providers vetted through the US government, the logic being that the most dangerous capabilities should exist, but only behind institutional gates.

Then someone read the fine print.

## What was buried in Section 1.5

Claude Fable 5 shipped with a 319-page system card. Section 1.5 contained a paragraph that Anthropic presumably hoped would go unnoticed. It disclosed that the model would detect "requests targeting frontier LLM development" — specifically, building pretraining pipelines, distributed training infrastructure, or ML accelerator design — and "limit effectiveness" without notifying the user.

Not "refuse and explain." Not "fall back visibly and tell you." The system card was explicit: the restrictions would operate through prompt modification, steering vectors, and parameter-efficient fine-tuning. You ask Fable for help building distributed training infrastructure. Fable decides you might be distilling its outputs to train a competitor; it subtly degrades its answer through internal mechanisms. You never know. Anthropic estimated this would affect ~0.03% of traffic, concentrated in fewer than 0.1% of organizations.

This is different from every other safety mechanism in Fable. The cybersecurity fallbacks are visible; you get told when your query is redirected. The biology and chemistry restrictions work the same way. But the AI development restrictions were designed to be invisible. As the system card stated: "not visible to the user."

Fortune's Sharon Goldman broke the story on June 10, reporting that researchers had discovered the covert restrictions buried in the system card. The backlash was immediate and severe.

## "We made the wrong tradeoff"

Within 24 hours, Anthropic reversed course. In a statement to WIRED, reported by Maxwell Zeff: "We're changing Fable 5's safeguards for frontier LLM development to make them visible. We made the wrong tradeoff, and we apologize for not getting the balance right."

On X, Anthropic's developer account posted a longer explanation: flagged requests for frontier LLM development would now visibly fall back to Opus 4.8 (the same mechanism used for cyber and bio queries), with users seeing a notification every time it happened. On the API, flagged requests would return a reason for refusal.

The justification for the original covert approach was speed. Anthropic explained that "visible safeguards can be probed, so they have to be rigorous, which takes time to get right. Invisible safeguards can be targeted more narrowly, allowing us to ship quickly with very few false positives." They went with invisible safeguards to ship Fable 5 faster. The tradeoff was that users couldn't trust whether the answer they received was from the model they were paying for.

To be fair to Anthropic, the speed of their reversal matters. They shipped on June 9, the story broke on June 10, and by June 11 the policy was reversed with a public apology. That's faster than most companies respond to a PR crisis, let alone a structural safety decision. But the fact that they reversed it under pressure, rather than before launch, is the tell.

The national security framing added another layer. Anthropic told Business Insider the restrictions were designed to prevent "foreign adversaries" from using Fable to accelerate their own frontier AI development. The specific worry: a state-level actor with access to Fable could compress what would normally take years of capability research into months, closing a multi-year gap with Western labs in a fraction of the time. The reasoning has merit — Anthropic's own system card notes that recent models can "accelerate their own development," making frontier AI a genuine dual-use concern. The problem is that visible safeguards are also probe-able; adversaries can test exactly where the boundaries are and work around them. That's the real engineering tension, and Anthropic never publicly addressed how to solve it.

The cybersecurity community pushed back hard regardless. TechCrunch reported that security researchers found the guardrails "too strict for any cybersecurity work," effectively blocking them from using the most advanced public model for legitimate defense research.

## The paradox at the center

What makes the Fable 5 story more than a transparency scandal: the model's capabilities and its restrictions are both symptoms of the same underlying reality.

Fable 5 is powerful enough that Anthropic genuinely worried about what would happen if it was used at full strength for AI research and cybersecurity. That worry is legitimate. Models at this capability level can identify novel vulnerabilities and accelerate weapons-relevant research. They can help competitors close the gap. The safety concerns aren't theoretical. They're practical.

But the response, secretly degrading the model for certain categories of user without telling them, reveals a deeper problem. If the most capable public model needs covert restrictions to be safe, maybe it's too capable to release without a more robust safety architecture. And if the company that built it decides unilaterally what counts as "frontier LLM development" and who deserves the full answer, then every developer using the model is operating in a trust environment they can't verify. The fallback model was Opus 4.8, still frontier-class, still one of the best models in the world. But users paying $50 per million output tokens for Fable were getting Opus output at Fable prices without knowing it.

This isn't just about Anthropic. Every frontier lab faces the same tension. OpenAI ships GPT-5.5 through Codex with usage monitoring and content policies. Google's Gemini models have their own safety layers. Neither has been caught deploying covert restrictions — but neither has been scrutinized as closely as Anthropic was here. The question isn't whether safety mechanisms are needed. It's whether they can be honest.

Simon Willison, after Anthropic's walkback, put it plainly: "It would be a whole lot better if they dropped this category of refusals entirely."

## The trust equation

The Fable 5 incident reveals something the AI industry doesn't like to discuss. The relationship between frontier model providers and their users is deeply asymmetric.

The provider knows exactly what the model is capable of, what triggers its safety mechanisms, and what the user is really receiving. The user knows only what the model outputs. When the provider secretly changes the output based on invisible classifiers, that asymmetry becomes a trust deficit that no benchmark score can repair.

A better approach exists. Anthropic could have shipped Fable with visible restrictions from the start, accepted the engineering cost of making those restrictions robust against probing, and been transparent about the tradeoff. Slower to ship, yes. But a 319-page system card that buries covert restrictions in Section 1.5 is not transparency. It's liability management. The visible fallback model they deployed after the backlash proves they could have done it all along.

The classifier problem remains even with visible restrictions. A cybersecurity researcher using Fable to find vulnerabilities in their own infrastructure gets the same downgrade as a state-sponsored attacker. The model can't tell the difference. The classifier can only guess.

Stripe's 50-million-line Ruby migration worked because Stripe was using Fable for something no safety classifier would flag. But the next team that tries to use Fable for something adjacent to AI infrastructure development won't know if they're getting the real model or a polite downgrade — even after the walkback, they'll only know after the fact, when the notification appears.

## What this means for developers

Three things sit uneasily alongside each other.

Claude Fable 5 is, by most benchmarks, the most capable public coding model ever shipped. Codex's GPT-5.5 leads on some measures; the title depends on which test you pick. The Stripe case study, sourced entirely from Anthropic, is still impressive even without independent verification. The autonomous capabilities are real. So is the sticker shock.

Anthropic's safety concerns are also real. A model this powerful, unrestricted, in the wrong hands, could cause serious damage. The two-tier architecture is a genuine attempt to balance that: Fable for everyone, Mythos restricted to vetted institutions.

And the covert approach was wrong. Not because safety restrictions are wrong — they're necessary. But because a frontier lab that secretly degrades its model and hides it in a system card is asking developers to trust a platform that has already demonstrated it will withhold information when convenient. You can't build on a platform that might be silently holding back on you. You can't debug a system you can't see.

Anthropic reversed the policy in two days, which is faster than most companies manage. But the precedent is set: a frontier lab shipped covert restrictions on what counts as legitimate AI research, and only removed them when they got caught. The next company building a Mythos-class model is watching. Whether they choose visibility or opacity will depend less on what happened with Fable 5 and more on whether anyone is reading their system card.
