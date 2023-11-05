<script setup>
import Checkbox from '@/Components/Checkbox.vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import LaravelLogo from '@/Components/LaravelLogo.vue';

defineProps({
    canResetPassword: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};

</script>

<template>
    <GuestLayout>
        <main>

            <Head title="Log in" />
            <div v-if="status">
                {{ status }}
            </div>
            <div class="container position-absolute top-50 start-50 translate-middle" id="loginContainer"
                style="width: 35%; min-width: 500px; ">
                <div class="card p-3 floating">
                    <div class="card-body ">
                        <div class="row m-3">
                            <div class="d-flex align-items-center justify-content-start">
                                <div class="col ">
                                    <Link>
                                    <LaravelLogo height="60px"/>
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
                            <h3>Sign in to your adventure</h3>
                        </div>
                        <div class="row">
                            <form @submit.prevent="submit">

                                <div class="row my-4 mx-1">
                                    <!-- <InputLabel for="email" value="Email" /> -->

                                    <TextInput id="email" type="email" placeholder="Email" class="form-control "
                                        v-model="form.email" required autofocus autocomplete="username" />

                                    <InputError class="m-1 text-danger" :message="form.errors.email" />
                                </div>

                                <div class="row my-4 mx-1">
                                    <!-- <InputLabel for="password" value="Password" /> -->

                                    <TextInput id="password" type="password" placeholder="Password" class="form-control "
                                        v-model="form.password" required autocomplete="current-password" />

                                    <InputError class="m-1" :message="form.errors.password" />
                                </div>
                                <div class="row my-3 mx-1">
                                    <div class="form-check">
                                        <label class="flex items-center">
                                            <Checkbox name="remember" v-model:checked="form.remember" />
                                            <span class="form-check-label" for="remember">Remember me</span>
                                        </label>
                                    </div>
                                </div>

                                <div class="row my-3 mx-1">
                                    <PrimaryButton class="btn btn-primary mb-4" :class="{ 'opacity-25': form.processing }"
                                        :disabled="form.processing">
                                        Log in
                                    </PrimaryButton>
                                </div>
                                <div class="row">
                                    <Link v-if="canResetPassword" :href="route('password.request')" class="link-secondary">
                                    Forgot your password?
                                    </Link>
                                </div>
                                <Link :href="route('register')" class="link-secondary mb-5" style="color: #393f81;">
                                    Don't have an account? Register here
                                    </Link>
                                    

                            </form>
                        </div>

                    </div>
                </div>
            </div>



        </main>

    </GuestLayout>
</template>

<style>
.card {
    background-color: rgba(255, 255, 255, 0.9) !important;
}
</style>




