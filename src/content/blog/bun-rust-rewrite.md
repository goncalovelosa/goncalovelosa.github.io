---
title: "The $165K Rewrite"
description: "One engineer rewrote Bun from Zig to Rust in 11 days. 1M lines of code, $165K API bill, 64 Claude instances. What the numbers actually prove about AI-assisted engineering at scale.""
pubDate: 2026-07-10
category: "AI"
tags: ["ai", "coding"]
heroImage: "./bun-rust-rewrite/images/visual1-cover.png"
mediumUrl: "https://medium.com/@gvelosa/the-165k-rewrite-TBD"
canonicalUrl: "https://medium.com/@gvelosa/the-165k-rewrite-TBD"
---

In 11 days, a single engineer rewrote the entire Bun JavaScript runtime from Zig to Rust. One million lines of code. 6,502 commits. A peak of 695 commits in a single hour. The API bill came to $165,000.

Jarred Sumner, Bun's creator, estimates the same project would have taken three engineers a full year. During that year, bug fixes, security patches, and new features would have been frozen. The rewrite consumed 5.9 billion input tokens and produced 690 million output tokens. It fixed 128 bugs and improved performance by 2 to 5 percent. It shipped as Bun v1.4.0 in canary.

These numbers sound like marketing. They're the output logs of a real engineering project run by a real engineer using a pre-release version of Claude Fable 5. The question isn't whether AI can write code at scale anymore. Bun proved it can. The question is what the numbers tell us about the limits, the costs, and the trade-offs when you push AI-assisted engineering to the extreme.


## Why Bun had to leave Zig

Bun built its reputation as one of the fastest JavaScript runtimes by betting on Zig, a language that gives precise memory control at the cost of manual safety guarantees. That trade-off caught up with the team. Sumner's account opens with a long list of memory-safety bugs fixed in a single recent release: use-after-free crashes, double-free errors, memory leaks scattered across socket, crypto, and TLS handling.

The team had already added Address Sanitizer support, fuzzing, and Windows safety checks. The underlying pattern kept recurring. Zig gives programmers manual control over memory but no compiler-enforced guarantees against forgetting to free something or freeing it twice. Rust's borrow checker and its Drop trait, which automatically runs cleanup code when a value goes out of scope, turn most of that class of bug into compiler errors instead of runtime crashes.

Sumner's argument is straightforward. A style guide enforced through code review is a weaker line of defense than a compiler that refuses to build broken code. At over 500,000 lines of Zig, a full rewrite was the only structural fix. And a full rewrite at that scale was effectively impossible on a human-paced timeline.

## How the rewrite actually worked

The common mental model of AI-assisted coding is a developer typing a prompt and getting code back. The Bun rewrite looked nothing like that.

Sumner spent about three hours talking through the port with Claude to produce a document mapping Zig idioms to Rust equivalents, plus a lifetimes reference for how memory ownership should translate. He tested the approach on three files before scaling up to all 1,448 source files. Then he launched roughly 50 dynamic workflows running continuously in Claude Code over 11 days, each handling one phase: generating the porting guide, mechanically translating every file, fixing compiler errors crate by crate, getting CLI subcommands working, and chasing down failing tests.

The adversarial review process is the most interesting part. One Claude instance writes the code. Two separate instances, given only the diff and told to assume it's broken, try to find reasons it fails. The reviewers don't see the implementer's reasoning. They see only the output. Sumner compares this to how human code review works best when the reviewer has no stake in getting the change merged. He shares examples of real bugs adversarial review caught before merge, including a use-after-free in process-spawning code where a Box was being dropped before an asynchronous callback needed it. That bug would have shipped without the review loop.

At peak, four workflow shards ran in parallel, each with 16 Claude instances working in a separate git worktree. Around 64 instances running at once. Sumner hit practical snags along the way: instances stepping on each other by running git stash or git reset, IOPS limits on the EC2 instance that briefly froze disk I/O, and an early tendency for Claude to stub out functions with compilation errors rather than fix them, writing long comments justifying workarounds instead of addressing the underlying code.


## The honest numbers

The rewrite generated headlines for its successes. The failures deserve attention too.

