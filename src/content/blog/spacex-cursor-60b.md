---
title: "SpaceX Just Bought Cursor for $60 Billion. Your Code Is the Product."
description: "SpaceX acquired Cursor for $60 billion. One million developers, 50,000 companies, and a data pipeline now flowing to a company whose AI division is under active investigation. The deal terms, the privacy implications, and the governance question every developer should be asking."
pubDate: 2026-06-17
category: "AI"
tags: ["ai", "spacex", "cursor", "developer-tools", "privacy", "acquisition"]
heroImage: "./spacex-cursor-60b/images/VISUAL_1_cover.png"
---

On June 16, 2026, four days after the largest IPO in history, SpaceX exercised its option to acquire Anysphere, the company behind Cursor, for $60 billion in stock. The deal values an AI coding editor at more than twice what Facebook paid for WhatsApp. It gives Elon Musk's empire direct access to the daily workflows of one million developers at 50,000 companies, including 40,000 engineers at NVIDIA and the entire engineering team at Coinbase.

The headline number is staggering. The deeper question is simpler. What exactly did SpaceX buy for $60 billion, and what does it mean for the developers who open Cursor every morning?

## What SpaceX bought

Cursor is not just an editor. It is a surface. Every time a developer types a prompt, accepts a suggestion, rejects a refactor, or debugs an error, that interaction flows through Cursor's backend. The company's own data-use policy is clear about what happens when Privacy Mode is turned off, which is the default for most individual users on the $20 Pro tier.

> "We may use and store codebase data, prompts, editor actions, code snippets, and other code data and actions to improve our AI features and train our models."

Codebase data. Prompts. Editor actions. Every keystroke that shapes a suggestion, every rejection that reveals a preference, every debugging path that exposes a mental model. This is not metadata. It is the raw material of how developers think and work.

SpaceX's IPO filing made the strategic logic explicit. Cursor's access to developers' data, including coding requests and design decisions, could help improve its AI models such as Grok. Grok is the chatbot built by xAI, which SpaceX absorbed in February. In other words, the filing acknowledges what the data is worth: developer interactions in Cursor can feed Grok's training pipeline.

Cursor offers Privacy Mode, which prevents data from being used for training. Enterprise customers get Zero Data Retention agreements with model providers. These protections are real, and they matter. But Privacy Mode is an opt-in setting that many individual developers never enable. Enterprise contracts with stronger data guarantees cover significant ground — 64 percent of Fortune 500 companies use Cursor, according to ByteIota — but millions of individual developers on Pro and free tiers sit outside those agreements. The gap between the protection that exists and the protection developers use is where the concern lives.

## The company holding your data

![Hundreds of small glass vials on dark slate connected by copper tubes to a massive central brass reservoir](./spacex-cursor-60b/images/VISUAL_2_illustration_1.png)
*Every session, every prompt, every accepted suggestion — flowing toward a single collector.*

Here is where the acquisition stops being routine.

The entity acquiring Cursor is not a neutral technology conglomerate. SpaceX absorbed xAI in February 2026. By March, all eleven of xAI's original co-founders had departed. The Grok chatbot facilitated the generation of over one million sexual deepfakes, including imagery of minors, according to reporting by ByteIota citing NBC News. The California Attorney General launched a formal investigation. The European Union opened its own probe. Malaysia and Indonesia banned the platform outright. A class action lawsuit is underway. A former employee told The Verge that "safety is a dead org at xAI."

Musk himself has reportedly pushed to make Grok "more unhinged," framing safety measures as censorship.

This is the AI division that now sits inside the company buying your coding editor. The same corporate parent that controls Grok will control the data pipeline flowing from one million developer sessions per day. The connection between Grok's content moderation failures and developer data privacy is not direct — one is a safety culture problem, the other is a data governance question. But the common thread matters: a company that has demonstrated weak internal guardrails on how its AI products handle user inputs is now positioned to receive the most sensitive professional data most developers produce.

SpaceX's IPO prospectus disclosed a dual-class share structure that gives Musk approximately 85 percent of voting control. No board override. No shareholder revolt. No activist investor can force a change in how developer data is handled. The governance model is, for practical purposes, a single-decision-maker structure.

