---
title: "The Agent Loop Is the New Prompt Engineering"
description: "How self-scaffolding RL in Ornith-1.0 moves agent loop design from manual prompt engineering into model training."
pubDate: 2026-06-29
category: "AI"
tags: ["ai", "coding"]
heroImage: "./self-scaffolding-agent-loop/images/visual1-cover.png"
mediumUrl: "https://medium.com/@gvelosa/the-agent-loop-is-the-new-prompt-engineering-TBD"
canonicalUrl: "https://medium.com/@gvelosa/the-agent-loop-is-the-new-prompt-engineering-TBD"
---

Boris Cherny, who leads Claude Code at Anthropic, stopped prompting. He writes loops now.


I've spent the last year building agent pipelines with Claude Code, Hermes, and LangGraph. The closer I look at where the real gains come from, the clearer it gets: the model was never the bottleneck. The loop was.

For years, we obsessed over prompts. System prompts, few-shot examples, chain-of-thought scaffolding — all the tricks to make an LLM do what we meant. In 2024, teams treated prompt engineering like a competitive advantage. In 2025, they pivoted to context engineering: what the model sees, not how we phrase the ask. Now that's also playing out. The frontier has moved again.

This month, a new term crystallized across AI engineering blogs: loop engineering. The insight is simple: the bottleneck in agent systems is no longer the model or the prompt. It's the loop. The autonomous workflow that repeats until a goal is met. The tools, the verification, the memory, the error handling. The scaffolding around the model. The wrapper around it.

Open-source just dropped the proof.

## Ornith-1.0: Models that learn their own loops

DeepReinforce released Ornith-1.0 last week. A family of open-source coding models with a radical twist. They don't use a fixed harness. The model jointly learns to solve tasks AND to design the scaffolding that guides those solutions.

Here's how it works in training. Given a task and a previous scaffold, the model proposes a refined scaffold. Then it uses that scaffold to generate a solution. The reward from that solution flows back to BOTH stages: the scaffold design AND the code. Over thousands of iterations, the scaffolds mutate and select toward higher-reward workflows. Per-task strategies emerge automatically.

The results speak for themselves. Ornith-1.0-397B hits 77.5 on Terminal-Bench 2.1 and 82.4 on SWE-Bench Verified. That beats Claude Opus 4.7 (70.3 and 80.8) on both benchmarks. It's MIT-licensed, no regional restrictions.

The smaller models are equally telling. Ornith-1.0-35B scores 64.4 on Terminal-Bench 2.1, beating Qwen 3.5-397B's 53.5 despite having one-tenth the parameters. The 9B edge-deployable model hits 69.4 on SWE-Bench Verified, matching or exceeding models 3x its size. Parameters still matter — the 397B still outperforms the 35B by 13 points on Terminal-Bench. But the training method closes far more of the gap than raw scale alone would predict.

## The four layers that keep moving

To understand why Ornith matters, you have to map the stack that's been shifting under us for three years.

Prompt engineering asks: how do I word this message? Chain-of-thought, role assignment, JSON schema instructions: techniques for single-turn prompts. That worked for autocomplete, even basic chatbots. It breaks when tasks take 50 tool calls.

Context engineering asked: what does the model see on this call? CLAUDE.md files, RAG chunks, tool lists, history pruning rules. The shift from phrasing to feeding, from how we ask to what information reaches the model at the right moment. This unlocked real multi-turn agents in 2025 — the kind that could hold a conversation across dozens of turns without forgetting what they were doing or hallucinating context that was never there.

Harness engineering arrived in early 2026. What code runs the loop, tools, and verification reliably? LangGraph, custom orchestrators, Claude Code's agent runtime. The infra that keeps a long-running agent from getting stuck in silent failure loops or burning tokens forever.

Now we're at loop engineering. What autonomous workflow repeats until a goal is met? The trigger, the goal, the actions, the verification, the memory. The loop itself, not the code that implements it. Boris Cherny's quote captures the mindset: "I don't prompt Claude anymore. I have loops running that prompt Claude and figure out what to do. My job is to write loops."

Each layer nests the previous: harness implements loops, loops assemble context, context contains prompts. Confusing them is expensive. A team that rewrites prompts when the harness has no verification step will never fix silent failure loops. A team that builds a sophisticated harness with vague goals will burn tokens forever.


## Scaffolding is the bottleneck

Most AI coding agents today rely on a scaffold written by humans. Memory layout, tool selection, error recovery, task decomposition: all engineered by dev teams. You've seen this if you've set up Cursor Composer, Claude Code, or any sophisticated agent system. The configuration files, the tool definitions, the retry logic. The code around the model. The wrapper that makes it useful.

