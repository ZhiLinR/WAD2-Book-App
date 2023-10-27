<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Card from '@/Components/Card.vue';
import { Head, Link } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import UploadForm from '@/Components/UploadForm.vue';
import axios from 'axios';
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
    <UploadForm id="uploadFormModal" modalSize="modal-xl" />
    <AuthenticatedLayout>
        <div class="container bg-white my-5 p-5 rounded-2">
            <div class="row">
                <h2 class="col">
                    My Uploads
                </h2>
                <div class="col-md-2">
                    <PrimaryButton class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#uploadFormModal">
                        Create New Listing
                    </PrimaryButton>
                </div>
            </div>
            <div class="row my-5 px-3">
                <div class="container row " id="userDonations">
                    <Card v-for="donation in user_donations">

                        <template v-slot:cardTitle>
                            {{ donation.bk_name }}
                        </template>
                        <template v-slot:cardText>
                            By {{ donation.author }}
                        </template>
                    </Card>

                </div>

            </div>
        </div>
       
    </AuthenticatedLayout>
</template>
