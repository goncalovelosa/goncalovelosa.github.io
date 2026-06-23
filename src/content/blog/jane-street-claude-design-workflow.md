---
title: "A Jane Street Designer Stopped Using Figma"
description: "Edwin Morris at Jane Street replaced Figma with Claude Code for internal tool prototyping. The three paths ahead for designers in an AI-first world."
pubDate: 2026-06-05
category: "AI & Design"
tags: ["Figma", "Claude Code", "Design", "AI Tools", "Jane Street", "Prototyping"]
heroImage: "./jane-street-claude-design-workflow/images/VISUAL_1_cover_1.png"
---

# A Jane Street Designer Stopped Using Figma

A Jane Street designer stopped using Figma and started shipping working prototypes with Claude. The real story isn't about a tool dying.

![Designer at a trading desk with multiple screens showing code and UI prototypes, warm amber lighting, professional workspace](./jane-street-claude-design-workflow/images/VISUAL_1_cover_1.png)

I've been writing about AI replacing coding workflows for months. Coding agents, pair programmers, autonomous devs, the whole parade. I was looking in the wrong direction. The disruption that's already happening isn't on the engineering side at all. It's on the design side. And it's moving faster than anyone predicted.

*The tool is becoming the output.*

## what happened at jane street

In February, Edwin Morris published a blog post on Jane Street's engineering blog with a title that stopped me cold: "I design with Claude more than Figma now."

Morris is a designer on the options desk at Jane Street, the quantitative trading firm valued north of $40 billion. He joined in the summer of 2025, coming into a tech stack built on OCaml and Bonsai, Jane Street's open-source UI framework. He was skeptical of AI tools. Copilot and Cursor had disappointed him. Gemini wireframes ended up in the trash.

To be clear about what Morris does and doesn't do: he's not conducting user research, running accessibility audits, or building design system governance. He works on internal tools used by traders he sits next to. The feedback loop is immediate and the context is shared. That matters.

Then something shifted.

Instead of writing spec docs, building Figma mockups, and waiting for engineers to implement his designs, Morris started building functional prototypes himself. His workflow became: describe the problem, prompt Claude Code, iterate until it works, push to a dev environment, get real user feedback. He recently built a feature that added LLM-powered prompting directly into a JSQL input, Jane Street's internal SQL dialect. The prototype was real, functional code. He refined the submit button, added keyboard shortcuts, tweaked copy. Changes that would have taken weeks of design-engineering handoff at his previous company, or more likely would never have happened at all.

"In the past two months," he wrote, "the situations where I've reached for Figma have fallen off a cliff."

Some of his prototypes are 2000+ line diffs. From a designer.

## the signal beneath the anecdote

![Two worlds building toward each other — design world with Figma tools on left, code world with Claude terminal on right, converging at center](./jane-street-claude-design-workflow/images/VISUAL_2_illustration_1.png)

Jane Street is an edge case. Quant firm, unique tech stack, small tight-knit teams. One designer's workflow qualifies as anecdotal evidence at best. I know that.

But look at what's happening around that anecdote.

Vercel's v0, the AI tool that generates React components from text descriptions, has 3.5 to 4 million users. Lovable, a Swedish startup that raised a $330 million Series B at a $6.6 billion valuation (confirmed by TechCrunch and CNBC in December 2025), hit $200 million annual recurring revenue. Bolt.new signed up 5 million users within months of launching.

Signups and valuations are noisy signals. Most of these tools generate prototypes and weekend projects, skip enterprise software. But the direction is clear.

The people using these tools aren't designers. They're developers, product managers, founders, people who had an idea and skipped the design phase entirely because they could just build it.

Here's the number that sticks: 60% of files created in Figma Make, Figma's own AI prototyping tool, are made by non-designers. Figma itself is reporting this. The tool built for designers is being used by everyone else.

## figma is fine (really)

Before anyone writes the "Figma is dead" take, let's look at the numbers.

Figma's FY2025 revenue was $1.056 billion. That's 41% year-over-year growth. They IPO'd in July 2025 at a $45 billion valuation and their stock surged 158% on day one. They have 13 million monthly active users. Net dollar retention is 136%, meaning existing customers are spending more, not less. Their 2026 outlook projects $1.37 billion in revenue.

