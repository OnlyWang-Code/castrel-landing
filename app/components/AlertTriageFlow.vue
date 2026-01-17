<script setup lang="ts">
    import { ref, onMounted, watch } from 'vue'
    import mermaid from 'mermaid'

    const mermaidRef = ref<HTMLElement | null>(null)
    const rendered = ref('')

    const diagram = `
flowchart TD
    A["🔥 Prometheus"] -->|Alert| S["💬 Slack"]
    B["📟 PagerDuty"] -->|Alert| S
    C["☁️ CloudWatch"] -->|Alert| S
    S -->|Notify| D["🤖 Castrel"]
    D -->|Triage & Response| S

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
        const { svg } = await mermaid.render('alert-triage-mermaid', diagram)
        rendered.value = svg
    })
</script>

<template>
    <div
        class="alert-triage-flow w-full h-full flex items-center justify-center overflow-hidden">
        <div v-html="rendered" class="mermaid-container" />
    </div>
</template>

<style scoped>
.alert-triage-flow {
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
