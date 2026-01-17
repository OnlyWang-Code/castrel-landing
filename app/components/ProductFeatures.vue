<script setup lang="ts">
    import { ref, computed } from 'vue'

    interface TabItem {
        label: string
        icon?: string
        title: string
        description: string
        rightImage?: string
        fullWidthImage?: string
        imagePosition?: string
        imageScale?: number
        demoUrl?: string
        videoUrl?: string
        docsUrl?: string
    }

    const props = defineProps<{
        tabs: TabItem[]
    }>()

    const activeIndex = ref(0)

    const activeTab = computed(() => props.tabs[activeIndex.value])

    const tabItems = computed(() =>
        props.tabs.map((tab, index) => ({
            label: tab.label,
            icon: tab.icon,
            value: index
        }))
    )
</script>

<template>
    <UContainer>
        <div class="product-features py-12 lg:py-16">
            <!-- Tabs 导航 -->
            <div class="tabs-container mb-6">
                <UTabs v-model="activeIndex" :items="tabItems" variant="pill" />
            </div>

            <!-- 内容区域 -->
            <div
                class="content-wrapper rounded-xl border border-neutral-200 dark:border-neutral-800 bg-neutral-50 dark:bg-neutral-900 overflow-hidden">
                <ProductFeatureTab :tab="activeTab" :index="activeIndex">
                    <template v-for="(_, slotName) in $slots" :key="slotName"
                        #[slotName]>
                        <slot :name="slotName" />
                    </template>
                </ProductFeatureTab>
            </div>
        </div>
    </UContainer>
</template>
