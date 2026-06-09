---
title: "Blog: Code Comments: Your Secret Weapon for a Happier Dev Life (and a Healthier Codebase)"
description: "How to write code comments that actually help — TODOs, FIXMEs, inline explanations, and the anti-patterns to avoid in your codebase."
pubDate: 2024-06-15
category: "TypeScript"
tags: ["code-comments", "best-practices", "clean-code", "documentation", "maintainability"]
mediumUrl: "https://medium.com/@gvelosa/code-comments-your-secret-weapon-for-a-happier-dev-life-and-a-healthier-codebase-e7457af42df5"
heroImage: "./code-comments-your-secret-weapon-for-a-happier-dev-life-and-a-healthier-codebase/images/cover.png"
canonicalUrl: "https://medium.com/@gvelosa/code-comments-your-secret-weapon-for-a-happier-dev-life-and-a-healthier-codebase-e7457af42df5"
---

Listen, we're all guilty of it. We write a line of code that's a masterpiece of logical wizardry… and then leave it as a cryptic puzzle for our future selves (or worse, our poor colleagues).

That's where code comments swoop in to save the day. But, let's be real, not all comments are created equal. Some are heroes, some are villains, and some just… exist.

Here's how to make your comments the heroes of your codebase:

## TODO: Level Up Your Comment Game

**The Underappreciated TODO:** This is the trusty sidekick every developer needs. A well-placed `// TODO:` is a promise to your future self (or your team). It's a flag for **technical debt** – a reminder that this piece of code needs revisiting to make it even better.

- **Pro Tip:** Be specific! Instead of `// TODO: Fix this`, try `// TODO: Refactor this logic to handle edge case X`.
- **Urgency Matters:** If possible, address TODOs immediately. If not, attach a ticket number or expiry date to track and prioritize them.

**FIXME: The Codebase Doctor:** `// FIXME:` comments are the warning signs in your codebase. They shout, "Hey! This works now, but it's a bit of a hack. Come back and give it some love when you have time."

- **Bonus Points:** Add a quick explanation of *why* it needs fixing and, ideally, fix it right away. Otherwise, treat it like a TODO — track it!

**The Humble Inline Comment:** These are the everyday workhorses of your comments. Use them to:

- **Explain the "why":** If your code is doing something clever (or just plain weird), tell us why!
- **Clarify complex logic:** Sometimes, a few words can save someone hours of head-scratching.
- **Document assumptions:** If your code relies on certain conditions, spell it out. It's insurance against unexpected bugs.

**The Legendary Block Comment:** Reserved for the big picture stuff, block comments help you understand the structure and flow of your code. Use them to:

- **Introduce classes or functions:** A quick summary of what it does and why it exists.
- **Describe algorithms:** Break down complex logic step-by-step.
- **Group related code:** Add a comment to explain the purpose of a code block.

## Don't Be That Developer

Avoid these comment anti-patterns:

- **Captain Obvious:** Comments that simply restate what the code does. We can read, thanks.
- **The Novelist:** Excessive comments that tell a story. We're trying to code, not read War and Peace.
- **The Liar:** Outdated comments that no longer reflect the code. This is worse than no comment at all.
- **Public Shaming:** Comments that criticize other developers. Be constructive!

## Remember: Your Comments Are For You (and Your Fellow Devs)

In the end, comments are a tool for you and your team. They're about making your code more understandable, maintainable, and just plain enjoyable to work with. So, go forth and comment like a pro! Your future self will be eternally grateful.

**A Few Extra Tips:**

- **Clean Up Before Release:** Remove TODOs and FIXMEs before deploying to production. Use a bundler/minifier to help with this.
- **Protect Your Secrets:** Avoid leaving sensitive information (like API keys) in comments.
