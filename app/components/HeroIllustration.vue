<script setup lang="ts">
    const prompts = [
        'Why is the order service responding slowly?',
        'Help me investigate the Redis connection timeout alert',
        'What caused the spike in API latency at 3am?',
        'Analyze the recent deployment impact on error rates',
        'Check the health status of payment microservice'
    ]

    const currentText = ref('')
    const currentIndex = ref(0)

    let typeTimer: ReturnType<typeof setTimeout> | null = null

    const typeEffect = () => {
        const currentPrompt = prompts[currentIndex.value]

        if (currentText.value.length < currentPrompt.length) {
            currentText.value = currentPrompt.slice(0, currentText.value.length + 1)
            typeTimer = setTimeout(typeEffect, 50)
        } else {
            // 打完后等待，然后清空并切换下一条
            typeTimer = setTimeout(() => {
                currentText.value = ''
                currentIndex.value = (currentIndex.value + 1) % prompts.length
                typeTimer = setTimeout(typeEffect, 300)
            }, 2000)
        }
    }

    onMounted(() => {
        typeEffect()
    })

    onUnmounted(() => {
        if (typeTimer) clearTimeout(typeTimer)
    })
</script>

<template>
    <div class="relative w-full max-w-xl">
        <!-- Gradient glow background -->
        <div
            class="absolute -inset-1 bg-gradient-to-r from-emerald-400/30 via-green-300/20 to-teal-400/30 rounded-2xl blur-xl" />

        <!-- Chat input container -->
        <div
            class="relative bg-white dark:bg-neutral-900 rounded-2xl shadow-lg border border-neutral-200 dark:border-neutral-700 overflow-hidden">
            <!-- Input area -->
            <div class="p-4 min-h-[100px]">
                <p class="text-neutral-500 dark:text-neutral-400 text-base">
                    {{ currentText }}<span class="animate-pulse">|</span>
                </p>
            </div>

            <!-- Bottom toolbar -->
            <div
                class="flex items-center justify-between px-4 py-3 border-t border-neutral-100 dark:border-neutral-800 bg-neutral-50 dark:bg-neutral-800/50">
                <div class="flex items-center gap-3">
                    <!-- Attachment -->
                    <button
                        class="text-neutral-400 hover:text-neutral-600 dark:hover:text-neutral-300 transition-colors">
                        <UIcon name="i-lucide-paperclip" class="w-5 h-5" />
                    </button>
                    <!-- Plugin -->
                    <button
                        class="text-neutral-400 hover:text-neutral-600 dark:hover:text-neutral-300 transition-colors">
                        <UIcon name="i-lucide-plug" class="w-5 h-5" />
                    </button>
                    <!-- Broadcast -->
                    <button
                        class="text-neutral-400 hover:text-neutral-600 dark:hover:text-neutral-300 transition-colors">
                        <UIcon name="i-lucide-radio" class="w-5 h-5" />
                    </button>
                </div>

                <!-- Send button -->
                <button
                    class="text-primary-500 hover:text-primary-600 transition-colors">
                    <UIcon name="i-lucide-send" class="w-5 h-5" />
                </button>
            </div>
        </div>
    </div>
</template>
