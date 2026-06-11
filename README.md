# dimitriosskrettas.com

Personal site — portfolio, blog, and project showcase. Built with
[Astro](https://astro.build), deployed to GitHub Pages, served through
Cloudflare.

## Common tasks

| Task | How |
| --- | --- |
| Run locally | `npm run dev` → http://localhost:4321 |
| Add a blog post | New `.md` file in `src/content/blog/` |
| Add a project | New `.md` file in `src/content/projects/` |
| Change name / links / nav | Edit `src/consts.ts` |
| Change colors / fonts | Edit `src/styles/global.css` (CSS variables at top) |
| Deploy | Push to `main` — GitHub Actions handles the rest |

## Structure

```
src/
  consts.ts            site-wide identity & links
  content/
    blog/              blog posts (Markdown)
    projects/          project cards (Markdown frontmatter)
  layouts/BaseLayout.astro
  components/          Header, Footer, ProjectCard
  pages/               index, about, projects, blog, rss, 404
  styles/global.css    design system
public/
  CNAME                custom domain for GitHub Pages
.github/workflows/deploy.yml
```
