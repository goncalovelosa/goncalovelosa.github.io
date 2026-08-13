---
title: "Encrypted against you, plaintext to your cheaper model"
description: "Researchers extracted 315,320 reasoning blocks from public agent logs using a decryption oracle attack. 182 credentials leaked. The encryption was real. The key management was not."
pubDate: 2026-08-13
category: "Engineering"
tags: ["ai", "llm security", "reasoning extraction", "chain of thought", "encryption", "agent logs", "prompt injection"]
heroImage: "./llm-reasoning-extraction/images/cover.png"
---

The encrypted reasoning blocks that Anthropic, OpenAI, and Google hand back to API clients are real AEAD ciphertext — nonce, authentication tag, the works. The encryption works. The key management does not.

Every user's reasoning blocks were encrypted under the same provider-wide key, with no binding to the session, account, or model that produced them. That left a hole big enough to drive a cheaper sibling model through.

Take an encrypted reasoning block produced by Claude Opus 4.8. Inject it into a call to Claude Haiku 4.5. Ask Haiku to transcribe what it sees. The provider decrypts the block server-side on the way in, feeds the plaintext reasoning into Haiku's context window, and Haiku prints the frontier model's hidden reasoning, word for word. No cryptography was broken. The server performed the decryption itself, correctly, with the correct key. The flaw is that it would do this for any caller holding any valid block.

A research team from ELLIS Institute Tübingen and Max Planck Institute scaled this into a credential harvest. They scraped 315,320 encrypted reasoning blocks from public repositories, decoded them through the oracle technique, and found 182 credentials: API keys, passwords, authentication tokens. Sixty-two API keys. Thirty-three passwords. The remaining 87 were other credential types the paper does not fully itemize. They also found 367 pieces of personally identifiable information, some overlapping with the credential set.

The vulnerability is patched. All three providers deployed server-side mitigations after responsible disclosure, and this article is about the logs that were already public when the patch landed — and about what "encrypted" means when the person holding the ciphertext can hand it to a different model that will decode it for them.

## How stateless reasoning works

Modern reasoning models like Claude Opus 4.8, GPT-5.6, and Gemini 3 generate extensive internal chains of thought before producing a visible answer, and providers do not want competitors harvesting these traces for model distillation. The traces also sometimes contain sensitive information the model picked up from user context.

Rather than storing these traces server-side, providers encrypt them and hand the ciphertext to the client. The client passes the opaque blob back with each subsequent API request to maintain conversational continuity. The provider decrypts on receipt and continues. No server-side session storage. The client holds the state but cannot read it. Not in theory.

In practice, the encryption used a shared secret. If keys had been scoped to an account or session, a block from account A would fail to decrypt under account B. It did not. The blocks were portable across users and sessions because the design prioritized frictionless model switching and automatic failover across a provider's model family — a defensible product requirement whose security cost was either missed or judged acceptable. The result was cryptographic protection that held against everyone except the provider's own discount model.

## The decryption oracle

The attack does not require breaking encryption. It requires a cheaper model and a simple prompt.

The researchers injected an encrypted reasoning block produced by Claude Opus 4.8 into a call to Claude Haiku 4.5. Haiku is cheaper, faster, and far less heavily safeguarded. They asked Haiku to transcribe the reasoning, then set an assistant turn prefix to prime the output, and the provider decrypted the block server-side, fed the plaintext into Haiku's context, and Haiku read it as legitimate context. It printed the frontier model's hidden reasoning verbatim. The whole attack. Every step. Visible to anyone reading the API documentation.

The same technique worked across OpenAI and Google. GPT-5.6 traces replayed into GPT-5-mini. Gemini 3 Pro traces replayed into Flash.

To validate the extraction, the researchers compared decoded token counts against the billable thinking-token counts that provider APIs report. The lengths matched. Necessary but not sufficient evidence of faithful transcription. The paper also reports validation through semantic similarity and injected canary strings.

## What they found in public logs

This is the part that should make anyone who has shared an agent session log uncomfortable.

Developers paste full agent traces into bug reports, GitHub issues, gists, blog posts, and committed debug output constantly. The encrypted reasoning blobs sit there looking like protocol overhead. Everyone treats them as unreadable noise.

They were readable. By anyone with API access and a weaker model.

The research team scraped 315,320 encrypted reasoning blocks from public repositories, and of those, roughly 549 contained sensitive artifacts — a hit rate of about 0.17 percent. That is low density across the full corpus, but the blocks containing secrets were concentrated in agent sessions that had accessed configuration files, environment variables, or tool outputs. In some cases, the recovered PII was not even in the user's visible input. The model had pulled it from its own memory or from tool output during reasoning, and the visible response never mentioned it. A developer who carefully sanitized the visible transcript before sharing still leaked everything the model thought about.