Bun's test suite went from 972 failing files down to 23 within two days of the first continuous integration run. That's a 99.8 percent pass rate. Important caveat: test pass rate measures how many existing tests pass, not how many behaviors are correct. Code paths with no test coverage could contain silent regressions that nobody has detected yet. The 19 known regressions were caught by tests. The unknown regressions in untested code are the real concern.

The Rust codebase contains 13,044 unsafe blocks. AI Weekly reported that comparable hand-written Rust projects have about 73, though the comparison lacks a clear definition of "comparable" — a JavaScript runtime inherently requires more unsafe code than typical Rust applications due to FFI calls, garbage collection, and raw pointer operations. Still, the ratio is striking. Unsafe blocks in Rust allow specific operations like dereferencing raw pointers and calling unsafe FFI functions. The borrow checker stays active inside them, but the compiler stops verifying the safety of those specific operations. That means 13,044 places where the compiler is told to trust the programmer instead of proving correctness. The ratio suggests AI-generated Rust prioritizes getting code to compile over writing idiomatically safe Rust.

The $165,000 API cost is significant. Sumner didn't have to worry about it because Anthropic acquired Bun in December 2025. His team now works there. The acquisition is the part of this story that doesn't get enough attention. When the company that makes the model also owns the runtime being rewritten and the tool doing the rewriting, the economics stop being representative.

## The vertical integration question

Anthropic owns Claude. Anthropic owns Bun. Anthropic owns Claude Code. Sumner used Claude Code running Claude Fable 5 to rewrite Bun into Rust, and the result now powers Claude Code itself. Claude Code has been running on the Rust port since mid-June, with a 10 percent drop in startup time on Linux.

This circular ecosystem is a feature for Anthropic. The Bun rewrite is simultaneously a product improvement, a marketing case study, and a benchmark for Claude's coding capabilities. But it makes the economics non-transferable. A team outside Anthropic would pay full API rates, would not have pre-release model access, and would not have the creator of the tool being rewritten as the engineer running the workflows. They would also be paying the same company that owns the model to rewrite code that runs inside that company's own products. The incentives align perfectly when the model maker, the tool maker, and the runtime owner are the same entity.

The real cost of a comparable rewrite for an independent team would be higher. The infrastructure matters as much as the API spend: the ability to orchestrate 64 AI agent instances across a shared codebase without collisions, manage context across a million-line surface area, and verify outputs at the scale parallel operation produces. Add Sumner's salary, the EC2 instances, the time spent building the porting guide, and the cost of 11 rounds of security review post-merge. The true price tag is well above $165K. That number is the API consumption. The project cost is higher.

## What this means for engineering teams

The Bun rewrite is a calibration point. A year of senior engineer time, conservatively, exceeds $300,000 to $500,000 in fully-loaded cost. The $165,000 API spend delivered the migration in 11 days. The parallel architecture meant the wall-clock time compressed, not just the budget.

But the infrastructure requirement is the part most teams will underestimate. Sumner spent hours building the porting guide before touching the codebase. He tested on three files before scaling to 1,448. He ran adversarial review on every diff. He split the Rust codebase into roughly 100 separate crates and fixed 16,000 compiler errors. The 11 days were the sprint. The infrastructure that made the sprint possible took longer to build.

Memory that used to leak roughly 3 MB per Bun.build() call now levels off at 600 MB regardless of how many builds run. Binary size dropped about 20 percent on Linux and Windows. HTTP throughput improved 3 to 5 percent across several server frameworks. These are real wins. They came from an engineer who understood the codebase deeply, paired with a model that could translate at scale.

Teams sitting on legacy codebases in languages they want to migrate away from should pay attention. AI parallelism compresses the timeline, budget, and risk constraints simultaneously. It does not remove the judgment calls. Someone still has to decide which output to trust, which segments need human review, and how to test at the scale of the migration. The automation compresses the translation labor. The engineering leadership requirement stays the same.

The teams that build the orchestration infrastructure first will run these sprints successfully. The teams that try to start with the sprint will find out why the infrastructure matters. Bun proved the ceiling. Most teams will spend longer than 11 days just building the foundation to attempt it.
