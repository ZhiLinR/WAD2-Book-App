<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import LaravelLogo from '@/Components/LaravelLogo.vue';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>

        <Head title="Register" />
        <div class="container position-absolute top-50 start-50 translate-middle" id="loginContainer"
            style="width: 35%; min-width: 500px; ">
            <div class="card p-3 floating">
                <div class="card-body">
                    <div class="row m-3">
                        <div class="d-flex align-items-center justify-content-start">
                            <div class="col ">
                                <Link>
                                <LaravelLogo height="60px" />
                                </Link>
                                With Laravel
                            </div>
                            <div class="col text-center">
                                <ApplicationLogo />
                                BookQuest
                            </div>
                        </div>
                    </div>
                    <div class="row text-center">
                        <h3>Start Your Adventure With Us Today</h3>
                    </div>
                    <div class="row">
                        <form @submit.prevent="submit">
                            <div class="row my-2 mx-1">
                                <!-- <InputLabel for="email" value="Email" /> -->

                                <TextInput id="email" type="email" placeholder="Email" class="form-control" v-model="form.email" required
                                    autocomplete="username" />

                                <InputError class="form-text" :message="form.errors.email" />
                                <!-- <InputLabel for="name" value="Name" /> -->
                            </div>
                            <div class="row my-2 mx-1">
                                <TextInput id="name" type="text" placeholder="Name" class="form-control" v-model="form.name" required
                                    autofocus autocomplete="name" />
                                    <div class="form-text">This name will be displayed on your profile.</div>
                                <InputError class="form-text" :message="form.errors.name" />
                            </div>
                            <div class="row my-2 mx-1">
<!--                                 <InputLabel for="password" value="Password" />
 -->
                                <TextInput id="password" type="password" placeholder="Password" class="form-control" v-model="form.password"
                                    required autocomplete="new-password" />

                                <InputError class="form-text" :message="form.errors.password" />
                            </div>

                            <div class="row my-2 mx-1">
<!--                                 <InputLabel for="password_confirmation" value="Confirm Password" />
 -->
                                <TextInput id="password_confirmation" placeholder="Confirm Password" type="password" class="form-control"
                                    v-model="form.password_confirmation" required autocomplete="new-password" />

                                <InputError class="form-text" :message="form.errors.password_confirmation" />
                            </div>

                            <div class="row my-2 mx-1">
                                <PrimaryButton class="btn btn-primary"  :class="{ 'opacity-25': form.processing }"
                                    :disabled="form.processing">
                                    Register
                                </PrimaryButton>
                                <Link :href="route('login')" class="underline form-text">
                                Already registered?
                                </Link>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>


    </GuestLayout>
</template>

<style>
.card {
    background-color: rgba(255, 255, 255, 0.9) !important;
}
</style>