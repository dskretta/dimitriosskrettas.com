import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const blog = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/blog' }),
  schema: ({ image }) => z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    tags: z.array(z.string()).default([]),
    draft: z.boolean().default(false),
    heroImage: image().optional(),
    heroImageCaption: z.string().optional(),
  }),
});

const competitions = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/competitions' }),
  schema: z.object({
    event: z.string(),
    date: z.coerce.date(),
    team: z.string().optional(),
    placement: z.string().optional(),
    description: z.string().optional(),
    writeup: z.string().url().or(z.string().startsWith('/')).optional(),
    draft: z.boolean().default(false),
  }),
});

const community = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/community' }),
  schema: z.object({
    role: z.string(),
    org: z.string(),
    date: z.coerce.date(),
    endDate: z.coerce.date().optional(),
    description: z.string().optional(),
    link: z.string().url().or(z.string().startsWith('/')).optional(),
    draft: z.boolean().default(false),
  }),
});

const projects = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/projects' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    tags: z.array(z.string()).default([]),
    repo: z.string().url().optional(),
    // external URL or internal path (e.g. '/blog/tags/ctf/')
    demo: z.string().url().or(z.string().startsWith('/')).optional(),
    featured: z.boolean().default(false),
    order: z.number().default(0),
  }),
});

export const collections = { blog, projects, competitions, community };
