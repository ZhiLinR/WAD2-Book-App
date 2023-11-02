<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import LaravelLogo from '@/Components/LaravelLogo.vue';
import { Link } from '@inertiajs/vue3';
import AnimatedBackground from '@/Layouts/AnimatedBackground.vue';
</script>
<template>
    <AnimatedBackground>
        <slot />
    </AnimatedBackground>
</template>
