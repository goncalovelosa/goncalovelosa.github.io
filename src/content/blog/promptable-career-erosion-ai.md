---
title: "Your 10 Years of Expertise Is Now Promptable"
description: "A senior engineer's three pillars — domain knowledge, debugging intuition, architectural judgment — are dissolving into prompts. The economics of homogenization."
pubDate: 2026-06-05
category: "Career"
tags: ["AI Tools", "Software Engineering Career", "Senior Developers", "AI Productivity", "Career Erosion"]
heroImage: "./promptable-career-erosion-ai/images/VISUAL_1_cover_1.png"
---

# Your 10 Years of Expertise Is Now Promptable

![A tall amber sandstone column crumbling layer by layer from the top, dust drifting from the ruined upper section, hairline cracks spreading in the solid base, dramatic warm lighting against dark background](./promptable-career-erosion-ai/images/VISUAL_1_cover_1.png)

A senior engineer watched AI dissolve his career pillars one by one. His story is not unique.

Last week, a software engineer with ten years of experience published a blog post with a title that stopped me mid-scroll: "LLMs are eroding my software engineering career and I don't know what to do."

Within 24 hours it had a thousand upvotes and a thousand comments on Hacker News. Not because the take was hot. Because it was honest.

I have been writing about AI coding productivity for months, dissecting studies, checking confidence intervals, flagging vendor conflicts. But this post landed somewhere the studies cannot reach. It described what erosion feels like from the inside.

## the first pillar: domain knowledge

![An ornate vintage amber key dissolving into particles that reform as a plain generic skeleton key, both floating against dark teal background, warm amber glow](./promptable-career-erosion-ai/images/VISUAL_2_illustration_1.png)

The author spent a decade in finance and payments. PCI compliance. Double-entry ledgers. Bank transfer idempotency. The kind of knowledge you accumulate by building systems that handle other people's money and break in expensive ways.

His company gave him ChatGPT and Claude Enterprise accounts on day one and told him to use them. He called large language models "stochastic parrots" and went back to work.

Then his manager told him he was taking too long on design documents. Use more AI. He did. And watched the models do the thing he thought only years of experience could produce: connect the dots on how to structure payment systems, weigh trade-offs between implementations, design idempotency to prevent double-charges.

> All the knowledge I have accumulated over the years was becoming useless. Even though the models still needed some steering, they could connect the dots on how to structure such systems, which was the hardest part that only develops in your brain after years of hands-on experience.

He called that his first shock. Producing a design document that looks like the output of years of experience is not the same as carrying the scars of a PCI audit failure, a chargeback fraud spike, or a settlement timing edge case that cost six figures. The model can connect the dots. It cannot feel why they matter.

I recognized the feeling. I have caught myself reaching for Claude before I finish thinking about a problem. Not because I cannot solve it. Because the model will get there faster and I have a deadline.

The data backs up the anxiety, with caveats. Xu and colleagues analyzed open-source repositories before and after Copilot adoption in 2025 and found experienced developers showed a 19% drop in original code output. Their methodology was observational, but the direction aligns with what the author describes: senior engineers are producing less of the code that used to define their value.

## the second pillar: debugging

![An amber compass with a blank dial, the needle spinning freely with a motion trail, no cardinal directions visible, dark background with warm amber glow](./promptable-career-erosion-ai/images/VISUAL_3_diagram_1.png)

The author's backup plan was debugging. Race conditions in distributed systems. Production incidents at 2 AM. Gut work. The messy, intuition-driven work that separates seniors from juniors.

Claude 4.5 solved about 60% of his bugs given a stack trace and a Sentry link. Not impressive enough to worry. Then came 4.6, 4.7, the DataDog MCP integration.

> Now I have CLIs that one-shot bugs across distributed systems for me. Bugs that I could not solve in the past. Bugs that would take 2 days of full-time debugging. 90% of the bugs are one-shotted now.

Ninety percent is his number, not mine. I cannot verify it. But I have watched Claude Code diagnose a subtle timing bug in a WebSocket reconnection loop in under a minute. A bug I had spent an afternoon on.

The METR studies track a compatible pattern, albeit from a different angle. Their 2025 randomized trial, where 16 developers each completed some tasks with AI and some without, found the AI-assisted tasks took 19% longer. But those same developers reported feeling 20% faster. The follow-up in February 2026 showed an estimated 18% speedup for the original developers, a 37-point swing from the initial negative finding and a trajectory worth noting even if the confidence interval ranged from a 38% speedup to a 9% slowdown, crossing zero. The data is consistent with anything from a genuine speedup to no effect at all. What is consistent is the feeling: developers believe they are faster, whether or not the clock agrees.

