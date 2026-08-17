---
title: "The models forgot on purpose"
description: "Small models now top reasoning benchmarks while hallucinating 82% of plain facts. The knowledge-for-reasoning trade is measurable, deliberate, and it moves the knowledge into your harness."
pubDate: 2026-08-17
category: "Engineering"
tags: ["artificial intelligence", "large language models", "machine learning", "qwen", "llm benchmarks", "hallucination", "retrieval augmented generation"]
heroImage: "./llm-knowledge-for-reasoning-tradeoff/images/cover.png"
---


A 9-billion-parameter model from Alibaba is currently the smartest thing you can run under 10B parameters. On Artificial Analysis's intelligence index it scores 32, roughly double the next best model in its weight class. It fits in 6GB of VRAM quantized. It reasons through math and code at a level that outscores models well above its weight class.

Ask it a plain factual question and it will usually make up the answer. Artificial Analysis's knowledge benchmark, AA-Omniscience, measures what happens when a model answers beyond what it knows: the Qwen3.5 9B invents a confident, plausible, wrong fact 82% of the time. Its 4B sibling does it 80% of the time, with 14.7% and 12.8% factual accuracy respectively. These are the same models topping the small-model reasoning charts. That is the design point.

## The trade, measured

Two benchmark axes used to move together. More parameters bought you more reasoning and more knowledge. They have split.

On the reasoning axis, small models are improving at a pace nobody predicted. GLM-5.2 scores 99.2% on AIME 2026 with about 40 billion active parameters per token. Qwen3.5 hits 91.3% with 17 billion active. DeepSeek V4-Flash runs on 13 billion. GPT-4 in 2023, a model rumored around 280 billion parameters, could barely crack a single AIME problem. Three years ago none of this arithmetic was on anyone's curve.

On the knowledge axis, the best model money can buy is Gemini 2.5 Pro at 53% on SimpleQA, a benchmark of plain factual recall with no tools allowed. The average across the 34 models evaluated sits at 18.9%. The frontier of factual recall misses half the questions. The small models barely register as knowing anything at all.

And the leaderboard hides the closest thing to a controlled comparison the public data offers. Alibaba's Qwen3 235B scores 50.6 on SimpleQA in its Instruct configuration. The Thinking variant of the same family, tuned to reason harder, scores 12.7. Same family, same scale, reasoning dialed up, factual recall drops fourfold. The two variants differ in more than reasoning effort, so treat it as suggestive, short of controlled. It is still the starkest public evidence that reasoning-first training burns knowledge out of the weights.

A NeurIPS 2025 paper from Grab measured the effect directly. Reasoning-oriented reinforcement learning significantly increases hallucination prevalence. The authors traced the mechanism through RL training dynamics, high-variance gradients and entropy-induced randomness pushing the model toward plausible-sounding fabrication, and proposed a factuality-aware training method to fight it. The trade has a mechanism, and it was published.

No lab publishes a roadmap that says we are cutting knowledge. The evidence for intent is in what gets trained on, and in what falls out. It may even be an accident of optimization instead of a choice. But the economics point one direction regardless, and the economics are measurable.

## Two bits per parameter

Why would the trade happen at all? Because facts are expensive and procedures are cheap.

The cleanest measurement comes from the Physics of Language Models series, published at ICLR 2025. Language models can store about 2 bits of factual knowledge per parameter. Two bits. A single yes/no fact about the world costs half a parameter, and a model that knows the birth year of every minor Wikipedia figure, the population of every Dutch municipality, and the argument order of every npm package pays for all of it in weights. That bill is a large part of why frontier models grew to trillions of parameters.

Reasoning compresses to almost nothing by comparison, because it is a small set of procedures applied over and over. Decompose the problem. Track intermediate state. Check your own work. Backtrack when a step fails. Distillation and reinforcement learning on verifiable tasks transfer those procedures into small models remarkably well, and the model does not need to know anything about the world to execute them. It needs to know what algebra is.

Microsoft's Phi-4 is the purest demonstration. Fourteen billion parameters, trained heavily on synthetic textbook-style data, strong at math. On SimpleQA it scores 2.3%, fourth from the bottom of a 34-model field. The model is exactly what its training data contained. For years that profile looked like a limitation of the synthetic-data approach. It was the specification.

## Facts rot, procedures don't

There is a second reason, and it compounds the first.

A frontier training run takes months and costs hundreds of millions of dollars, and the facts inside it start going stale the moment it finishes. Library APIs change. Prices change. People change jobs. Half of what a 2024 model believed about the JavaScript ecosystem was outdated before the model shipped. Every fact baked into weights has a shelf life, and the only refresh mechanism is another training run.

