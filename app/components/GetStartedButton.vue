<script setup lang="ts">
    const appConfig = useAppConfig()
</script>

<template>
    <UButton color="neutral" size="xl" :to="appConfig.appUrl" target="_blank"
        trailing-icon="i-lucide-arrow-right">
        Try Free
    </UButton>
</template>