The author's debugging claim fits this pattern. The model probably does resolve many bugs faster than he could, though this is a self-report from an engineer in the grip of professional anxiety and therefore not the most reliable measuring instrument. Whether it resolves ninety percent is less important than what believing that number does to his sense of professional identity. The remaining ten percent — the bugs that resist one-shotting — is where deep expertise compounds rather than disappears. Those are the race conditions that only surface under load, the edge cases buried in undocumented APIs, the failures that demand grasping the deeper reasons behind the system's behavior, beyond the surface mechanics.

## the third pillar: architecture, or "taste"

![Amber building blocks of varied complex shapes collapsing mid-motion into a single flat pale block, warm colors against dark background, sense of uniformity overtaking diversity](./promptable-career-erosion-ai/images/VISUAL_4_illustration_2.png)

This is the pillar still standing, barely. The author still values clean architecture, domain-driven design, hexagonal patterns, SOLID principles. The things that separate software engineering from programming.

Except the industry is already redefining those values. Fast.

> Agents do a really bad job at keeping codebases organized. That should keep humans employed, except that this skill is now being reduced to the word "taste." Nobody needs A or B-grade codebases anymore because they are being made for LLMs, not for humans to read.

Separately, Opsera's 2026 benchmark of 250,000 developers (Opsera sells a DevOps platform) found AI-generated pull requests wait 4.6 times longer for review. The data is observational. IBM's 2025 CHI paper by Weisz and colleagues (IBM sells its own coding assistant, Watsonx) confirmed that productivity gains exist but distribute unevenly. Junior developers benefit. Senior engineers absorb the review debt.

The author's company used to hire "Software Engineer, Payments" or "Software Engineer, Risk." Now it hires "Software Engineer." Domain expertise is no longer a differentiator in the job listing.

## what the studies miss

The studies measure time-to-PR, task completion rates, defect counts — everything except what it feels like to realize the thing you spent a decade getting good at can now be produced by typing a sentence into a chat window.

The author does not claim AI will replace him. He is still employed, still reviews code and steers the model. He calls himself an "off-the-shelf engineer" now, a description that carries more weight than any productivity metric.

> I have no domain expertise that another Sr. engineer steering an LLM cannot match. All my finance and payment domain expertise, all the debugging intuition and distributed system knowledge earned through hours of sweat and tears, is now promptable.

The economics are not kind either. If every senior engineer becomes a generalist with an AI copilot, the supply of generalists explodes while demand is, by many indicators, contracting. The author notes that brilliant ex-colleagues laid off eight months ago are still looking for work. The company is hiring again, but domain familiarity no longer matters.

This has happened before. Spreadsheets did not eliminate accountants, but they compressed the middle of the profession and rewarded the people who could interpret the numbers instead of merely producing them. CAD changed architecture without ending it. The pattern is consistent. The tool automates production. Humans who adapt move to the judgment layer. Everyone else gets squeezed. The question is whether software engineering's judgment layer is large enough to absorb the displaced production workers, or whether the floor genuinely drops for everyone.

## what I keep coming back to

I use AI coding tools every day. I am not writing this from a position of purity. The METR follow-up data, imprecise as it is, suggests the tools are getting better. The author himself admits he liked shipping faster.

But his post articulated something I had been unable to name. The threat to software engineering careers is not replacement. It is homogenization. The skills that made you stand out — deep domain knowledge, debugging intuition, architectural judgment — are being compressed into the same flat layer of "prompt, review, iterate." The floor rises. The ceiling drops. Everyone becomes a generalist.

At least, that is how it feels from the top of the skill distribution. From further down, the view is different. AI tools are opening doors that were previously locked. Engineers who never had the chance to specialize in payments or distributed systems can now contribute to those domains with AI assistance. Returning-to-work parents are ramping faster. Engineers whose first language is not English are producing design docs that no longer get flagged for clarity. The tools that compress expertise from above also democratize access from below.

And homogenization is partly a management choice. The author's company chose to stop hiring for domain expertise. That is a leadership bet, independent of any technological inevitability. Some companies are going the other direction, deepening domain requirements precisely because AI-generated code produces subtle compliance gaps that only specialists catch.

But the author's anxiety is still directionally right. If most companies make the same bet — if domain familiarity stops being a differentiator in most job listings — then the economic pressure is real regardless of whether individual companies resist.

The honest answer about what to do is unsatisfying. The career paths that are emerging — AI quality governance, domain-plus-AI specialism, smaller teams with bigger scope — are still taking shape. But the outlines are visible: senior engineers who can audit AI output for compliance-critical gaps (a PCI auditor who also knows prompt engineering), engineers who pair domain depth with AI fluency rather than competing with it, plus staff-plus roles that are shifting toward deciding what gets built instead of building it yourself. The author does not see a path. Neither do I, clearly. His closing line was: "Maybe I should consider transforming my woodworking hobby into a profession."

I laughed.

Then I thought about it for longer than I should have.