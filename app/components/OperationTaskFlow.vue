<script setup lang="ts">
    import { ref, onMounted } from 'vue'
    import mermaid from 'mermaid'

    const rendered = ref('')

    const diagram = `
flowchart LR
    subgraph P ["📋 Planning"]
        A["👤 Request"] --> B["🤖 Generate"]
        B <-->|"✏️"| C["👤 Review"]
        C --> D["📄 Runbook"]
    end

    subgraph E ["⚡ Execution"]
        D --> F["🤖 Execute"]
        F -->|"🔒"| G["👤 Confirm"]
        G --> H["✅ Done"]
        F -->|"Auto"| H
    end
`

    onMounted(async () => {
        mermaid.initialize({
            startOnLoad: false,
            theme: 'neutral',
            flowchart: {
                curve: 'basis',
                padding: 15
            }
        })
        const { svg } = await mermaid.render('operation-task-mermaid', diagram)
        rendered.value = svg
    })
</script>

<template>
    <div
        class="operation-task-flow w-full h-full flex items-center justify-center overflow-hidden">
        <div v-html="rendered" class="mermaid-container" />
    </div>
</template>

<style scoped>
.operation-task-flow {
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
