---
title: 'Hello, world'
description: 'Why this site exists and what I plan to write about.'
pubDate: 2026-06-10
tags: ['meta']
---

<!-- SAMPLE POST — edit or delete me. New posts are just .md files in this folder. -->

Welcome. This site is where I'll keep project writeups, lab notes, and the
occasional longer post on something I'm learning in security.

A few things I plan to cover:

- **Home lab builds** — SIEM setup, network segmentation, detection tuning
- **CTF writeups** — the interesting ones, with the dead ends left in
- **Study notes** — distilled takeaways from certs and coursework

Posts live in `src/content/blog/` as Markdown files. Frontmatter needs a
`title`, `description`, and `pubDate`; `tags` and `draft: true` are optional.

```bash
# adding a post is just:
$ vim src/content/blog/my-next-post.md
$ git add . && git commit -m "post: my next post" && git push
```

The deploy pipeline takes it from there.
