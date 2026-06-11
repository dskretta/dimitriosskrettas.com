<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" encoding="utf-8" indent="yes"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <title><xsl:value-of select="/rss/channel/title"/> · RSS feed</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
          :root {
            --bg: #0b0e14;
            --bg-raised: #11151f;
            --border: #1e2533;
            --text: #e6e9ef;
            --text-muted: #97a0b3;
            --accent: #34d399;
            --accent-dim: rgba(52, 211, 153, 0.12);
            --font-sans: ui-sans-serif, system-ui, 'Segoe UI', Roboto, sans-serif;
            --font-mono: ui-monospace, 'Cascadia Code', Consolas, Menlo, monospace;
          }
          * { box-sizing: border-box; }
          body {
            margin: 0;
            background: var(--bg);
            color: var(--text);
            font-family: var(--font-sans);
            font-size: 1.0625rem;
            line-height: 1.7;
          }
          main { max-width: 44rem; margin: 0 auto; padding: 3rem 1.25rem 5rem; }
          h1 { letter-spacing: -0.015em; margin: 0.4rem 0 1rem; }
          a { color: var(--accent); text-decoration: none; }
          a:hover { text-decoration: underline; text-underline-offset: 3px; }
          .mono-label { font-family: var(--font-mono); font-size: 0.8rem; color: var(--accent); }
          .explainer {
            background: var(--bg-raised);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 1rem 1.25rem;
            color: var(--text-muted);
            font-size: 0.95rem;
            margin: 0 0 2.5rem;
          }
          .explainer code {
            font-family: var(--font-mono);
            font-size: 0.85em;
            background: var(--accent-dim);
            color: var(--accent);
            border-radius: 4px;
            padding: 0.1em 0.4em;
          }
          .item { margin: 0 0 1.6rem; }
          .item .date {
            font-family: var(--font-mono);
            font-size: 0.8rem;
            color: var(--text-muted);
            display: block;
            margin-bottom: 0.15rem;
          }
          .item a.title { color: var(--text); font-weight: 600; font-size: 1.08rem; }
          .item a.title:hover { color: var(--accent); }
          .item p { margin: 0.25rem 0 0; color: var(--text-muted); font-size: 0.95rem; }
        </style>
      </head>
      <body>
        <main>
          <span class="mono-label">// rss feed</span>
          <h1><xsl:value-of select="/rss/channel/title"/></h1>
          <div class="explainer">
            <strong>This is an RSS feed.</strong> It's meant for feed readers,
            not browsers — subscribe by copying this page's URL
            (<code><xsl:value-of select="/rss/channel/link"/>rss.xml</code>)
            into an app like Feedly, Miniflux, or NetNewsWire, and new posts
            will show up there automatically. Or just read below — and visit
            the site at
            <a><xsl:attribute name="href"><xsl:value-of select="/rss/channel/link"/></xsl:attribute><xsl:value-of select="/rss/channel/link"/></a>
          </div>
          <xsl:for-each select="/rss/channel/item">
            <div class="item">
              <span class="date"><xsl:value-of select="substring(pubDate, 1, 16)"/></span>
              <a class="title">
                <xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
                <xsl:value-of select="title"/>
              </a>
              <p><xsl:value-of select="description"/></p>
            </div>
          </xsl:for-each>
        </main>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
