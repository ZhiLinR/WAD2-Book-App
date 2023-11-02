<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Card from '@/Components/Card.vue';
import { Head, Link } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import UploadForm from '@/Components/UploadForm.vue';
import axios from 'axios';
import GoogleMapLoader from '@/Components/GoogleMapLoader.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
const BASE_URL = import.meta.env.VITE_APP_URL;
</script>

<script>
//Startup load calls
export default {
    data() {
        return {
            user_donations: [],
        }
    },
    methods: {
        getUserDonations() {
            console.log("in getUser")
            axios.get("/api/user/donations")
                .then(
                    response => {
                        this.user_donations = response.data;
                    }
                )
        }
    },
    beforeMount() {
        this.getUserDonations();
    }
};
</script>


<template>
    <Head title="Book Catalogue" />
    <AuthenticatedLayout>
        <div class="container bg-white my-5 p-5 rounded-2">
            <GoogleMapLoader>
                
            </GoogleMapLoader>
        </div>
       
    </AuthenticatedLayout>
</template>
