<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import LaravelLogo from '@/Components/LaravelLogo.vue';
import { Link } from '@inertiajs/vue3';
</script>
<script>
export default {
    data() {
        return {
            currentBG: "/fantasy/background/fantasy1.gif",
            backgrounds: ["/fantasy/background/fantasy1.gif", "/fantasy/background/fantasy2.gif", "/fantasy/background/fantasy3.gif"]
        }
    },
    methods: {
        changeBG: function () {
            let bg = this
            setInterval(function () {
                let index = Math.floor(Math.random() * 3)
                bg.currentBG = bg.backgrounds[index];
            }, 5000);
        }
    },
    mounted() {
        this.changeBG();
    }
};
</script>

<template>
    <div id="animatedBackground" class="min-vh-100 min-vw-100" :style="{ backgroundImage: 'url(' + this.currentBG + ')' }">
        <slot />
    </div>
</template>

<style>
#animatedBackground {
    background-color: #133758;
    transition: background-image 2s ease;
    background-repeat: repeat;
    background-size: 100%;
}
</style>
