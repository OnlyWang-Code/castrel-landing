<script setup lang="ts">
</script>

<template>
    <img src="/images/tasks.png" alt="Task Execution" class="task-image" />
</template>

<style scoped>
.task-image {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: right top;
    transform: perspective(1000px) rotateY(-12deg) rotateX(2deg) scale(1.3);
    transform-origin: right center;
}
</style>
