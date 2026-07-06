---
title: "Can You Trust Your Team's Commits?"
description: "repo-slopscore scans 5,337 git repositories for AI-generated code. The tool is imperfect. The question it raises about code provenance is not.""
pubDate: 2026-07-06
category: "AI"
tags: ["ai", "coding"]
heroImage: "./repo-slopscore/images/visual1-cover.png"
mediumUrl: "https://medium.com/@gvelosa/can-you-trust-your-teams-commits-TBD"
canonicalUrl: "https://medium.com/@gvelosa/can-you-trust-your-teams-commits-TBD"
---

A tool called repo-slopscore has scanned 5,337 repositories. Zed. Godot. MongoDB. Zig. Perfetto. Kubernetes. LLVM. Rust. Odoo. Projects ranging from operating systems to package managers to encrypted messengers, all run through the same analysis: how much of this code shows visible signs of AI generation?

The answer varies. But the fact that someone built a tool to ask the question, and that thousands of repositories are now publicly indexed by it, tells you something about where software development is heading. Code provenance has become an engineering concern. Not a philosophical curiosity. A practical problem that affects hiring, performance reviews, security audits, and the basic trust model that open source runs on.


## What repo-slopscore does

Repo-slopscore is a Rust CLI tool written by a developer called ava, hosted on Codeberg. It analyzes the entire commit history of any public git repository, up to 5,000 commits, looking for visible signs of AI and LLM tool usage.

The methodology is straightforward. It reads committer names and email addresses against a database of known AI agent identities. It parses commit messages for patterns like Co-Authored-By trailers, generated-by stamps, and summary-by annotations that Claude Code, CodeRabbit, and Copilot leave behind. It checks for telltale patterns in the source tree: em-dashes in comments, stray rocket emoji that no human would type by hand, markers saying "rest of code unchanged," ghost import declarations. Then it assigns a score. And that score is worth understanding for what it is: a measure of detectable tool usage, not a measure of code quality. A high slop score means AI tools left visible fingerprints. It doesn't mean the code is bad.

The project maintains a public web interface at slopscan.ava.pet where anyone can browse scanned repositories. The scan list covers GitHub, Codeberg, GitLab, kernel.org, KDE Invent, VideoLAN's GitLab instance, and independent servers. Major infrastructure, language ecosystems, indie projects, personal utilities, all sitting inside the same interpretive frame. That frame is uncomfortable, because it asks a question most projects were never designed to answer: how much of this was written by a human who understood it?

Repo-slopscore is not the only tool doing this. Slop-scan, by modem-dev, takes a complementary approach. It analyzes source code patterns instead of commit metadata. It has 269 stars on GitHub, benchmarks against known AI-generated versus hand-written code, and ships as a GitHub Action that scores every commit and PR out of 100. There's a slopscore GitHub Marketplace listing that integrates scoring directly into CI pipelines. And the SLOP SCAN hackathon in May 2026 drew participants across eight tracks, from code review to academia to hiring, with $1,800 in prizes for tools that catch low-effort AI output before it wastes anyone's time.

The ecosystem is forming. The question is what it's really measuring, and how quickly the measurements become outdated. Every detection signal repo-slopscore looks for can be removed: strip the Co-Authored-By trailer, rephrase the commit message, delete the ghost imports. AI-assisted developers who want to avoid detection can trivially do so. The tool catches carelessness, not deliberate concealment. That limits its usefulness as a governance instrument, even as it increases its usefulness as a hygiene check.

## Why slop detection exists

"Slop" was Merriam-Webster's 2025 Word of the Year. The dictionary defines it as "digital content of low quality that is produced usually in quantity by means of artificial intelligence." The American Dialect Society agreed. The word captures something people already felt but couldn't name: content that looks plausible until you examine it closely and realize it says nothing.

In code, slop has specific fingerprints. Auto-generated comments that restate the function signature. Commit messages that summarize the diff you can already read. Test files that mirror implementation instead of encoding real behavior. Documentation that sounds correct but teaches nothing. Code that compiles, passes linters, and satisfies CI, but that nobody on the team can explain in detail.

GitHub's Octoverse report shows that Copilot generates 46% of code in files where it's enabled. Research published in Nature Human Behaviour found that up to 22% of computer science papers show signs of AI-generated content. On Amazon, studies suggest 3% of front-page reviews are AI-generated, and 74% of those are five-star ratings. "Slop" is everywhere. That's not slop by default. AI-assisted code can be excellent. But when nearly half your codebase is machine-influenced and nobody can tell which parts, you have a provenance gap. When a hiring manager looks at a candidate's GitHub contributions, or a performance review evaluates a developer's commit history, or an open source user decides whether to trust a package, the question of who wrote what becomes material.

