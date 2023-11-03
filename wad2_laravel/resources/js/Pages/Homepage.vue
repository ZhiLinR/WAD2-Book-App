<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import GoogleMapLoader from '@/Components/GoogleMapLoader.vue';
import { Head } from '@inertiajs/vue3';
import { Link } from '@inertiajs/vue3';
</script>

<template>

        <AuthenticatedLayout>
            <div class="position-absolute top-50 start-50 translate-middle">
                <Link :href="route('dashboard')" role="button" id="btn_openSkillTree"
                    class="btn floating ">
                    <span> 
                        Continue Your Adventure
                    </span>
                </Link>
            </div>
     
        </AuthenticatedLayout>

</template>

<style>
#btn_openSkillTree {
    --bs-btn-border-radius: 10rem !important;
    --bs-btn-font-size: 4vw;
    -webkit-text-stroke: 0.01rem #4B4B4B;
    color: white;
    background-color: rgba(255, 255, 255, 0.5);
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.50);
    font-style: normal;
    font-weight: 400;
    line-height: normal;
    padding: 5px 30px ;
    box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25) !important;
}
</style>