Figma is not dying. They're doing the smart thing: they embraced AI early. Figma Make's weekly active users grew 70% quarter over quarter. They launched Dev Mode, integrated an MCP server for AI coding workflows, expanded from 4 to 8 products. The incumbent is adapting.

So what's changing? The roles are. The tools will follow.

## why designers aren't there yet

![A small amber door ajar in a large amber wall, three silhouette hands reaching through from the other side, warm amber glow](./jane-street-claude-design-workflow/images/VISUAL_3_illustration_2.png)

Designer AI adoption looks high on paper. The UX Tools 2025 survey of 2,220 professionals found 77.6% of individual contributors have adopted AI. Among design leaders, it's 85.2%.

But look at what they're doing with it. 75.2% of designer AI usage focuses on writing, documentation, and content. Skip visual design. Skip prototyping. Skip building.

Only 54% of designers say AI improves their work quality, compared to 68% of developers who say the same. The satisfaction gap is real and it's wide. Developers are 13 percentage points more satisfied with AI tools than designers are.

Nielsen Norman Group put it bluntly: AI design tools have yet to reach production quality. A systematic literature review published by Wiley in 2025 warned of "potential overreliance on automation and a technology-first approach in developing AI design tools without involving designers."

The designers who figure out what Morris figured out, that the real power isn't generating mockups but building working software, are the ones who will thrive. Everyone else is competing with non-designers who can now produce passable UI without them.

## the review problem

Morris is honest about the downside. When a designer ships a fully functional prototype, the review process breaks down.

"The reviewer is given a fully baked feature," he wrote. "Does that mean they have zero input on the functionality?"

His team's solution is cultural. He labels prototypes as "living proposal docs." The code is disposable. Reviewers give feedback on design and user experience alone. Eventually, engineers take over the idea and implement it properly in a separate feature branch.

This is fragile. It depends on trust, small teams, and shared context. Jane Street can pull this off. Most companies can't yet. And there's a hidden cost: prototypes that look production-ready accumulate technical debt fast. A 2000-line diff from a designer is disposable at Jane Street. At most companies, it becomes someone's maintenance burden.

And there's a deeper tension the METR study highlighted: in a randomized controlled trial, experienced developers using AI tools took 19% longer to complete tasks. The confidence interval crossed zero, so that result is not statistically significant, but it points in an uncomfortable direction. If AI slows down experienced coders, does adding designers to the coding pool help or hurt?

## two paths (and a third)

![Three diverging amber paths from a single point — one becomes ascending steps, one goes through a garden, one narrows between walls](./jane-street-claude-design-workflow/images/VISUAL_4_illustration_3.png)

Design roles are going to split. Maybe more than two ways.

Path one: designers who learn to build. Not mockups. Working software. They'll use tools like Claude Code, v0, and whatever comes next to ship functional prototypes, run experiments, and make design decisions backed by real usage data instead of gut feeling. Some companies already call this role "product engineer."

Path two: designers who stay deep in their craft. User research, accessibility, design systems, information architecture. The work AI can't do because it requires empathy, cultural context, and strategic judgment. This path doesn't go away. If anything, it becomes more valuable as the bar for "basic" design drops.

Path three: designers who get squeezed. They stay in visual tools but don't deepen their strategic skills. They'll compete with the 60% of Figma Make users who aren't designers, with product managers pasting screenshots into Claude, with founders vibe-coding entire apps over a weekend. The barrier to "good enough" UI just dropped to zero.

There is an upside. Teams at small companies who never had a design budget can now produce usable interfaces. Founders in markets where hiring a designer was impossible can ship something real. The democratization is real and it matters. But it also means the floor for "professional" design work just moved up, because the baseline everyone compares against is no longer a wireframe. It's a working prototype.

Figma survives both paths. It's a $1 billion company with 41% growth and AI features shipping quarterly. The question isn't whether the tool lives or dies. It's whether the next Edwin Morris gets hired as a designer. Or a product engineer.