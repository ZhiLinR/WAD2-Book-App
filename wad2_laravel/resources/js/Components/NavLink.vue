<script setup>
import { computed } from 'vue';
import { Link } from '@inertiajs/vue3';

const props = defineProps({
    href: {
        type: String,
        required: true,
    },
    active: {
        type: Boolean,
    },
});

const classes = computed(() =>
    props.active
        ? "nav-link active"
        : "nav-link"
);
</script>

<template>
    <Link :href="href" :class="classes">
    <slot />
    </Link>
</template>
<style>
.nav-link {
    -webkit-text-stroke: 0.3px #4B4B4B;
    color: #FFF !important;
    text-shadow: 2px 2px 2.5px rgba(0, 0, 0, 0.80);
    font-family: Patrick Hand SC;
    font-size: 28px;
    font-style: normal;
    font-weight: 400;
    line-height: normal;
}
.nav-underline .nav-link.active{
    font-weight: 400;
}
</style>