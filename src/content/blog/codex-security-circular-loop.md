---
title: "AI Wrote the Bugs. Now AI Fixes Them."
description: "AI-generated code has 2.74x more security flaws than human code. OpenAI's new Codex Security CLI finds and patches them. The circular quality loop is now a product."
pubDate: 2026-08-02
category: "Security"
tags: ["ai", "security", "codex", "openai", "vulnerabilities", "appsec"]
heroImage: "./codex-security-circular-loop/images/cover.png"
---

OpenAI quietly pushed a repository to GitHub last week. No blog post, no announcement, no press cycle. Hacker News found it before OpenAI got around to telling anyone.

The repo was `@openai/codex-security`, a CLI tool that scans codebases for vulnerabilities, validates whether they are real, and proposes fixes. Apache 2.0 license. Eight thousand stars in 72 hours.

The interesting part is not the tool itself. It is the circle it completes.

## The problem has numbers now

For most of 2024 and early 2025, the security risk of AI-generated code was a debate. Researchers had suspicions. Auditors had anecdotes. Vendors had marketing. The data was thin enough that reasonable people could disagree about how serious the problem was.

That argument is over.

A 2026 meta-analysis found that AI-generated code contains 2.74 times as many exploitable security flaws as equivalent human-written code. Veracode tested over 100 language models across 80 coding tasks and found that 45% of AI-generated samples introduce OWASP Top 10 vulnerabilities. Not edge cases. Not exotic zero-days. SQL injection, cross-site scripting, broken authentication. The basics.

The failure rate has not improved. Veracode's March 2026 follow-up tested the same models and found the security pass rate unchanged at roughly 55%, flat across every testing cycle, during a period when coding benchmarks like HumanEval showed steady improvement. The models got better at writing code that works. They did not get better at writing code that is safe.

Apiiro deployed its analysis engine across tens of thousands of repositories at Fortune 50 companies. AI-assisted developers committed code at three to four times the rate of their peers, and monthly security findings rose from about 1,000 to over 10,000 in six months. Privilege escalation paths increased by 322%. Architectural design flaws by 153%. The dangerous architectural ones multiplied, the kind that require deep contextual reasoning to detect and create exploitable conditions in production systems where the blast radius is largest.

![Two industrial analog gauges on a dark metal panel. Left gauge green-lit, needle at maximum. Right gauge red-lit, needle pushed beyond scale, bezel showing heat damage.](./codex-security-circular-loop/images/chart.png)

Georgia Tech's Vibe Security Radar project has confirmed 74 CVEs directly attributable to AI coding tools in public repositories. Claude Code accounts for 27 of those. The researchers estimate the real number is five to ten times higher. That is 400 to 700 known-exploitable flaws introduced by AI tools in observable open-source code alone, with private enterprise repositories uncounted.

Twenty percent of AI-generated code references packages that do not exist. Attackers have started registering those hallucinated names as real packages loaded with malware before the developer's next `npm install`.

## Enter the fixer

This is the situation OpenAI walked into when they shipped Codex Security.

The tool works in three phases. First, identification: it reads the code, traces data flows, flags candidate vulnerabilities, including multi-file reasoning chains that static analysis tools cannot model. Second, validation: it generates proof-of-concept logic to confirm whether the vulnerability is real and reachable, cutting false positives before a developer ever sees them. Third, remediation: it writes the patch.

During its beta, Codex Security scanned 1.2 million commits across open-source repositories. It found 792 critical-severity vulnerabilities and 10,561 high-severity ones. Fourteen received formal CVE assignments from MITRE, spanning GnuTLS, GOGS, OpenSSH, PHP, and Chromium — not toy projects but production infrastructure that millions of systems depend on every day.

False positives dropped 50% compared to the initial rollout. Noise reduction hit 84%. By comparison, traditional SAST tools like Semgrep and Snyk rely on rule-based pattern matching that generates high false-positive rates without careful tuning, and they cannot reason across files or understand business logic.

