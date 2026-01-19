export default defineAppConfig({
    appUrl: process.env.NUXT_PUBLIC_APP_URL || 'https://app.castrel.ai',
    header: {
        logo: {
            light: '/images/castrel_logo_v3.png',
            dark: '/images/castrel_logo_v3.png',
            alt: 'Castrel',
        },
        title: 'Castrel AI',
    },
    // 禁用 GitHub 集成，隐藏 header 和 footer 中的 GitHub 链接
    github: false,
})
