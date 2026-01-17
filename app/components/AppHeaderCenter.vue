<script setup lang="ts">
    const route = useRoute()

    const menuItems = [
        { label: 'Documentation', to: '/docs/getting-started/introduction', icon: 'i-lucide-book-open' },
        { label: 'Blog', to: '/blogs', icon: 'i-lucide-file-text' }
    ]

    const isActive = (item: typeof menuItems[0]) => {
        return route.path.startsWith(item.to.split('/').slice(0, 2).join('/'))
    }
</script>

<template>
    <nav class="w-full lg:flex items-center justify-center gap-1">
        <NuxtLink v-for="item in menuItems" :key="item.label" :to="item.to" :class="[
            'flex items-center gap-1.5 px-3 py-1.5 rounded-md text-sm font-medium transition-colors',
            isActive(item)
                ? 'text-primary-600 dark:text-primary-400'
                : 'text-neutral-600 hover:text-neutral-900 hover:bg-neutral-100 dark:text-neutral-400 dark:hover:text-neutral-100 dark:hover:bg-neutral-800'
        ]">
            <UIcon :name="item.icon" class="size-4" />
            {{ item.label }}
        </NuxtLink>
    </nav>
</template>