## The circular quality loop

Step back and look at the shape of this.

AI coding tools write code. The code contains vulnerabilities at a rate 2.74 times higher than human-written code. The vulnerabilities accumulate faster than teams can remediate them, because the same AI acceleration that produces code also produces flaws. Now an AI security agent scans that code, finds the vulnerabilities, and patches them.

The same class of technology creates the problem and sells the solution.

OpenAI's roadmap makes the circle explicit. Codex Security is the scanner. The Daybreak platform, launched May 2026 with eight security vendor partners including Cloudflare, CrowdStrike, and Palo Alto Networks, is the enterprise commercialization layer. The CLI is Apache 2.0. The pipeline is not.

This is a textbook open-core play. Give away the entry point, charge for the ecosystem. The difference is that the vendor selling the security scanner also sells the coding tools that generated the code being scanned. If your revenue depends on AI writing code, and increasingly on AI fixing that code, the incentive structure is clear.

Keep the cycle going.

## The tool had its own vulnerability

Here is where it gets uncomfortable. Codex Security itself had a critical vulnerability: a GitHub token exfiltration flaw via branch command injection that was reported in December 2025 and patched in February 2026, fifty-one days between disclosure and fix for a critical vulnerability in a security product when the SANS Institute recommends fifteen days for critical severity.

The irony writes itself, but the governance question is serious. If an AI security tool has its own critical vulnerabilities and takes 51 days to patch them, what confidence should an enterprise have in deploying it as a gatekeeper for production code? OpenAI has not published an SLA for vulnerability remediation in Codex Security itself.

## What I see in practice

I work with AI coding agents daily. Claude Code, OpenAI Codex, and an agent platform I help maintain that runs autonomous engineering tasks. These tools are genuinely useful. They write boilerplate fast, handle refactoring across dozens of files, and generate tests that would take a human hours.

They also hallucinate function calls that do not exist. They reference deprecated libraries because their training data is months old, and they skip authorization checks because the happy path does not require them. The code looks correct at a glance. A tired reviewer at 5pm merges it.

The 91.5% hallucination-flaw rate that Kingbird Solutions found across 200-plus vibe-coded apps matches what I see in smaller doses. Not every project has a critical vulnerability. But almost every project has something the AI assumed was safe that is not. A function call to a permission check that does not exist. A crypto library that was deprecated two versions ago. An authentication middleware that the model confidently applied but never actually wired up.

Codex Security would catch some of these. It would not catch all of them, and it explicitly cannot detect runtime vulnerabilities like broken access control or business logic flaws. DAST tools remain mandatory for those categories. But the gap between what AI writes and what gets reviewed before shipping is where the problems live, and Codex Security is the first tool that addresses that gap with the same kind of contextual reasoning that created it.

## The real question

![A circular conveyor belt on a dark factory floor. Robotic arms write code on cards, stamp them, and collect payment in an endless loop.](./codex-security-circular-loop/images/diagram.png)

The question is not whether Codex Security works. The beta data suggests it does, and fourteen CVEs in critical infrastructure software is a concrete result backed by MITRE records, not a vendor marketing claim polished for an enterprise sales deck.

The question is whether the industry should be comfortable with a model where the same vendor accelerates code production, introduces vulnerabilities at scale, and then charges enterprises to find and fix those vulnerabilities. Whether the circular quality loop is a feature or a bug depends on where you sit.

If you are a security team drowning in findings and under-resourced for manual review, Codex Security is a lifeline. If you are OpenAI, it is a new revenue stream that monetizes a problem your other products created. If you are a developer shipping vibe-coded apps to production without review, you need this tool or something like it yesterday.

The honest answer is that both things are true. The tool works and the business model is clever and the conflict of interest is real. The industry will adopt it anyway, because the alternative is leaving 45% of AI-generated code unscanned.

The ouroboros keeps eating. Someone has to make sure it does not eat itself.
