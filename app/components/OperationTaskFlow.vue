<script setup lang="ts">
</script>

<template>
    <div
        class="operation-task-flow w-full h-full flex flex-col items-center justify-center gap-6 p-6">
        <!-- Logo 区域 -->
        <div class="flex items-center justify-center gap-8">
            <div class="flex flex-col items-center gap-2">
                <div
                    class="w-16 h-16 rounded-xl bg-primary-500 flex items-center justify-center">
                    <UIcon name="i-lucide-bot" class="w-10 h-10 text-white" />
                </div>
                <span class="text-sm text-gray-500">Castrel</span>
            </div>

            <UIcon name="i-lucide-arrow-right" class="w-6 h-6 text-gray-400" />

            <div class="flex flex-col items-center gap-2">
                <div
                    class="w-16 h-16 rounded-xl bg-gray-700 flex items-center justify-center">
                    <UIcon name="i-lucide-cable" class="w-10 h-10 text-white" />
                </div>
                <span class="text-sm text-gray-500">Castrel Proxy</span>
            </div>

            <UIcon name="i-lucide-arrow-right" class="w-6 h-6 text-gray-400" />

            <div class="flex flex-col items-center gap-2">
                <div
                    class="w-16 h-16 rounded-xl bg-gray-900 flex items-center justify-center">
                    <UIcon name="i-lucide-monitor" class="w-10 h-10 text-white" />
                </div>
                <span class="text-sm text-gray-500">Your Computer</span>
            </div>
        </div>

        <!-- 说明文字 -->
        <p class="text-center text-gray-600 dark:text-gray-400 max-w-md">
            During a chat session, Castrel can connect to a local proxy and temporarily
            become a local agent, helping you execute operation tasks on your
            infrastructure.
        </p>
    </div>
</template>

<style scoped>
.operation-task-flow {
    max-height: 352px;
}
</style>
