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
            <video id="background-video" autoplay loop muted poster>
                <source src="../../../assets/space.station.mp4" type="video/mp4">
            </video>
            <div class="card w-75 mx-auto">
                <div class="row">
                    <div class="col-md-6 d-lg-block d-none">
                        <img class="rocket launch"
                            src="https://cdn4.iconfinder.com/data/icons/whsr-january-flaticon-set/512/rocket.png">
                    </div>
                    <div class="col-sm-6 d-flex align-items-center">
                        <div class="card-body">
                            <div class="row m-3">
                                <div class="d-flex justify-content-start">
                                    <div class="col">
                                        <Link>
                                        <LaravelLogo />
                                        </Link>
                                    </div>
                                    <div class="col">
                                        <ApplicationLogo />
                                    </div>
                                </div>
                            </div>
                            <div class="row m-2">
                                <h5>Sign into your account</h5>
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

                                        <TextInput id="password" type="password" placeholder="Password"
                                            class="form-control " v-model="form.password" required
                                            autocomplete="current-password" />

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
                                        <PrimaryButton class="btn btn-light mb-4" :class="{ 'opacity-25': form.processing }"
                                            :disabled="form.processing">
                                            Log in
                                        </PrimaryButton>
                                    </div>
                                    <div class="row">
                                        <Link v-if="canResetPassword" :href="route('password.request')"
                                            class="link-secondary">
                                        Forgot your password?
                                        </Link>
                                    </div>

                                    <p class="mb-5" style="color: #393f81;">Don't have an account? <a href="register.html"
                                            style="color: #393f81;">Register here</a></p>

                                </form>
                            </div>

                        </div>
                    </div>
                </div>
            </div>


        </main>

    </GuestLayout>
</template>

<style>
#background-video {
    height: 100vh;
    width: 100vw;
    object-fit: cover;
    position: fixed;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    z-index: -1;
    opacity: 40%;
}

.rocket {
    position: relative;
    bottom: -600px;
    animation: fly 10s .5s ease-in;
}

@keyframes fly {
    0% {
        bottom: -600px;
    }

    100% {
        bottom: 100%;
    }
}</style>
