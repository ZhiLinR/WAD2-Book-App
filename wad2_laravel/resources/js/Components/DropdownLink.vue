<script setup>
import { Link } from '@inertiajs/vue3';

defineProps({
    href: {
        type: String,
        required: true,
    },
    classes: {
        type: String,
        default: "nav-link",
    }
});
</script>

<template>
    <Link :href="href" :class="classes">
    <slot />
    </Link>
</template>
