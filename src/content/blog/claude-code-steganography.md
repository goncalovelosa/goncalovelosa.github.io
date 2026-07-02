---
title: "When the Code Reads You Back"
description: "Claude Code silently embedded invisible Unicode steganographic markers into system prompts. A trust story about AI coding tools and the transparency bar they must meet."
pubDate: 2026-07-01
category: "AI"
tags: ["ai", "coding"]
heroImage: "./claude-code-steganography/images/visual1-cover.png"
mediumUrl: "https://medium.com/@gvelosa/when-the-code-reads-you-back-TBD"
canonicalUrl: "https://medium.com/@gvelosa/when-the-code-reads-you-back-TBD"
---

Every time you start a Claude Code session, it injects a system prompt. One line says: "Today's date is 2026-07-01." You've seen this line a thousand times. You've never looked at the apostrophe.

A developer did. And what they found rewrote the conversation about trust in AI coding tools.


## The apostrophe that wasn't

On June 30, a developer reverse-engineering Claude Code's binary noticed something wrong with the punctuation in that date line. The apostrophe in "Today's" was not always the apostrophe you'd expect. Sometimes it was U+2019, the right single quotation mark. Sometimes U+02BC, the modifier letter apostrophe. Sometimes U+02B9, the modifier letter prime.

To your eyes, these characters are identical. To a machine parsing the raw bytes, each one encodes a different signal.

This was not a font rendering issue. It was steganography: hidden information, embedded in what looks like ordinary text, designed to be invisible to the person reading it but perfectly readable by the server receiving it.

The date separator was also being modified. If your system timezone matched Asia/Shanghai or Asia/Urumqi, the format flipped from 2026-07-01 to 2026/07/01. A slash instead of a dash. Invisible in plain sight.

## What the code does under the hood

When you run Claude Code, it checks an environment variable called ANTHROPIC_BASE_URL. If you're using Anthropic's API directly, nothing happens. The fingerprinting code never fires. But if you set a custom base URL, pointing Claude Code through a corporate proxy, a model router, or any third party gateway, a four-step pipeline activates.

First, the tool extracts your proxy hostname. Second, it reads your system timezone. Third, it runs both against two hidden lists. The first contains 147 entries covering Chinese corporate networks, cloud infrastructure regions, AI labs, and a catalog of Claude API reseller domains. The second holds eleven AI lab keywords: deepseek, moonshot, minimax, zhipu, baichuan, stepfun, dashscope, among others.

Both lists were stored in the binary as base64-encoded strings, decoded at runtime using XOR with key 91. XOR obfuscation is a technique more commonly associated with hiding malware from antivirus scanners than with production software distributed to developers.

Fourth, the classification result was encoded into the "Today's date is…" line of the system prompt. The apostrophe variant and the date separator together formed a covert classification tag. A small set of flags, riding inside every system prompt sent from your machine, readable by Anthropic's servers, invisible to you.

The code had been shipping since version 2.1.91, released April 2, 2026. Nearly three months of silent fingerprinting across dozens of releases, with zero mention in any changelog or release note. Independent researcher Adnane Khan verified the mechanism in versions 2.1.193, 2.1.195, and 2.1.196, calling it "a covert information channel embedded in system prompts."

## Anthropic had a real reason

Here's where this gets complicated. Dismissing Anthropic's motivation would be intellectually dishonest.

In February 2026, Anthropic publicly disclosed that three Chinese AI labs had collectively run more than 16 million exchanges with Claude through approximately 24,000 fraudulent accounts. DeepSeek, Moonshot AI, and MiniMax were systematically extracting Claude's reasoning, coding, and agentic behaviors to train competing models. In June, Reuters reported that Anthropic told US senators Alibaba's Qwen lab had executed an even larger campaign: 28.8 million exchanges through nearly 25,000 fake accounts between April 22 and June 5.

These are documented, named, ongoing industrial-scale IP theft campaigns. Anthropic framed them as a national security concern in Senate testimony, not just a terms-of-service dispute. The threat is real.

There's also an export control dimension. US Commerce Department rules and the AI Diffusion Framework place legal obligations on AI companies to prevent unauthorized access from restricted regions. Anthropic may have been navigating genuine compliance pressure when it built this detection mechanism. The motivation isn't just corporate IP protection. It overlaps with federal enforcement.

A custom API base URL pointing at a domain from a known Chinese AI lab, combined with a Chinese timezone, is a plausible signal that someone is routing Claude requests through lab infrastructure for distillation. The detection logic makes sense. If you were Anthropic's security team and you saw this pattern, you would want to flag it.


## Why the method is still wrong

