<script setup lang="ts">
    definePageMeta({
        layout: 'default'
    })

    useSeoMeta({
        title: 'Blog',
        description: 'Latest articles, insights, and updates from the Castrel team.'
    })

    const { data: posts } = await useAsyncData('blogs', async () => {
        const allDocs = await queryCollection('docs').all();
        const blogPosts = allDocs?.filter(doc => doc.path?.startsWith('/blogs/')) || [];

        // Sort by order field descending (higher order = newer = first)
        // Note: frontmatter fields may be in meta object or directly on doc
        return blogPosts.sort((a: any, b: any) => {
            const orderA = a.order || a.meta?.order || 0;
            const orderB = b.order || b.meta?.order || 0;
            return orderB - orderA;
        });
    })
</script>

<template>
    <div class="container mx-auto max-w-6xl px-4 py-24">
        <div class="mb-12 text-center">
            <h1
                class="text-4xl font-bold text-neutral-900 dark:text-neutral-100 sm:text-5xl">
                Blog
            </h1>
            <p class="mt-4 text-lg text-neutral-600 dark:text-neutral-400">
                Latest articles, insights, and updates from the Castrel team.
            </p>
        </div>

        <div v-if="posts?.length" class="grid gap-8 sm:grid-cols-2 lg:grid-cols-3">
            <BlogPostCard v-for="post in posts" :key="post.path" :post="post" />
        </div>

        <div v-else class="flex flex-col items-center justify-center py-16">
            <UIcon name="i-lucide-file-text"
                class="size-16 text-neutral-400 dark:text-neutral-600 mb-4" />
            <p class="text-neutral-600 dark:text-neutral-400">
                No blog posts yet. Check back soon!
            </p>
        </div>
    </div>
</template>
