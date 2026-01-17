<script setup lang="ts">
    import { computed, useSlots } from 'vue'

    interface TabData {
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
        tab: TabData
        index: number
    }>()

    const slots = useSlots()

    const hasButtons = computed(() => {
        return props.tab.demoUrl || props.tab.videoUrl || props.tab.docsUrl
    })

    const hasLeftSlot = computed(() => !!slots[`tab-${props.index}-left`])
    const hasRightSlot = computed(() => !!slots[`tab-${props.index}-right`])
</script>

<template>
    <div class="product-feature-tab">
        <!-- 视觉展示区域 -->
        <div v-if="tab.fullWidthImage"
            class="visual-area relative h-[400px] overflow-hidden">
            <img :src="tab.fullWidthImage" :alt="tab.title"
                class="absolute inset-0 w-full h-full object-cover" :style="{
                    objectPosition: tab.imagePosition || 'center'
                }" />
        </div>
        <div v-else
            class="visual-area grid grid-cols-1 lg:grid-cols-2 gap-0 h-[400px] overflow-hidden">
            <!-- 左侧：slot -->
            <div
                class="visual-left relative p-6 flex items-center justify-center border-r border-neutral-200 dark:border-neutral-800 bg-neutral-100/50 dark:bg-neutral-800/50 overflow-hidden">
                <slot :name="`tab-${index}-left`">
                    <div class="text-neutral-400 text-sm">
                        left side
                    </div>
                </slot>
            </div>

            <!-- 右侧：slot 或图片 -->
            <div class="visual-right relative w-full h-full overflow-hidden">
                <slot :name="`tab-${index}-right`">
                    <img v-if="tab.rightImage" :src="tab.rightImage" :alt="tab.title"
                        class="absolute inset-0 w-full h-full object-cover" :style="{
                            objectPosition: tab.imagePosition || 'center',
                            transform: tab.imageScale ? `scale(${tab.imageScale})` : undefined,
                            transformOrigin: tab.imagePosition || 'center'
                        }" />
                    <div v-else
                        class="w-full h-full flex items-center justify-center bg-neutral-100/50 dark:bg-neutral-800/50 text-neutral-400 text-sm">
                        right side
                    </div>
                </slot>
            </div>
        </div>

        <!-- 底部信息区域 -->
        <div
            class="footer-area flex flex-col lg:flex-row items-start justify-between gap-4 p-6 h-[180px] border-t border-neutral-200 dark:border-neutral-800 bg-white dark:bg-neutral-950">
            <!-- 左侧：标题和描述 -->
            <div class="info-section flex-1">
                <h3 class="text-xl font-semibold text-neutral-900 dark:text-white mb-2">
                    {{ tab.title }}
                </h3>
                <p
                    class="text-neutral-600 dark:text-neutral-400 text-sm leading-relaxed">
                    {{ tab.description }}
                </p>
            </div>

            <!-- 右侧：按钮组（垂直排列） -->
            <div v-if="hasButtons"
                class="buttons-section flex flex-col gap-2 min-w-[140px]">
                <UButton v-if="tab.demoUrl" :to="tab.demoUrl" target="_blank"
                    variant="outline" color="neutral" block>
                    Chat Demo
                </UButton>
                <UButton v-if="tab.videoUrl" :to="tab.videoUrl" target="_blank"
                    variant="outline" color="neutral" block>
                    Video Demo
                </UButton>
                <UButton v-if="tab.docsUrl" :to="tab.docsUrl" variant="outline"
                    color="neutral" block>
                    Documents
                </UButton>
            </div>
        </div>
    </div>
</template>
