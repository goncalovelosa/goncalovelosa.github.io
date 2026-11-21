---
title: "Sessions Are Portable Now. Context Still Isn't."
description: "What GitHub's Agent Host Protocol actually standardizes, what it stays out of, and why the quiet launch is the tell."
pubDate: 2026-11-21
category: "AI"
tags: ["ai", "software-engineering", "programming", "technology", "software-development"]
heroImage: "./agent-host-protocol/images/VISUAL_1_cover_1.png"
---

At any given moment I am running three coding agents. One lives in a terminal, one lives in an IDE, one lives on a box I never see. They are all good at their jobs, and they all share one property that costs me hours every week: the moment I switch surfaces, the session dies. The transcript is somewhere on disk, the working state is gone, and whatever the agent had learned about my repo in the last forty minutes has to be relearned from scratch, or paid for again in tokens, or both.

On Tuesday, November 17, the GitHub engineering blog published a retrospective called "Building the Agent Host Protocol for sessions that continue across devices." Retrospective is the right word: the repo dates to March and the spec hit 1.0 in early October. The authors are Connor Peet and Rob Lourens, two Principal Engineers from the VS Code team. The post describes the Agent Host Protocol, AHP: an MIT-licensed, JSON-RPC specification that lets agent sessions continue across clients. Start a session in the Copilot app, approve a tool call from your phone, review the diff in VS Code, let a cloud agent land the pull request. Same session the whole way. The post includes that exact day-in-the-life, timestamped: 9:02 AM to 11:32 AM, four surfaces, one session.

![A single brass key hovering above a row of five different antique lock faces set into dark walnut wood, lit by one warm spotlight.](./agent-host-protocol/images/VISUAL_1_cover_1.png)

*One session, many clients. The lock faces change; the key does not.*

The reception on Hacker News: the post was submitted on November 20 and collected two points and zero comments. The best thread the protocol has ever managed, from August's Agent Host introduction, was four points and zero comments. Hacker News never front-paged it. The README already lists a shelf of community clients and bridges; the builders found it anyway. Standards work lands like this. The loudest thing in the room right now is model releases, and the layer underneath them is being decided in a repo with 468 stars.


## What the protocol is, stripped of branding

Strip the branding and AHP is a contract between two processes. On one side, an agent host: a process that owns agent sessions. On the other, clients: editors, apps, phones, web pages, CLIs. They speak JSON-RPC 2.0 over a message port locally or a WebSocket remotely, and the session state is an immutable tree with pure reducers, the same trick that keeps editors and distributed systems coherent. The host is the arbiter of truth. Clients dispatch actions, apply them optimistically, and reconcile.

Functionality comes in channels, addressed by URI, and every server must implement three of them: root, session, and chat. Others are optional, including terminal access, telemetry, and an MCP bridge. Inside a session, the protocol state includes the title, status, provider, working directories, the chat catalog, changesets, aggregated input requests, and per-chat settings; tool auto-approval can differ between chats in the same session. The chat channel carries turns, streaming responses, tool calls, pending messages, which makes the conversation and its pending approvals first-class protocol state, synchronized across every connected client.

The GitHub blog describes the payoff in one sentence I keep rereading: "A shared protocol means every client sees the same agents, history, and state without bespoke integrations, and you aren't tied to one app's idea of what an agent session is."

Now the refusal, which is the most interesting design decision in the spec. The authors write that "the protocol needed to stay out of agent *behavior*," and that "AHP avoids encoding how agents work, and instead focuses on how you want to interact with them." Copilot and Claude keep their own SDKs, agent loops, tools, and provider-specific capabilities. AHP standardizes the session furniture around them: presence, history, approvals, state. The bet underneath is that interaction stabilizes faster than intelligence. You can believe that or not, but as a protocol design it is the same move that made language servers ubiquitous: define the interface, let the implementations fight.

## The part everyone will get wrong

AHP ports the session. It does not port the context.

The spec is explicit that AHP describes "client-facing session state and display-ready metadata." The transcript travels. The pending approvals travel. What stays home is everything the model assembled around those turns: the prompt construction, the hidden reasoning, the compaction decisions. Reconnect from a new client and you inherit the history without the cognition. A rebuild from transcript is possible, and it is lossy. A session that continues is not a brain that continues.

For a fleet operator this distinction is the whole contract. What AHP gives me is a command center: one surface where a Copilot session, a Claude session, and a Codex session sit side by side, each on its own runtime, each resumed and approved from wherever I am. That is genuinely new, and the MultiHostClient SDKs in the Rust, Go, Swift, and .NET libraries suggest the team expects dashboards as well as editors. What it does not give me is immortality for working state. The most expensive asset in my stack still evaporates when I switch harnesses, Copilot to Claude to Codex, or when a host stops. Between surfaces, for the first time, it survives.

![Cutaway of a dark glass tower at night with two warmly lit upper floors connected by a brass elevator shaft, and one dim unmarked middle floor the shaft passes through without stopping.](./agent-host-protocol/images/VISUAL_2_diagram_1.png)

*The session and UI floors connect. The elevator skips the context floor.*

## The LSP story, told honestly