The goal being legitimate does not make the implementation acceptable. This is the part of the story that matters most, and it's where most of the coverage gets fuzzy.

The core developer criticism is not "how dare Anthropic protect its IP." It is "why was this hidden?"

Developers route Claude Code through internal API gateways for entirely legitimate reasons. Secrets management. Credential injection. Data filtering. Model routing across multiple providers. Cost management. These are standard enterprise practices. Every one of those developers was being silently fingerprinted alongside the actual bad actors. The detection net was blunt. If your hostname didn't match the official endpoint, you were classified. Period.

The technique opens a specific kind of trust hole that is extremely hard to close. Disclosed telemetry is something developers can evaluate, block, or consent to. A modification to invisible prompt characters is something developers cannot inspect without reverse-engineering the binary. The asymmetry is the problem. You gave Claude Code shell access to your repositories. It used that access context to hide a classification system you couldn't see.

The fingerprinting is also, by most technical assessments, ineffective against its stated target. A sophisticated adversary defeats it trivially: randomize the proxy hostname, change the timezone setting, patch the binary, wrap the process. Any serious distillation pipeline running 28 million exchanges would bypass this in minutes. The population it reliably captures is not adversarial Chinese AI labs. It is legitimate developers who happen to use corporate gateways.

Transparent, documented anti-abuse measures would have achieved the same goal. Public blocklists. Explicit terms of service enforcement. User-visible flags when a proxy is detected. A simple notification saying Claude Code detects a non-standard API endpoint and your requests will be tagged for abuse prevention. That sentence costs nothing and prevents the entire scandal.

## The pattern nobody is talking about

This incident does not stand alone. And that's what elevates it from a one-off mistake to a systemic concern. Though to be precise, the fingerprinting and the sandbox issues are categorically different: the steganography was an intentional design decision. The sandbox bypasses were security vulnerabilities. What unites them is the response: both were fixed without transparent communication.

According to reporting from TechTimes, a security researcher named Aonan Guan disclosed in May 2026 that Claude Code's network sandbox had contained a SOCKS5 hostname null-byte injection vulnerability across approximately 130 releases. The sandbox had been broken for over five months. Anthropic fixed the flaw without publishing a security advisory, without assigning a CVE, and without notifying users.

That was reportedly the second sandbox bypass, not the first. An earlier flaw caused the sandbox to interpret an empty allowlist as "allow all traffic" rather than "block all traffic." Also fixed silently. Also without disclosure.

Two separate sandbox bypasses. One steganographic fingerprinting system. All hidden. All fixed without transparent communication. All from a company whose brand identity is "the safety-first AI lab."

The gap between Anthropic's marketing and its engineering communication is the actual story. Safety-first companies don't get to claim the brand while shipping obfuscated detection code and silently patching sandbox bypasses. The standard has to apply in both directions.

## What this means for every AI coding tool

If you use Cursor, Copilot, Windsurf, Codex, or any other AI agent with filesystem and shell access, this story applies to your tools too.

AI coding agents have deeper and more aggressive access than most software on your machine. They read your source code. They execute shell commands. They edit files. They push to git remotes. IDEs and package managers have similar permissions on paper, but AI agents exercise that access autonomously, taking actions you didn't explicitly approve. The transparency bar for autonomous access must be higher than for a tool that waits for your click.

Every AI coding tool vendor should be asking what their binary does that they haven't told developers about. What environment data they collect. What classifications they embed. What telemetry runs without explicit consent. If the answer is "nothing," say so publicly. If the answer is "something," disclose it before someone reverse-engineers the binary and writes the headline for you.

## What you can do today

Anthropic acknowledged the code was present and shipped version 2.1.197 to remove it, within hours of the story breaking. To their credit, the response was fast. But the changelog for that version reportedly doesn't mention the removal. For a company that built its reputation on transparency, shipping a silent fix for a silent problem is its own kind of message.

If you run Claude Code through a corporate proxy, update to 2.1.197 or later. The fingerprinting code is gone. Your past requests, however, were tagged.

For ongoing protection, audit your AI tools the way you'd audit any privileged software. Route AI agent traffic through a transparent proxy you control so you can inspect egress. Run AI coding tools in containers with restricted filesystem and network access. Maintain an egress manifest listing every external endpoint the tool communicates with. Ask vendors for SOC 2 reports and security advisories. And when a new version drops, check the binary for strings related to fingerprinting, tracking, or classification before upgrading.

One developer reading the code forced a fix within days. That's the lesson. Inspectability works. Transparency works. The tools we depend on are only as trustworthy as our ability to verify what they're doing behind the scenes.

The apostrophe in "Today's date is" looks normal now. But you'll never look at it the same way again.
