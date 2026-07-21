import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'AI Context Hub',
  description: 'Tool-neutral knowledge base of workflow rules and skills for AI-assisted development',
  base: '/ai-context-hub/',
  cleanUrls: true,

  themeConfig: {
    logo: '🧠',
    siteTitle: 'AI Context Hub',
    
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Workflows', link: '/docs/workflows/spec-driven-development' },
      { text: 'Rules & Practices', link: '/rules/global-rules' },
      { text: 'Templates', link: '/docs/templates/spec-template' },
      { text: 'Adapters', link: '/adapters/claude-code/' }
    ],

    sidebar: [
      {
        text: '🚀 Getting Started',
        items: [
          { text: 'Overview & Setup', link: '/README' }
        ]
      },
      {
        text: '🔄 Workflows',
        items: [
          { text: 'Spec-Driven Development', link: '/docs/workflows/spec-driven-development' },
          { text: 'Implementation Plan', link: '/docs/workflows/implementation-plan' },
          { text: 'Test-Driven Development', link: '/docs/workflows/test-driven-development' },
          { text: 'Code Review', link: '/docs/workflows/code-review' },
          { text: 'Project Bootstrap', link: '/docs/workflows/project-bootstrap' }
        ]
      },
      {
        text: '📏 Rules & Practices',
        items: [
          { text: 'Global Rules', link: '/rules/global-rules' },
          { text: 'Backend Practices', link: '/rules/practices/backend' },
          { text: 'Frontend Practices', link: '/rules/practices/frontend' },
          { text: 'API Design', link: '/rules/practices/api-design' },
          { text: 'Database Practices', link: '/rules/practices/database' },
          { text: 'Git Workflow', link: '/rules/practices/git-workflow' }
        ]
      },
      {
        text: '📄 Templates',
        items: [
          { text: 'Specification Template', link: '/docs/templates/spec-template' },
          { text: 'ADR Template', link: '/docs/templates/adr-template' },
          { text: 'Test Plan Template', link: '/docs/templates/test-plan-template' },
          { text: 'Code Review Checklist', link: '/docs/templates/review-checklist-template' }
        ]
      },
      {
        text: '🔌 Adapters',
        items: [
          { text: 'Claude Code Adapter', link: '/adapters/claude-code/' },
          { text: 'Antigravity / Gemini Adapter', link: '/adapters/antigravity/' },
          { text: 'Cursor IDE Adapter', link: '/adapters/cursor/' }
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
