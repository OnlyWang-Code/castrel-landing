<script setup lang="ts">
    import { ref, onMounted } from 'vue'
    import mermaid from 'mermaid'

    const rendered = ref('')

    const diagram = `
flowchart TD
    A["⚠️ Alert"] --> B["🤖 Castrel Analysis"]
    B -->|"👤 Hypothesis"| D["User Review"]
    D -->|"💬 Feedback"| B
    D -->|"✅ Confirm"| E["🎯 Report"]
`

    onMounted(async () => {
        mermaid.initialize({
            startOnLoad: false,
            theme: 'neutral',
            flowchart: {
                curve: 'basis',
                padding: 20
            }
        })
        const { svg } = await mermaid.render('incident-investigation-mermaid', diagram)
        rendered.value = svg
    })
</script>

<template>
    <div
        class="incident-investigation-flow w-full h-full flex items-center justify-center overflow-hidden">
        <div v-html="rendered" class="mermaid-container" />
    </div>
</template>

<style scoped>
.incident-investigation-flow {
    width: 100%;
    height: 100%;
    max-height: 352px;
}

.mermaid-container {
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.mermaid-container :deep(svg) {
    max-width: 100%;
    max-height: 100%;
}
</style>
