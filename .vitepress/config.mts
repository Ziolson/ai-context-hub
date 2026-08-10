import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'AI Context Hub',
  description: 'Tool-neutral knowledge base of workflow rules and skills for AI-assisted development',
  base: '/ai-context-hub/',
  cleanUrls: true,
  lastUpdated: true,

  head: [
    ['link', { rel: 'icon', type: 'image/svg+xml', href: 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><text y=".9em" font-size="90">🧠</text></svg>' }],
    ['meta', { name: 'theme-color', content: '#6366f1' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:title', content: 'AI Context Hub' }],
    ['meta', { property: 'og:description', content: 'Tool-neutral knowledge base of workflow rules and skills for AI-assisted development' }],
    ['meta', { property: 'og:site_name', content: 'AI Context Hub' }]
  ],

  themeConfig: {
    logo: '🧠',
    siteTitle: 'AI Context Hub',
    outline: [2, 3],
    
    editLink: {
      pattern: 'https://github.com/Ziolson/ai-context-hub/edit/main/:path',
      text: 'Edit this page on GitHub'
    },
    
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Guides & Architecture', link: '/guide/' },
      { text: 'SDD Workflows', link: '/guide/spec-driven-development-explained' },
      { text: 'Best Practices', link: '/guide/global-rules' },
      { text: 'Tool Adapters', link: '/guide/adapters-and-architecture' }
    ],

    sidebar: [
      {
        text: '📖 Guides & Architecture',
        items: [
          { text: 'About AI Context Hub', link: '/guide/' },
          { text: 'Adapters & Architecture', link: '/guide/adapters-and-architecture' }
        ]
      },
      {
        text: '🔄 Workflow Guides',
        items: [
          { text: 'Project Bootstrap (Zero-to-One)', link: '/guide/project-bootstrap' },
          {
            text: 'Spec-Driven Development (SDD)',
            link: '/guide/spec-driven-development-explained',
            items: [
              { text: 'Phase 1: Discovery & Specification', link: '/guide/discovery' },
              { text: 'Phase 2: Implementation Planning', link: '/guide/implementation-plan' },
              { text: 'Phase 3: TDD Implementation', link: '/guide/test-driven-development' },
              { text: 'Phase 4: Structured Code Review', link: '/guide/code-review' }
            ]
          }
        ]
      },
      {
        text: '📏 Best Practices Guides',
        items: [
          { text: 'Global Rules & Philosophy', link: '/guide/global-rules' },
          { text: 'Backend Practices', link: '/guide/backend' },
          { text: 'Frontend Practices', link: '/guide/frontend' },
          { text: 'API Design', link: '/guide/api-design' },
          { text: 'Database Practices', link: '/guide/database' },
          { text: 'Git & Branching Workflow', link: '/guide/git-workflow' },
          { text: 'Pragmatic Testing', link: '/guide/testing' },
          { text: 'Security Baseline', link: '/guide/security' }
        ]
      }
    ],

    search: {
      provider: 'local'
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/Ziolson/ai-context-hub' }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2026 AI Context Hub'
    }
  }
})
