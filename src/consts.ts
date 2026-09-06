// Site-wide constants. Edit these to update your identity everywhere at once.

export const SITE_TITLE = 'Dimitrios Skrettas';
export const SITE_DESCRIPTION =
  'Cybersecurity software engineer intern at Viasat & 2026 BSides Detroit lead organizer. Projects, writeups, and notes on security engineering.';
export const SITE_URL = 'https://dimitriosskrettas.com';

export const AUTHOR = 'Dimitrios Skrettas';

export const GITHUB_USERNAME = 'dskretta';
export const GITHUB_URL = `https://github.com/${GITHUB_USERNAME}`;

// Add or remove links here; they render in the hero and footer.
export const SOCIALS: { label: string; href: string }[] = [
  { label: 'GitHub', href: GITHUB_URL },
  { label: 'LinkedIn', href: 'https://www.linkedin.com/in/dimitrios-skrettas' },
  // { label: 'Email', href: 'mailto:you@dimitriosskrettas.com' },
];

export const NAV = [
  { label: 'Projects', href: '/projects/' },
  { label: 'Writing', href: '/blog/' },
  { label: 'Competitions', href: '/competitions/' },
  { label: 'Community', href: '/community/' },
  { label: 'About', href: '/about/' },
];
