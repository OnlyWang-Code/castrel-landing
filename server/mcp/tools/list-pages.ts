import { z } from 'zod'
import { queryCollection } from '@nuxt/content/server'
import type { Collections } from '@nuxt/content'

export default defineMcpTool({
    description: `Lists all available pages from Castrel website including documentation and blog posts.

WHEN TO USE: Use this tool when you need to EXPLORE or SEARCH for content but don't know the exact page path.

OUTPUT: Returns a structured list with title, path, description, type, and category for each page.

NOTE: The "category" filter only applies to docs. Blogs do not have categories (flat structure under /blogs/).
Available doc categories: "getting-started", "features", "integrations", "security", "more".`,

    inputSchema: {
        type: z.enum(['all', 'docs', 'blogs']).optional().describe('Filter by content type: all (default), docs, or blogs'),
        search: z.string().optional().describe('Search keyword to filter pages by title or description (case-insensitive)'),
        title: z.string().optional().describe('Search keyword to filter pages by title only (case-insensitive)'),
        category: z.string().optional().describe('Filter by category/directory. Only applies to docs. Available: "getting-started", "features", "integrations", "security", "more"'),
        limit: z.coerce.number().optional().describe('Maximum number of results to return'),
    },

    cache: '1h',

    handler: async ({ type = 'all', search, title, category, limit }) => {
        const event = useEvent()

        try {
            // 使用 Nuxt Content v3 的 queryCollection API
            const allDocs = await queryCollection(event, 'docs' as keyof Collections)
                .select('title', 'path', 'description')
                .all()

            const pages: Array<{
                title: string
                path: string
                description: string
                type: 'docs' | 'blogs'
                category: string | null
            }> = []

            for (const doc of allDocs || []) {
                if (!doc.path) continue

                const isBlog = doc.path.startsWith('/blogs/')
                const isDoc = doc.path.startsWith('/docs/')

                // Filter by type
                if (type === 'docs' && !isDoc) continue
                if (type === 'blogs' && !isBlog) continue
                if (type === 'all' && !isDoc && !isBlog) continue

                // Extract category from path for docs
                let pageCategory: string | null = null
                if (isDoc) {
                    const pathParts = doc.path.split('/')
                    pageCategory = pathParts.length >= 3 ? pathParts[2] : null
                }

                pages.push({
                    title: doc.title || 'Untitled',
                    path: doc.path,
                    description: doc.description || '',
                    type: isBlog ? 'blogs' : 'docs',
                    category: pageCategory,
                })
            }

            // Apply filters
            let filteredPages = pages

            // Category filter
            if (category) {
                const normalizedCategory = category.toLowerCase()
                filteredPages = filteredPages.filter(p =>
                    p.category && p.category.toLowerCase() === normalizedCategory,
                )
            }

            // Search filter (case-insensitive match on title or description)
            if (search) {
                const searchLower = search.toLowerCase()
                filteredPages = filteredPages.filter(p =>
                    p.title.toLowerCase().includes(searchLower)
                    || p.description.toLowerCase().includes(searchLower),
                )
            }

            // Title filter (case-insensitive match on title only)
            if (title) {
                const titleLower = title.toLowerCase()
                filteredPages = filteredPages.filter(p =>
                    p.title.toLowerCase().includes(titleLower),
                )
            }

            // Sort by path for consistent ordering
            filteredPages.sort((a, b) => a.path.localeCompare(b.path))

            // Apply limit
            if (limit && limit > 0) {
                filteredPages = filteredPages.slice(0, limit)
            }

            return jsonResult(filteredPages)
        }
        catch (error) {
            console.error('MCP list-pages error:', error)
            return errorResult(`Failed to list pages: ${error instanceof Error ? error.message : String(error)}`)
        }
    },
})
