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
            --bg:#0a0a0b; --bg-raised:#131316; --border:#232327;
            --text:#f3f3f1; --text-muted:#a9a9a6; --accent:#5b76ff;
            --accent-dim:rgba(91,118,255,0.14);
            --font-display: 'Archivo', ui-sans-serif, system-ui, sans-serif;
            --font-body: 'Spectral', Georgia, 'Times New Roman', serif;
            --font-mono: 'IBM Plex Mono', ui-monospace, monospace;
          }
          * { box-sizing: border-box; }
          body {
            margin: 0;
            background: var(--bg);
            color: var(--text);
            font-family: var(--font-body);
            font-size: 1.15rem;
            line-height: 1.7;
          }
          main { max-width: 44rem; margin: 0 auto; padding: 3rem 1.25rem 5rem; }
          h1 { font-family: var(--font-display); letter-spacing: -0.025em; margin: 0.4rem 0 1rem; }
          a { color: var(--accent); text-decoration: none; }
          a:hover { text-decoration: underline; text-underline-offset: 3px; }
          .eyebrow { font-family: var(--font-display); font-size: 0.78rem; font-weight: 600; letter-spacing: 0.18em; text-transform: uppercase; color: var(--accent); }
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
          <span class="eyebrow">RSS feed</span>
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