Ornith treats the scaffold as a learnable object. During reinforcement learning, the scaffold co-evolves with the policy. The model discovers better search trajectories than any human would design. Higher-reward scaffolds get selected automatically. Per-task-category strategies emerge without hand-engineering.

The 35B model beating the 397B isn't a fluke. It's evidence that the training method matters as much as parameter count. When you fix a tool problem in a human-designed scaffold, you're patching one failure mode for one scenario. When the model learns scaffolds, it's finding patterns that generalize across tasks — at least within the distribution it was trained on. How far those patterns transfer beyond the training distribution is still an open question.

What does this look like in practice? A human-designed loop might hardcode specific error recovery paths for common failure modes. If the test fails, rollback and add debug logging. If the import fails, try the test dependency. The model optimizes for reward, which is not quite the same as discovering abstract principles. What it finds are strategies that score well on the training distribution. Whether those strategies are genuinely transferable or just well-tuned to specific benchmark patterns is something only time and broader evaluation will tell.

## What changes when loops are learned

The engineering bar lowers. Building a strong coding agent requires deep expertise in prompt design, context engineering, harness code, and loop patterns. Few teams have all four. If models can learn their own loops, the bottleneck shifts from rare expertise to training data quality and compute budget.

Iteration accelerates. Human-designed scaffolds require manual tuning, extensive testing, slow iteration cycles. A learned scaffold refines automatically through RL. The model proposes variations, evaluates them, propagates rewards. Weeks of engineering become hours of training.

Capability generalizes. A hand-tuned loop for Python bug fixes might transfer poorly to TypeScript refactoring. A learned scaffold that discovers error-recovery strategies on Python tasks can apply those patterns to any language. The model extracts transferable principles from specific training experiences.

But there's a catch. The infra behind self-scaffolding RL is still complex. DeepReinforce had to build sophisticated defenses against reward hacking. They fix the outer trust boundary so the model can't cheat by reading test files or copying oracle solutions. A deterministic monitor flags banned actions. A frozen LLM judge catches intent-level gaming within the allowed tool surface. Once you have that infrastructure, though, the scaffolds write themselves.

## The open-source closing gap

The benchmark gap between closed and open models has been shrinking all year. DeepSeek V4-Pro, Qwen 3.7, MiniMax M3: all pushing 80%+ on SWE-Bench Verified. Ornith-1.0-397B crossing the 82.4 threshold puts open-weight models within striking distance of Claude Opus 4.8 (87.6) and GLM-5.2 (81.0 on Terminal-Bench 2.1).

But the real story is the approach. Open-source teams can't match closed frontier labs on raw compute or proprietary data. They win on architectural innovation. Self-scaffolding RL turns a weakness into a strength: less engineering bandwidth means letting the model discover its own loops.

The 35B model beating Qwen 3.5-397B is the clearest signal. Same underlying technology, both built on Qwen 3.5, dramatically different performance. The difference is how the agent loop is learned. Parameter count tells you less than training method.

This changes the competitive field. When open-source models approach closed-source performance on agentic benchmarks, the moat shifts from proprietary models to proprietary training pipelines. The barrier to entry isn't just compute. It's the reward infrastructure, the verification stack, the anti-gaming defenses. That's where the real engineering lives now.

## What this means for you

If you're building AI agents today, stop obsessing over prompts as your primary lever. Prompt design still matters for single-turn tasks and non-agentic use cases. But for multi-step agent systems, the biggest gains now come from loop design. Start there.

Map out the six building blocks of loop engineering: automations (trigger patterns), worktrees (isolated state), skills (externalized intent), plugins/MCP (execution permissions), maker-checker sub-agents (generation and verification), and durable state (memory persisted to disk instead of context). You'll find most of these already exist in tools like Claude Code, Cursor, and LangGraph. You're just not thinking about them as a unified loop design.

When you evaluate a new AI coding tool, ask not "how good is the model?" but "how does the loop work?" What happens when a tool call fails? How does the system recover from errors? What verification steps exist? How does memory persist across iterations? The answer tells you more about production reliability than any benchmark score.

The Ornith release is a signal. Self-scaffolding RL is early. The reward-hacking defenses are complex, the training compute is expensive, and the patterns that emerge are still being studied. But the direction is clear. The next leap in AI capability will come from models that learn their own workflows — the agent loop, the scaffold, the orchestration that today's engineers build by hand.

Prompt engineering had a good run. The agent loop is the new frontier.
