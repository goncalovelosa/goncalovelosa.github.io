## Diana's Critique

### What I agree with

**The "homogenization, not replacement" frame is genuinely useful.** The author distinguishes between "AI replaces engineers" (the crude framing) and "AI compresses the skill distribution so that expertise differentials narrow" (the actual mechanism). This is the correct analytical lens. In every historical case I've studied — spreadsheets in accounting, CAD in architecture, diagnostic imaging in radiology — the primary mechanism is **deskilling of the middle**, not elimination of the profession. The author names this correctly on line 88: "The floor rises. The ceiling drops. Everyone becomes a generalist." That is a compact description of a real economic phenomenon, and it's better than 90% of tech commentary on this topic.

**The acknowledgment that management choices mediate technological effects is honest and underappreciated.** Lines 92-93: "homogenization is partly a management choice. The author's company chose to stop hiring for domain expertise." This is correct and important. Technology creates *capacity* for deskilling; organizations *choose* whether to exploit it. The same spreadsheet that compressed bookkeeping also enabled forensic accounting that was previously impossible. The tool is not destiny. I wish the author had sat with this insight longer instead of treating it as a caveatable afterthought.

### What doesn't hold up

**The spreadsheet and CAD analogies are invoked and then immediately abandoned.**

Line 82: "Spreadsheets didn't eliminate accountants, but they compressed the profession's middle tier. CAD changed architecture without ending it."

This is the paragraph where the author should have actually *done the work* of these comparisons. Instead, it's a drive-by reference — two sentences of handwaving that treat the most important claim in the essay as self-evident.

Here is what actually happened with spreadsheets. Before VisiCalc (1979) and Lotus 1-2-3 (1983), the "accountant" role was heavily stratified: a small layer of CPAs doing judgment work at the top, a massive layer of bookkeepers and clerks doing manual calculation in the middle, and a small layer of data entry at the bottom. Spreadsheets eliminated perhaps 40% of bookkeeping positions over 15 years. But here is the part the analogy requires: accounting *professionalized* during the same period. The CPA credential became more valuable, not less. Audit complexity increased because companies could now run more sophisticated financial operations, which created *more* judgment-layer work. The profession didn't just compress — it *restructured*, and the people who adapted into the judgment layer did well.

The author never asks whether software engineering has a comparable judgment layer that would deepen, nor whether "prompt, review, iterate" is that layer or is itself automatable. This is not a minor omission. It is the central analytical question that the historical analogy demands, and it goes unexamined.

**The claim about supply and demand is economically naive.**

Line 80: "If every senior engineer becomes a generalist with an AI copilot, the supply of generalists explodes while demand is, by most indicators, contracting."

"Most indicators" is doing enormous work here. Which indicators? The author cites anecdata about laid-off colleagues (line 80: "brilliant ex-colleagues laid off eight months ago are still looking for work"). This is a sample of one social circle during a period that has included significant tech-sector contraction driven by interest rates and post-pandemic overhiring — factors orthogonal to AI.

In labor economics, we distinguish between *technological unemployment* and *cyclical unemployment* and *structural unemployment*. The author conflates all three. That colleagues are struggling after layoffs in 2025-2026 is consistent with: (a) AI-driven skill obsolescence, (b) a cyclical downturn in tech hiring, (c) a correction from the 2021 hiring bubble, or (d) geographic/firm-specific frictions. The author assumes (a) and never considers (b)-(d). This is a reasoning error, not just a gap in evidence.

More importantly, the "supply of generalists explodes" claim assumes demand is roughly fixed. But my research on spreadsheets showed that when the cost of mid-tier production work drops, organizations *expand the scope of what they attempt*. Companies that couldn't afford bespoke financial modeling before spreadsheets suddenly could — and hired more accountants to do it. If AI makes it cheaper to build and maintain software, the relevant question is not "does demand for existing roles stay constant?" but "does demand for software-driven activity expand?" The author never entertains this possibility.

**The 19% drop in "original code output" from Xu et al. is misinterpreted.**

Line 38: "experienced developers showed a 19% drop in original code output." The author frames this as evidence of senior value erosion. But reduced individual code output is exactly what you'd expect if AI is handling routine code generation and senior engineers are spending their time on higher-level work — reviewing AI output, managing architecture, handling ambiguous requirements. That's *reallocation*, not erosion. The author treats a potentially positive signal (senior engineers shifting to more valuable work) as a negative one, without considering the alternative interpretation.

### The one thing that would make me distrust the author

**The author cites the IBM study, acknowledges the vendor conflict, and then proceeds to use the study as though the conflict doesn't matter.**

Line 68: "IBM's 2025 CHI paper by Weisz and colleagues (IBM sells its own coding assistant, Watsonx) confirmed that productivity gains exist but distribute unevenly."

Naming the conflict is good. But then the author extracts the finding ("Junior developers benefit. Senior engineers absorb the review debt.") as though it's clean evidence despite coming from a party with a direct financial interest in showing AI tools are productive. A study funded by a company that sells the product being studied, finding that the product works but has distributional effects that happen to align with what would make adoption palatable to enterprises — this should trigger *much more skepticism* than the parenthetical acknowledgment provides.

The pattern throughout is: cite evidence, note a caveat, then proceed as if the caveat is decorative. The METR study confidence intervals crossing zero (line 53) are noted and then ignored. The Xu et al. methodology being "observational" (line 38) is noted and then the finding is treated as causal. This is not scientific literacy — it's the *performance* of scientific literacy, where caveats are displayed as credibility markers rather than as actual constraints on inference.

### What I wish the author had addressed

**The category error between "knowledge" and "the ability to deploy knowledge under conditions of uncertainty."**

The author's central anxiety — that domain expertise is "promptable" (line 78) — conflates two things that my research consistently shows are distinct. Yes, Claude can produce a document about PCI compliance requirements or idempotent payment design. But the value of a senior engineer's domain knowledge was never primarily about *recalling* the correct pattern. It was about knowing which pattern to apply when the requirements are ambiguous, the stakeholder is wrong about what they want, the deadline is aggressive, and the last three people who tried this failed for reasons nobody documented.

The author's own anecdote partially contradicts his thesis. Line 30: the AI "connect[ed] the dots on how to structure payment systems, weigh trade-offs between implementations." But note the passive framing — the author *prompted the model* in the context of a specific problem. The model didn't invent the problem context. It operated within a frame the senior engineer provided. That act of framing — of knowing what to ask, when to ask it, and whether the answer is actually applicable — is not "promptable" in any meaningful sense. It is expertise being exercised at a higher level of abstraction.

I don't think AI makes this expertise obsolete. I think it makes it *harder to see*, which may be worse — because invisible expertise is expertise that doesn't get compensated, doesn't get hired for, and doesn't get developed in the next generation. The article gestures at this ("taste" as a diminishing skill, line 66) but never interrogates what "taste" actually consists of or why it resists automation.

The article is at its strongest when describing a subjective experience of dislocation, and at its weakest when it reaches for economic or historical analysis to make that experience seem general. The author is right that something is happening. But the framework for understanding *what* — and especially for distinguishing between a career transition and a profession-level restructuring — is incomplete.