Repo-slopscore makes that question visible. Whether you want it to or not.

## The uncomfortable implications

The first implication is about trust. Open source has always run on trust, but historically that trust attached to visible activity: maintainers with track records, review threads with real discussion, release signatures, long-lived communities. AI-assisted programming complicates this because large quantities of plausible code can arrive with less experiential residue. A function can look idiomatic without having passed through a programmer's judgment. A module can appear complete while hiding an absence of domain understanding.

The second implication is about hiring and attribution. This is where the article enters speculative territory. If repo-slopscore can detect AI-generated commits, could recruiters start using it? Possibly. If a developer's commit history shows high AI involvement, what does that mean? It could mean they're efficient, using the best available tools to ship faster. It could also mean they're pushing code they don't understand. But as of today, there's no evidence that hiring managers are running slop scores on candidates. The tool exists. The anxiety exists. The actual practice doesn't — yet. The distinction matters.

The third implication is about open source governance. A distribution maintainer might hesitate over a package with a troubling slop score. A security auditor might flag a dependency with high detected AI content. Once public scan data exists, it will be consumed by people making real decisions about which software to trust. repo-slopscore has a responsibility here, because measurement systems don't merely observe communities. They reshape them.


## The strongest counter-argument

Here's the thing about repo-slopscore: it measures something real, but what it measures isn't necessarily what matters.

Code quality should be evaluated by behavior, maintainability, and review outcomes, not inferred authorship. If a patch is correct, tested, understandable, and maintained by someone who can answer for it, the origin of the code may matter less than its current stewardship. This view treats AI assistance like any other tool in the programmer's workshop. A compiler generates code. A linter rewrites patterns. A formatter standardizes style. The output matters. The human acceptance of responsibility matters more.

There's also a false-positive problem. Generated parsers, vendored dependencies, translation files, test fixtures, mechanically ported code, and decompiled source trees can all contain patterns that resemble AI generation without being careless or unsafe. A scoring system can't always distinguish between a well-maintained generated artifact and genuine slop.

And there's a fairness problem. Small projects may use AI tools because they lack time, collaborators, or specialized expertise. A harsh public score could shame maintainers who are honestly trying to build useful software with limited resources. The better response is not to stigmatize assistance, but to raise standards for review, testing, and documentation. Some projects already include AI-generated code with clear attribution and regeneration instructions. That's the right direction: transparency about what was generated, what was reviewed, and what the maintainer understands well enough to fix when it breaks.

## The question repo-slopscore raises

Strip away the tool, the scoring, the public indexes. What remains is a question software development hasn't had to answer before at scale: does the origin of code matter if the code works?

The old answer was simple. Code was code. You read it, reviewed it, tested it. If it passed, it shipped. Authorship was relevant for credit and ego, not for trust.

The new answer is complicated. When AI tools can generate plausible code faster than humans can understand it, the relationship between author and artifact changes. A project can survive machine assistance if maintainers understand the result, test it, and accept responsibility for it. A project becomes brittle when code enters the tree as an opaque artifact, accepted because it looks right rather than because anyone can explain why it is right.

That distinction matters. It keeps the debate from collapsing into a purity contest. The meaningful question is not whether a line of code was touched by a model. It's whether the repository still has accountable human comprehension. Software is not only text. It's an arrangement of obligations. When code fails, someone must be able to reason backward from symptoms to causes, from causes to design assumptions, and from design assumptions to a repair.

Repo-slopscore is a symptom of a deeper anxiety: code can now be produced faster than it can be understood. The tool is imperfect. The scoring is debatable. But the problem it points at is real, and it's not going away. The central task is not to reject machine assistance wholesale, nor to accept every generated patch as normal progress. It's to preserve the idea that code in a repository is text someone can explain, repair, and defend.

We don't have good tools for measuring accountable human comprehension at repository scale. repo-slopscore points at the problem. The software industry already has mature frameworks for dependency provenance: SBOM documents, SLSA build attestations, Sigstore signatures, SPDX licenses. These tools track where code came from and how it was built. But they don't track whether anyone understands what the code does. That's the gap repo-slopscore is pointing at, and it's a gap worth watching.
