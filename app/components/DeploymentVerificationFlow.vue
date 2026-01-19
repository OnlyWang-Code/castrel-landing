<script setup lang="ts">
</script>

<template>
    <div
        class="deployment-verification-flow w-full h-full flex flex-col items-center justify-center gap-6 p-6">
        <!-- Logo 区域 -->
        <div class="flex items-center justify-center gap-8">
            <div class="flex flex-col items-center gap-2">
                <div
                    class="w-16 h-16 rounded-xl bg-black flex items-center justify-center">
                    <UIcon name="i-simple-icons-vercel" class="w-10 h-10 text-white" />
                </div>
                <span class="text-sm text-gray-500">Vercel</span>
            </div>

            <UIcon name="i-lucide-plus" class="w-6 h-6 text-gray-400" />

            <div class="flex flex-col items-center gap-2">
                <div
                    class="w-16 h-16 rounded-xl bg-gray-900 flex items-center justify-center">
                    <UIcon name="i-simple-icons-github" class="w-10 h-10 text-white" />
                </div>
                <span class="text-sm text-gray-500">GitHub</span>
            </div>

            <UIcon name="i-lucide-arrow-right" class="w-6 h-6 text-gray-400" />

            <div class="flex flex-col items-center gap-2">
                <div
                    class="w-16 h-16 rounded-xl bg-primary-500 flex items-center justify-center">
                    <UIcon name="i-lucide-bot" class="w-10 h-10 text-white" />
                </div>
                <span class="text-sm text-gray-500">Castrel</span>
            </div>
        </div>

        <!-- 说明文字 -->
        <p class="text-center text-gray-600 dark:text-gray-400 max-w-md">
            When deployment fails, Castrel automatically analyzes logs, code changes,
            and generates a diagnosis report.
        </p>
    </div>
</template>

<style scoped>
.deployment-verification-flow {
    max-height: 352px;
}
</style>
