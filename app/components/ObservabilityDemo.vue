<script setup lang="ts">
</script>

<template>
    <div class="workflow-demo relative w-[440px] h-[320px]">
        <!-- User 节点 -->
        <div class="node node-default absolute left-[40px] top-[140px]">
            User
        </div>

        <!-- Agent 节点 -->
        <div class="node node-primary absolute left-[150px] top-[60px]">
            Agent
        </div>

        <!-- Search 节点 -->
        <div class="node node-default absolute left-[110px] top-[220px]">
            Search
        </div>

        <!-- Database 节点 -->
        <div class="node node-default absolute left-[250px] top-[220px]">
            Database
        </div>

        <!-- Sub Agent 节点 -->
        <div class="node node-sub absolute left-[320px] top-[130px]">
            Sub Agent
        </div>

        <!-- 连接线: User -> Agent -->
        <div
            class="line line-solid absolute left-[100px] top-[130px] w-[70px] -rotate-[35deg] origin-left">
        </div>

        <!-- 连接线: Agent -> Search -->
        <div
            class="line line-dashed absolute left-[180px] top-[100px] w-[90px] rotate-[60deg] origin-left">
        </div>

        <!-- 连接线: Agent -> Database -->
        <div
            class="line line-dashed absolute left-[220px] top-[100px] w-[100px] rotate-[50deg] origin-left">
        </div>

        <!-- 连接线: Agent -> Sub Agent -->
        <div
            class="line line-dashed absolute left-[250px] top-[80px] w-[100px] rotate-[25deg] origin-left">
        </div>
    </div>
</template>

<style scoped>
.node {
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 500;
    z-index: 10;
}

.node-default {
    width: 80px;
    height: 36px;
    background: white;
    border: 1.5px solid #e2e8f0;
    color: #404040;
}

.node-primary {
    width: 100px;
    height: 44px;
    background: #eff6ff;
    border: 2px solid #93c5fd;
    color: #1d4ed8;
}

.node-sub {
    width: 90px;
    height: 40px;
    background: #fefce8;
    border: 1.5px solid #fde047;
    color: #a16207;
}

.line {
    height: 2px;
    background: #cbd5e1;
}

.line-solid {
    background: #cbd5e1;
}

.line-dashed {
    background: repeating-linear-gradient(90deg,
            #cbd5e1 0px,
            #cbd5e1 4px,
            transparent 4px,
            transparent 8px);
}
</style>
