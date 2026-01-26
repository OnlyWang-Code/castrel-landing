<template>
    <div class="flex gap-16 w-full text-sm text-muted">
        <span>&copy; {{ new Date().getFullYear() }} Castrel AI</span>
        <div class="flex gap-4">
            <NuxtLink to="/docs/security/terms-of-service"
                class="hover:text-foreground transition-colors">
                Terms
            </NuxtLink>
            <NuxtLink to="/docs/security/privacy-policy"
                class="hover:text-foreground transition-colors">
                Privacy
            </NuxtLink>
        </div>
    </div>
</template>
