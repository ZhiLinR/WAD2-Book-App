<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import LaravelLogo from '@/Components/LaravelLogo.vue';
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <div class="container mx-auto p-2">
        

        <div class="container-fluid m-5">
            
            <slot />
        </div>
    </div>
</template>