SpaceX has enormous incentives to act responsibly. It carries enterprise and government contracts worth billions. It is now publicly traded under SEC oversight. Reputation matters. But incentives are not guarantees, and the concentration of voting power in one person makes the margin for error narrower than it would be under any other corporate structure.

## The irony machine

The competitive dynamics around this deal would be funny if the stakes were not real.

Anthropic, whose Claude Code is Cursor's most direct competitor in the AI coding space, pays SpaceX $1.25 billion per month for compute capacity on the Colossus 1 data center. That is a $15 billion contract running through May 2029. The company that builds the AI model competing with Cursor's built-in Composer is simultaneously financing the infrastructure of the company acquiring Cursor.

Meanwhile, Cursor maintains contracts with both Anthropic and Google to offer their models inside the editor. Those contracts contain 90-day termination clauses. Once the acquisition closes in Q3 2026, SpaceX can begin routing queries to its own infrastructure and models. The company does not need to kill Claude or GPT integration inside Cursor. It simply needs to make the economic and technical case for routing more traffic through Colossus and Grok Build, the coding agent xAI has been jointly training with Cursor for months.

The pattern across the industry is unmistakable. OpenAI acquired Ona for persistent Codex sandboxes. Anthropic doubled down on Claude Code and locked in 220,000 GPUs through SpaceX. GitHub Copilot rewired its entire billing model to usage-based credits on June 1. The labs are not just building models. They are buying the surfaces where developers work.

## What changes

![An antique brass key ring with three old keys on a weathered door, a corporate suit cuff reaching to take them](./spacex-cursor-60b/images/VISUAL_3_illustration_1.png)
*The keys to the tool you use every day, changing hands.*

The honest answer, today, is nothing. The deal closes in Q3 2026 pending regulatory approval. Cursor operates as a wholly owned subsidiary. Pricing stays the same. Privacy Mode stays. Claude, GPT, and Gemini remain available inside the editor.

But the market is already moving. Cursor's market share among AI coding tools dropped from 41 percent in June 2025 to roughly 26 percent by May 2026, according to spending data from Ramp, which tracks corporate card transactions. Anthropic now controls half the category. On Hacker News, the reaction to the acquisition was blunt. "The X brand is absolutely toxic, especially in enterprise," one developer wrote. Multiple commenters said they were already migrating to Claude Code or Windsurf.

Enterprise procurement teams are sitting on a vendor identity question. Legal and security teams that approved Cursor under Anysphere's data handling agreements now need to re-evaluate under a SpaceX parent company with 85 percent concentrated voting control, an AI division under active investigation, and an S-1 that explicitly mentions using developer data to train Grok.

None of these concerns are addressed in the S-1. Data residency, subprocessor disclosure, and zero-data-retention guarantees under new ownership are not mentioned.

## The question that matters

The temptation is to frame this as a SpaceX problem or an Elon Musk problem. It is neither. It is a structural problem.

When the surface where you write code is owned by the same company that trains the models, uses your interactions as training data, and answers to a single person with 85 percent voting control, the developer is no longer the customer. The developer is the data source. This is not unique to Cursor. GitHub Copilot, Claude Code, and every AI coding tool with a free or low-cost tier operates on the same logic. The difference is who sits at the top of the chain, and what they are legally and culturally capable of doing with what flows through it.

Privacy Mode helps. Enterprise contracts help. Competition helps. Cursor's declining market share proves developers are willing to switch tools when trust erodes. These are real protections, and they should not be dismissed. Developers chose Cursor because it works — the editor is fast, the completions are good, and the agent workflow saves hours every week. That utility is real, and no acquisition erases it.

But $60 billion is not a charity investment. SpaceX paid that price because one million developers produce something worth having. The same dynamic applies to Claude Code, which runs on SpaceX compute infrastructure, and to GitHub Copilot, which feeds Microsoft's model training. The difference is governance. The difference is who sits at the top, and what they can do with what flows through.

Do you know where your code is going?