The procedures don't rot. Algebra worked the same in 1970 as it does now. So does spotting a contradiction between two sources. A model that is mostly procedure and lightly loaded with facts ages slowly. Its training cutoff stops mattering, because the current state of the world was never supposed to live in the weights in the first place. The expensive, slow artifact gets decoupled from the thing that changes daily.

Strip the knowledge out and something else happens too: the model shrinks toward its active parameter count. DeepSeek V4-Flash reasons with about 13 billion active parameters but drags roughly 270 billion total along in its expert layers, and one analysis reads those experts as mostly fact storage. Cut the facts and the total size collapses toward the reasoning core. A 20-to-40B model at 4-bit quantization fits on the 24GB consumer card that has been sitting in gaming PCs since 2022, reasoning at frontier quality, knowing almost nothing, looking everything up.

## The knowledge moved, it didn't vanish

If the model doesn't know things, something else has to. That something is the harness: retrieval over a knowledge base, tool calls, web search, the filesystem. Value has been moving out of the model and into the surrounding software for a while, and DeepSeek open-sourcing its entire agent harness earlier this month was the same migration seen from the product side. This is the mechanism underneath it. Knowledge is the expensive, rotting part of a model. Reasoning is the compressible part. The labs cut the expensive part and handed its job to the runtime.

Watch a coding agent and you can see the new division of labor. It doesn't need your dependency's API surface memorized, because it greps node_modules and reads the docs before calling anything. The answer is grounded in the version you actually have installed, and the harness supplies whatever the weights never learned. Recall that used to be a fixed cost in every forward pass became an on-demand lookup.

This even improves the failure mode. When a fact lives in weights, a wrong fact is unfindable. You can't grep the weights. You can't diff them against last month. When the fact lives in a retrieved document, a wrong answer has an address: the model cites the document, you open the document, you fix the document, and every future query inherits the correction. A wrong fact in a knowledge base is an ordinary data bug, the kind engineers already know how to trace and regression-test. Retrieval doesn't reach zero hallucination. A claim with a source is checkable, and a claim from weights isn't.

The same property that makes the knowledge base auditable makes it a compliance surface. If your agent's world knowledge lives in your retrieval corpus, then PII handling, data licensing, and deletion requests now live there too. That is the cost side of the addressability win, and for most organizations it is a manageable cost, because data governance is a solved discipline in a way that weight surgery is not.

## What the buyers should do

Three practical consequences fall out of the data.

First, stop reading leaderboards as one number. The Qwen3.5 9B tops its class on intelligence and fails 82% of factual probes. Any evaluation that averages those axes into a composite is lying to you in both directions. Score reasoning and knowledge separately, weighted by what your workload actually does, and probe with questions drawn from your own domain, because benchmark hallucination rates do not transfer to your private data distribution.

Second, the improvement story is subtler than the benchmarks imply. Comparing Qwen3.5 to its Qwen3 predecessors, the knowledge gain came from hallucinating less at the same accuracy, 14.7% versus 12.8%. The models didn't learn more facts. They got slightly more willing to abstain. That is honesty, which is valuable, but it is a different commodity than knowledge, and your architecture should know which one it is consuming. It is also early. Abstention moved a few points in one generation.

Third, reasoning is paid in tokens, and the small models pay most. Running the Artificial Analysis intelligence index consumed 230 to 390 million output tokens for the small Qwen3.5 models, against 57 to 109 million for frontier models. Simon Willison documented the same economics from the user side: Qwen 3.8 27B, a later generation left on its default reasoning effort, spent 21 minutes and 22,276 thinking tokens to draw a pelican on a bicycle, then produced a worse-but-usable result in 137 seconds and 3,715 tokens once he switched reasoning off. The reasoning you are buying is real. The unit economics still favor the small models, at OpenRouter prices a Qwen3-class model costs a twentieth of Gemini 2.5 Pro per output token, so even a tenfold token flood lands cheaper. Budget for the flood, not the rate.

One failure mode deserves a name before you buy anything. A model that reasons well and knows nothing will build impeccable arguments on invented premises. Reasoning quality multiplies the damage of a hallucinated fact, it doesn't contain it. The 9B doesn't fail dumb, it fails eloquently, and unless the harness intercepts the premise, the error arrives more persuasive than a knowledge-heavy model's mistake ever was. This is the strongest argument for treating retrieval quality as part of the model, and it is the trade's honest cost.

## The endpoint

Follow the trend line and you get a model with frontier-quality reasoning running on a single consumer GPU, no per-token bill, no data leaving the machine. It will know almost nothing. Asked a bare factual question with no tools attached, the right behavior is to say it doesn't know and go look it up, and the training is starting to bend that way.

Paired with a decent harness, that covers most of what people use frontier models for today. The model contributes procedure. The world's current state arrives at runtime, the same way a CPU gets handed a program.

There is a version of this future where the model card stops listing a knowledge cutoff at all, because what's in the weights goes stale on a scale of years, and everything else got an address.
