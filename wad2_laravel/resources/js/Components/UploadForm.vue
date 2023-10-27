<script setup>
import Checkbox from '@/Components/Checkbox.vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import NavLink from '@/Components/NavLink.vue';
import Modal from '@/Components/Modal.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import LaravelLogo from '@/Components/LaravelLogo.vue';

defineProps({
    modalSize: {
        type: String,
        default: 'button',
    },
})
const form = useForm({
    bookName: '',
    category: '',
    author: '',
    description: ''
});

const submit = () => {
    form.post(route('donations.postByUser'), {
        onSuccess: () => {
            
         },
    });
};
</script>

<script>
//Startup load calls
export default {
    data() {
        return {
            showModal: false,
            categories: [],
            authors: []
        }
    },
    methods: {
        getCategories() {
            axios.get("/api/helpers/categories")
                .then(
                    response => {
                        /* console.log(typeof response.data);
                        console.log(response.data); */
                        this.categories = response.data;
                    }
                )
        },
        getAuthors() {
            axios.get("/api/helpers/authors")
                .then(
                    response => {
                        this.authors = response.data;
                    }
                )
        },
    },
    beforeMount() {
        this.getCategories();
        this.getAuthors();
    }
};
</script>

<template>
    <div class="modal fade" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog" :class="modalSize">
            <div class="modal-content">
                <div class="container col " id="userDonations">
                    <form @submit.prevent="submit">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                Donate a book
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row my-4 mx-1">
                                <InputLabel for="bookName" value="Book Title" />
                                <div class="col-md-6">
                                    <TextInput id="bookName" type="text" placeholder="Book Name" class="form-control "
                                        v-model="form.bookName" required autofocus />
                                    <InputError class="m-1 text-danger" :message="form.errors.bookName" />
                                </div>

                            </div>

                            <div class="row my-4 mx-1">
                                <div class="col-md-6">
                                    <InputLabel for="authorDatalist" value="Author" />
                                    <!-- Datalist Option -->
                                    <input class="form-control" list="authorOptions" id="authorDatalist"
                                        placeholder="Type to search for an author..." v-model="form.author">
                                    <datalist id="authorOptions">
                                        <option v-for="author in this.authors" :value="author.author">{{ author.author }}
                                        </option>
                                    </datalist>
                                </div>
                                <div class="col-md-6">
                                    <InputLabel for="categoryOptions" value="Category" />
                                    <!-- Datalist Option -->
                                    <!-- <input class="form-control" list="categoryOptions" id="categoryDatalist"
                                        placeholder="Type to search for a category..." v-model="form.category"> -->
                                    <!-- <datalist id="categoryOptions">
                                        <option v-for="donation in this.categories" :value="donation.category">{{
                                            donation.category
                                        }}</option>
                                    </datalist> -->

                                    <select class="form-select" id="categoryOptions">
                                        <option v-for="donation in this.categories" :value="donation.category">{{
                                            donation.category
                                        }}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row my-3 mx-1">
                                <div class="mb-3">
                                    <label for="description" class="form-label">Book Description</label>
                                    <textarea class="form-control" id="description" rows="3"
                                        v-model="form.description"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <PrimaryButton class="btn btn-primary" :class="{ 'opacity-25': form.processing }"
                                :disabled="form.processing" data-bs-dismiss="modal">
                                Submit
                            </PrimaryButton>
                        </div>


                    </form>
                </div>
            </div>
        </div>
    </div>
</template>