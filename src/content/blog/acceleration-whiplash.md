---
title: "AI Writes Most of Your Code Now. That's the Problem."
description: "AI coding tools shipped 66% more epics per developer. They also tripled production incidents, spiked bugs by 54%, and buried senior engineers in review queues. The Faros AI Engineering Report 2026 reveals what the dashboards miss."
pubDate: 2026-06-11
category: "AI"
tags: ["ai", "software-engineering", "productivity", "code-quality", "faros"]
heroImage: "/blog/images/acceleration-whiplash-hero.png"
---

# AI Writes Most of Your Code Now. That's the Problem.

Here's a number you won't find on any engineering dashboard: **861%**.

That's how much code churn, the ratio of lines deleted to lines added, increased when teams shifted from low to high AI tool adoption. Code was written, merged, then ripped out at nearly ten times the previous rate. That statistic doesn't make it into many slide decks.

It's sitting right there in the [AI Engineering Report 2026](https://www.faros.ai/research/ai-acceleration-whiplash) from Faros AI, buried beneath the numbers everyone does quote. Two years of telemetry data from 22,000 developers across more than 4,000 teams. Not a survey. Not vibes. Measured production telemetry showing what AI-assisted development produces and what it breaks.

The report's authors gave it a name: the Acceleration Whiplash. The gains are real. The damage is real. And almost no one is measuring both.

## What the dashboards show

Let's start with what's real. The gains are genuine.

Epics completed per developer: up **66%**. Task throughput: up **33.7%**. PR merge rate: up **16.2%**. In the organizations Faros tracked, 80% of teams now exceed 50% weekly active usage of AI coding tools. Code acceptance rates climbed from 20% to 60%. More features shipped. More initiatives completed. More code entering codebases than at any prior point.

The productivity story at the business level is real. Engineering leaders are right to want more of it.

But throughput measures what was shipped.

Not what survived.

## What the dashboards miss

The incidents-to-PR ratio under high AI adoption **more than tripled**, up 242.7%. Monthly incidents rose 57.9%. Outages, security events, system failures reaching real users in production systems: finance, healthcare, infrastructure. Not staging. Not tests. Production.

Bugs per developer? Up **54%**. The previous year's report showed 9%. The trajectory is worsening, not stabilizing.

And here's the part that should keep engineering directors awake: **31.3% more pull requests are merging with zero review**. Not because someone decided to skip oversight. Reviewers cannot keep pace with the volume of AI-generated code arriving for their attention. That's the mechanism. No conspiracy, just volume.

Two important caveats. First, the Faros data tracks organizations from their periods of lowest to highest AI adoption, so teams that adopted AI fastest may differ systematically from slower adopters. The report measures correlation at engineering-system scale, which is more useful than individual surveys but stops short of proving causation. Second, some of that 861% code churn may be healthy. Teams using AI to tackle large-scale refactoring that was previously too costly to staff would generate high deletion ratios too. The right interpretation varies by organization. Faros is explicit about this.

The report's own framing: throughput measures what was shipped, not what survived. The 861% is the asterisk on every output number in the dataset.

(Full disclosure: Faros AI sells engineering observability tooling. Their report appears methodologically rigorous, but the commercial context is worth noting.)

## The senior engineer tax

This is where the whiplash turns personal.

AI-generated code is often superficially convincing. Idiomatic, well-named, stylistically consistent with the surrounding codebase. It looks like code written by someone who knows what they're doing. The failures, when they exist, are structural and logical, hiding beneath the surface. Catching them means reading carefully, reasoning about intent, reconstructing the problem the code was meant to solve rather than scanning for obvious errors. You have to think like the person who should have written it and notice that nobody's home.

Slow, expensive cognitive work. The data shows who bears the cost. (And to be clear: code review has always been senior work. The shift isn't the activity, it's the volume. Review queues that used to contain human-paced output now carry machine-paced floods.)

Median time to first PR review: up **156.6%**. Average time spent in code review: up **199.6%**. Median time in review: up **441.5%**.

Gustav Söderström, Spotify's CEO, put it bluntly at a recent company all-hands: "When I speak to my most senior engineers, the best developers we have, they say that they have not written a single line of code since December. They only supervise AI systems."

Canva's CTO, Brendan Humphreys, described the same shift in a public engineering blog post: senior engineers now spend most of their time reviewing AI-generated code rather than writing it. Their role has changed. The people with the deepest system knowledge, the ones you'd least want doing validation work, are now your primary validators.

Matt Garman, CEO of AWS, called the downstream consequence by its name in an interview with The Pragmatic Engineer: "Cutting juniors is one of the dumbest things I've ever heard. How's that going to work when ten years in the future you have no one that has learned anything?"

If seniors are reviewing instead of mentoring, and juniors aren't writing the code they'd learn from, where does the next generation of senior engineers come from?

That question has no good answer right now.

## The full picture requires more than one dataset

McKinsey's 2023 research found that code quality was "marginally better" in AI-assisted code. Developers didn't sacrifice quality for speed. The Opsera 2026 Benchmark Report, analyzing 250,000+ developers, found 90% enterprise adoption with 48-58% faster time-to-PR and 85% satisfaction rates. A longitudinal study from the "Intuition to Evidence" research project at a major tech company tracked 300 engineers over a year and showed a 31.8% reduction in PR review cycle time when AI was properly integrated.

These numbers are also real. They're not wrong.

Here's where the methodological difference matters. McKinsey studied controlled pair-programming sessions. Opsera aggregates CI/CD pipeline data across organizations. Both capture individual and team-level velocity. Faros measures what happens across the entire engineering system over time, including everything downstream of the PR: production incidents, bug rates, code survival. Different lenses. The picture changes depending on which one you look through.

The DORA 2025 State of AI-Assisted Software Development report concluded that strong engineering foundations amplify AI's benefits and protect against its downsides. Faros found something different. High-performing organizations with mature DevOps practices, high DORA metrics scores, and disciplined delivery processes experienced the same downstream deterioration as everyone else. The DORA finding is based on survey data: developers reporting how they feel about their work. Faros's finding is based on telemetry: what the systems recorded. Right now, developers feel more productive because at the individual level, they are. What surveys can't capture is what happens downstream.

The distinction that matters isn't AI versus no-AI. It's governed adoption versus ungoverned adoption. Organizations tracking review queue depth, incident-to-merge ratios, and code survival rates can see where acceleration is real and where it's hollow. The specific practice that separates the two: requiring AI-generated code to pass the same review gates as human-written code, including architectural review for changes above a complexity threshold. Some teams are making this work already. The ones that treat AI output as a first draft that needs the same scrutiny as a junior developer's first PR tend to retain the gains without accumulating the debt.

## The only gap that matters

Every engineering organization has output data. Almost none have the downstream data: review queues backing up, incidents accumulating, bugs reaching customers that should never have passed review.

The gap between knowing and acting is the only gap that matters now.

The acceleration is real. So is the whiplash. The teams that see both are the ones that will still be shipping reliably two years from now. The ones that only see the velocity will be wondering why their best engineers left and their production systems keep breaking.

AI didn't break software engineering.

It flooded it.

The organizations that learn to absorb the flood will define what engineering looks like in the AI era. Everyone else will just have really fast dashboards.
