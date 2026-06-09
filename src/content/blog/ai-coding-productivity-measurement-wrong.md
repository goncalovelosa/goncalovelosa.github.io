---
title: 'blog: 87% of Devs "Feel Faster." The Data Is a Mess.'
description: "The 55% faster statistic is everywhere. But the studies behind AI coding productivity tell a far messier story."
pubDate: 2026-06-05
category: "AI"
tags: ["Artificial Intelligence", "Software Engineering", "Future of Work", "Technology", "Career"]
heroImage: "./ai-coding-productivity-measurement-wrong/images/VISUAL_1_cover_1.png"
---

![A small amber pebble drops into still teal water, sending enormous concentric ripples outward](./ai-coding-productivity-measurement-wrong/images/VISUAL_1_cover_1.png)
*A narrow study casting a wide wake.*

I have been quoting AI productivity studies with the confidence of a man who definitely read the whole paper. I hadn't.

A few weeks ago, I caught myself dropping the "55% faster with Copilot" stat in a team meeting. Someone nodded. Someone else slid it into a slide deck. By end of day, that number had metastasized into three strategy documents. Nobody asked where it came from. Including me.

This article is my correction. Not because AI coding tools are bad (I use them daily) but because the gap between what the data shows and what we keep repeating is embarrassing. And I contributed to the problem.

If you are building a team, choosing tools, or trying to understand whether AI is making you faster, you deserve better numbers.

## the study everyone cites (and almost nobody has read)

The 55% figure comes from a 2023 study by Peng and colleagues, published through GitHub and Microsoft. GitHub, which sells Copilot, funded the research. The number is real. It is also extraordinarily narrow.

The researchers asked 95 developers to build a single JavaScript HTTP server. One task. Ninety minutes. No distractions, no code reviews, no teammate tapping them on the shoulder. A controlled environment.

That is not how any of us work. We juggle Slack threads and undocumented APIs. Pipelines break for reasons no one can reproduce.

I am not saying the study is invalid. But "developers completed a toy task faster with AI in a vacuum" and "your team will ship features 55% faster" are different claims connected by a lot of wishful thinking.

We took a controlled observation and stretched it into an industry slogan. The study measured time to completion on a greenfield task. It did not measure debugging, code review cycles, or anything that consumes most of a working day.

## the self-report trap

You have seen the survey. Eighty-seven percent of developers say AI tools make them more productive. It appears in keynotes and vendor marketing with metronomic regularity. It feels true because it confirms what we want to believe.

The source is a 2024 study by Liang and colleagues at ICSE. The problem is not the data. The problem is what we do with it.

Self-report measures of productivity are confessionals. They capture how people feel, influenced by novelty and perceived effort, factors that have nothing to do with output. AI tools amplify the feeling of speed.

This would be a footnote if the self-reports aligned with objective data. They do not.

![A hamster runs furiously inside a wheel that spins freely, detached from any cage or stand, going nowhere](./ai-coding-productivity-measurement-wrong/images/VISUAL_2_illustration_1.png)
*Running fast. Going nowhere.*

A 2025 randomized controlled trial by Becker and colleagues at METR gave 16 experienced developers 246 real engineering issues to solve. Each task was randomly assigned so developers completed some with AI and some without. The AI-assisted tasks took 19% longer. Objectively measured. Timed. Verified. That original finding was statistically significant, with a confidence interval between 2% and 39% slower. But sixteen developers at a single AI-safety organization is a sample that demands humility, not headlines.

Then the researchers asked those same developers how fast they thought they were. The AI group reported feeling 20% faster.

They were slower, and they believed they were faster. The tools that introduced delays also made those delays invisible to the people experiencing them.

Here is where the story gets more complicated. In February 2026, METR published a follow-up with a new round of the same experiment. This time, using more recent AI tools, the original developers showed an estimated 18% speedup. New developers showed roughly 4% faster. The headline flipped.

Except neither result is statistically significant. METR's confidence interval for the original developers ranged from a 38% speedup to a 9% slowdown, crossing zero. The new developers' interval, from 15% faster to 9% slower, tells the same story. The data is consistent with anything from a substantial speedup to a mild slowdown. The point estimates suggest improvement, but the sample is too small to say by how much.

Sort of. METR also found that many developers refused to participate unless they could use AI. Others submitted only tasks where AI did not matter much. The study was bleeding participants who knew they needed these tools, which means the speedup numbers are almost certainly understated.

The honest read: AI tooling probably has gotten better, and the productivity picture is genuinely mixed. Early 2025: slowdown for experienced devs. Early 2026: probable speedup, but the measurement is too noisy to pin down. Anyone giving you a single percentage, in either direction, is selling you something. The studies disagree with each other. That is the data.

## experienced developers take the hit

The METR studies trace an arc: 19% slower in early 2025, then 18% faster a year later. But METR measures individuals solving isolated tasks. The structural picture at scale looks different.

Xu and colleagues, analyzing open-source repositories before and after Copilot adoption in 2025, found that experienced developers showed a 19% drop in original code output. Their methodology was observational. But it added a second finding that METR did not test: a 6.5% increase in review burden for those same developers. More time reading and correcting AI-generated code. The speed you gain at the keyboard gets eaten at the review stage.

Whether review-burden effects improved post-2025 remains unknown. Tools got faster at generating code. That does not mean the code got easier to review.

