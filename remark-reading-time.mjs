import getReadingTime from 'reading-time';
import { toString } from 'mdast-util-to-string';

// Injects `minutesRead` into each post's frontmatter at build time,
// readable via remarkPluginFrontmatter after render().
export function remarkReadingTime() {
  return (tree, { data }) => {
    const readingTime = getReadingTime(toString(tree));
    data.astro.frontmatter.minutesRead = Math.max(1, Math.round(readingTime.minutes));
  };
}