The VS Code team draws the analogy itself, on the record, three times. "We built on our Language Server Protocol and Debug Adapter Protocol experience to create the Agent Host Protocol," they wrote in October, "just as a language server makes code completion and Go to Definition available to different editors, an Agent Host brings agent functionality into an independent process."

I want to take the analogy seriously, because the history is instructive, and because it breaks in two places that matter.

The Language Server Protocol was announced on June 27, 2016, at DevNation in San Francisco, by Microsoft together with Red Hat and Codenvy, with third-party adoption the same day. Three companies, a coalition, and a neutral-enough format that every editor and every language community could join without feeling captured. It worked. Language servers became infrastructure, and the editor that shipped the reference implementation ended the decade used by 70.9 percent of Stack Overflow's 2026 survey respondents, two and a half times the runner-up. Standardize the interface, and the surface area you own quietly compounds.

![Two heavy timber beams on dark slate, the left carried by three bronze chains in equilibrium, the right carried by one chain pulled taut under visible strain.](./agent-host-protocol/images/VISUAL_3_chart_1.png)

*LSP launched as a three-company coalition. AHP launched alone.*

The first break is the coalition. AHP launched alone. The repo sits in the Microsoft org, the code owners are the two blog authors, the license is MIT, and there is no foundation, no steering committee, and no external governance anywhere in sight. The first-party clients that ship today, VS Code, the Copilot app, GitHub Mobile, github.com, and Copilot CLI, are all inside one corporate parent. Anthropic and OpenAI have not adopted it. Claude and Codex reach AHP only through host-side adapters in VS Code, or through community bridges, several of which route through a rival protocol first.

The second break is the compatibility posture. The versioning document is blunt about this. LSP and DAP "largely guarantee backwards compatibility in perpetuity"; the agent-host design space, it argues, "is open-ended and moving quickly." Then comes the sentence that should stop any migration planner: "Backwards-incompatible changes to AHP are inevitable." The same document grades the damage: root, session, chat, and terminal are marked Stable, the MCP channel is a release candidate, and published baselines 1.0.0 and 0.9.0 can be pinned at connection time. AHP declines LSP's perpetual-compatibility guarantee on purpose. The honesty is refreshing and the implication is real: pin your negotiated version, because the floor will move.

And the counterparty picture is different this time. Language communities were fragmented but friendly; nobody shipped a rival protocol. The agent world has one. The Agent Client Protocol, from Zed and JetBrains, covers the same editor-to-agent seam, self-describes with the same LSP analogy, and has its own client list. What we have is an unsettled standards race with two credible entrants, one of which currently has all its shipping first parties inside a single company.

## Where MCP fits

The relation to the Model Context Protocol is complementary, and narrower than the diagrams suggest. MCP is the agent talking to tools and context. AHP is clients talking to the thing that owns the session. There is a bridge: an optional mcp channel that, per the spec, "is an optional side-channel that lets an AHP client originate a constrained subset of MCP traffic against an MCP server the agent host is already running." It speaks MCP verbatim, but only the subset the host has opted into exposing, and the state-bearing methods are excluded because AHP already mirrors them host-side. The boundary is drawn host-side: whoever owns the host decides what the client sees.

## What it costs, what breaks

The adoption story is unusually cheap on paper. Client libraries exist in six languages. The spec ships language-independent test suites, and the VS Code release notes contain a line that doubles as a thesis about the future: "We publish libraries in six languages and have found agents are good at making clients and hosts using them." The agents are building the protocol's ecosystem. A standalone host is one command away, with a connection token and a tunnel flag. Two capabilities deserve credit before the costs: reconnection and replay are designed in, and the enterprise hooks are real, with managed settings able to gate whole harnesses.

The costs are elsewhere. Tools contributed by a client only work while that client is connected. The VS Code local harness is deprecated and gets removed in February 2027. Registering a GitHub environment does not move your workspace or provision compute, and the host has to keep running. Experimental channels will churn. The migration bill is visible inside Microsoft itself: Copilot Chat had grown past 400,000 lines of TypeScript before the rebuild. The protocol is small. The rewrites it asks for are not.

![A dark rail yard where a single track of glowing small crates reaches a split into two tracks of visibly different gauge widths curving toward different horizons.](./agent-host-protocol/images/VISUAL_4_illustration_1.png)

*Two standards, one seam. The race for the session layer is not settled.*

## What I am watching

Three signals will tell you how this resolves. First, whether any lab ships native AHP support, because one native adopter outside Redmond changes the race from solo bet to coalition. Second, whether AHP and ACP converge or fragment, because a session-layer format war taxes exactly the people running heterogeneous fleets. Third, February 2027, when the local harness disappears and a lot of quiet workflows either migrate or break loudly.

My stance, as the person paying to rebuild context three ways each week: I will build against the adapter and keep the fleet portable, and I will not bet anything I cannot migrate in an afternoon on a protocol whose own documentation promises breakage. If the session layer consolidates the way the editor layer did, it will be behind the vendor that shipped alone and told you plainly that it will break things.

The transcript now travels. The working set does not. Between those two sentences is where every fleet operator's next architecture decision lives.