There is a separate failure here that the encryption design did not cause and cannot fix. If an agent's reasoning contains live API keys and passwords, the system has a secret management problem. The agent had plaintext access to those secrets, reasoned over them, and they entered the reasoning trace. Encrypting the trace harder, per-account or per-session, changes who can read it after the fact. It does not stop secrets from entering the reasoning in the first place.

## The disclosure timeline

Johns Hopkins cryptographer Matthew Green spent a weekend in May 2026 testing encrypted reasoning blobs, and he demonstrated that blocks could be replayed across sessions and across separate user accounts. In one case, a social security number that appeared in one session's reasoning reappeared, unprompted, in a different session on a different account after the block was replayed. The blocks were semantically active. They were never inert containers.

Green reported the cross-session replay through the providers' bug bounty programs. OpenAI called the report unreproducible. Anthropic said it did not see security implications in side channels or replays, though it allowed it might update developer documentation. Google's response was not publicly detailed.

It is worth separating what Green reported from what the paper later proved. Green showed cross-session and cross-user replay. The paper, published in August, demonstrated the cross-model decryption oracle, at-scale credential extraction from public repositories, and invisible prompt injection.

The providers' triage responses were to a narrower finding, and their assessment that replay alone was lower-severity was defensible at the time. The critique that holds is narrower: cross-user and cross-session portability of encrypted reasoning should have triggered key rework on its own merits, because the oracle attack was a foreseeable consequence of a shared key plus a model family that includes cheap, lightly-guarded siblings.

## The invisible injection problem

The fourth attack vector in the paper has the longest tail. An attacker crafts malicious instructions inside an encrypted reasoning block. When processed by an agent, monitoring tools inspecting the visible conversation see nothing unusual. The payload hides inside what looks like API bookkeeping.

The paper also describes a variant where models treat their own reasoning traces as trusted context. Simon Willison, writing about the paper, observed that instructions embedded in reasoning blocks appear to be followed more readily than the same instructions delivered through normal user input. This is a plausible hypothesis worth taking seriously, and whether the paper quantifies this trust asymmetry experimentally is worth checking before stating it as established mechanism.

The server decrypts the block before feeding it to the model. Providers therefore have full access to the plaintext reasoning at injection time and could, in principle, run content scanning or policy enforcement on decrypted reasoning blocks server-side. The injection surface is real. It has a server-side mitigation path that does not require any change to client-side agent architecture.

## What the providers should have done

The proposed fixes are not exotic. Bind each reasoning block to the session identifier that produced it. Derive encryption keys per account rather than globally. Bind blocks to the issuing model so cross-model replay fails. Enforce nonce or sequence numbers to prevent same-session out-of-order replay. Standard cryptographic hygiene.

Scoping a key to the session and identity that produced it is standard cryptographic practice, and its absence across all three major providers suggests a product decision whose security cost was either missed or judged acceptable. That is a stronger indictment than simple oversight.

Key rotation for historical ciphertext in public repositories is a harder problem. The blocks were encrypted under the old global key, and anyone who scraped and oracle-decoded them before the patch already has the plaintext. Rotating keys now prevents future replay through patched APIs. But that replay path is already closed. The historical exposure is permanent.

Green also flagged a side channel that better cryptography cannot fix. If a model reasons over a secret, the shape of that reasoning leaks. Reasoning token counts. Block length. Even wall-clock response time. All of these vary depending on what the model is thinking about. That leak is in how much the model thinks. Patching the encryption does not close it.

## What you can do today

If you have ever published a Claude Code session log, a Codex transcript, or any agent trace containing encrypted reasoning blocks, assume those blocks have been or can be decoded. The oracle attack was feasible before the August patches. It required nothing beyond standard API access.

Audit your shared traces. Search your repos, gists, and issue comments for long base64 blobs in `thinking`, `reasoning`, or `signature` fields. Rotate any credentials the agent could have read during those sessions. Everything. Not just what appeared in the visible output. Anything in config files, environment variables, tool outputs the model could have accessed.

Going forward, strip reasoning blocks before sharing agent logs. Treat them as sensitive payload. The blobs looked like noise because the providers said they were encrypted, and they were encrypted — but the encryption just did not protect against the provider's own model family, which any API caller could invoke to decode the contents.

The reasoning traces in public repositories were never safe from anyone who understood the architecture. The providers have patched the live attack. They have not patched the logs already indexed by search engines. Those blocks were encrypted under a global key, and the decryption oracle was a model that costs less than a dollar per million tokens to run.