Opsera's 2026 benchmark, covering 250,000 developers across 60 enterprises, fills in part of the picture. Opsera is a DevOps vendor, so treat the numbers accordingly. The data is observational. AI-generated pull requests may differ from human ones in ways the study did not control for. Their data shows AI reduces time-to-PR by up to 58% in the best-performing subgroups, though the enterprise-wide average is smaller. The same study found that AI-generated pull requests wait 4.6 times longer for review. You write faster but wait longer for someone to check your work.

Junior developers often show genuine speed improvements in these studies. IBM's 2025 CHI work by Weisz and colleagues (IBM sells its own coding assistant, Watsonx) confirmed that net productivity increases exist but distribute unevenly. Some people benefit. Others pay a tax. When you average across skill levels, junior gains mask senior drag. Your aggregate dashboard looks green while your most experienced contributors absorb the review debt.

![A row of pristine teal columns, but one amber column in the center is cracked and crumbling, bearing the heaviest weight](./ai-coding-productivity-measurement-wrong/images/VISUAL_3_diagram_1.png)
*Junior gains mask senior drag — the averaging problem.*

On tasks where I already know the approach, typing was never the bottleneck. Thinking through edge cases was. AI accelerates the typing part of a job where typing was already the fast part.

## quality debt accumulates quietly

Speed metrics are seductive because they are easy to collect. Quality metrics require patience.

Liu and colleagues in 2026 found that more than 15% of AI-authored commits introduce quality issues. About a quarter of those persist in the codebase over time. Without a human-authored baseline for comparison, we cannot say whether 15% is worse than human-only commits or simply the default defect rate for rushed code. Opsera's enterprise data tells a compatible story: AI-generated code introduces 15 to 18 percent more security vulnerabilities than human-written code at scale.

Earlier work by Pearce and colleagues at IEEE S&P in 2022 first flagged this pattern: Copilot routinely generated insecure code, and rushed developers accepted more of those suggestions. Opsera's 2026 data suggests the gap has narrowed but not closed.

The people who need the most help are the least equipped to evaluate what they are getting. Speed and security pull in opposite directions.

Your velocity chart does not capture this. Your burndown looks fantastic. The defect appears in a different quarter, on a different dashboard.

He and colleagues analyzed 807 repositories adopting Cursor and found a pattern that should make every engineering manager pause: transient speed gains with persistent complexity growth. This too is observational, like the Xu and Opsera studies.

Teams shipped faster at first. Then the complexity caught up. The generated code was harder to modify. Dependencies were tangled. New contributors took longer to onboard because the codebase was a patchwork of human decisions and machine suggestions with no coherent mental model.

Whether the newest generation of coding agents changes this pattern is too early to tell. The He study covers Cursor adoption through 2025. The latest agents have not been studied at equivalent depth. But the pattern, speed followed by complexity, is worth watching for.

The speed was real. So was the complexity. But the speed was temporary, and the complexity was not.

![A sleek amber arrow flies forward, but a heavy iron chain drags a massive rusted ball behind it](./ai-coding-productivity-measurement-wrong/images/VISUAL_4_illustration_1.png)
*Speed was temporary. Complexity was not.*

This is the streetlight effect applied to software. We measure what is easy to see, not what matters. We optimized for stories closed because those were the numbers AI could visibly improve. The costs showed up in maintainability, onboarding time, and the cognitive load of reading code no single person on the team wrote.

## what should we measure instead

The SPACE framework, published by Forsgren and colleagues in 2021, argues that individual coding speed is one narrow dimension in a system that includes satisfaction, communication, efficiency, and quality. Individual throughput is not team delivery.

If your AI tool helps a junior close tickets 30% faster but adds 6.5% review burden to every senior engineer, your team-level throughput may have gone down. The junior's dashboard looks like a success story. The senior's untracked overtime tells a different one.

We need metrics that capture the full cycle: cycle time from first commit to merge. Review-to-commit ratio. Defect escape rate per sprint. Time from merge to first production incident traced back to that merge. These metrics capture team health overall. Isolating AI's contribution specifically would require controlled comparisons within your own team, which most organizations are not set up to run. But without the baseline, you cannot even ask the question. Most organizations measure the first commit timestamp and stop there. That was always a problem. AI tools made it urgent.

The tools themselves do not care whether the code they generate is maintainable. That burden falls on the humans in the loop, and the humans are the same people being told to move faster.

## the uncomfortable middle ground

I still use AI coding tools. Daily. I am not arguing you should stop. The IBM study and the METR follow-up both suggest real benefits, and those benefits may be growing as tools improve. Stack Overflow's 2025 survey of 65,000 developers echoes this: most report real gains. That too is self-report data, subject to the same biases I just spent three sections dissecting. But when the objective studies and the subjective surveys both point in the same direction, the signal gets harder to dismiss. What I am arguing is that we have been sloppy about the numbers behind those benefits. I have been sloppy. We grabbed the most impressive-sounding figures, stripped them of context, and used them to justify decisions that deserved more scrutiny.

The honest answer about AI coding productivity is boring and true: it depends on experience level, task type, codebase maturity, and how you define productivity. The studies contradict each other. Gains are real for some and negative for others. Quality risks persist. Less shareable than a tweet about 55% faster. Closer to reality.

The next time someone quotes a productivity stat at you, ask about the study design. Ask about the sample size. Ask who chose not to participate. We owe our teams better than cherry-picked numbers. That starts with admitting we were citing the wrong data, which, for the record, I was.
