<script setup>
import { ref } from 'vue';
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import Dropdown from '@/Components/Dropdown.vue';
import DropdownLink from '@/Components/DropdownLink.vue';
import NavLink from '@/Components/NavLink.vue';
import ResponsiveNavLink from '@/Components/ResponsiveNavLink.vue';
import { Link } from '@inertiajs/vue3';
import AnimatedBackground from '@/Layouts/AnimatedBackground.vue';
const showingNavigationDropdown = ref(false);
</script>

<script>
export default {
    data() {
        return {
            contentTrigger: false
        }
    },
    mounted() {
        this.contentTrigger = true;
    }
}
</script>

<template>
    <AnimatedBackground>
        <div>
            <nav class="navbar navbar-light navbar-expand-md" id="topNav">
                <div class="row align-items-center justify-content-between">
                    <div class="col p-2 bd-highlight">
                        <NavLink :href="route('homepage')" class="navbar-brand">
                            <ApplicationLogo />
                            BookQuest
                        </NavLink>
                    </div>
                    <div class="col-2">
                        <button class="navbar-toggler text-light" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <!-- <span class="navbar-toggler-icon text-light" ></span> -->
                            <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor"
                                class="bi bi-list" viewBox="0 0 16 16">
                                <path fill-rule="evenodd"
                                    d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z" />
                            </svg>
                        </button>
                    </div>

                </div>
                <div id="navbarNav" class="collapse navbar-collapse justify-content-end px-10">
                    <ul class="navbar-nav w-auto nav-underline">
                        <li class="nav-item">
                            <NavLink :href="route('homepage')" :active="route().current('homepage')">
                                Home
                            </NavLink>
                        </li>
                        <li class="nav-item">
                            <NavLink :href="route('catalogue')" :active="route().current('catalogue')">
                                Book Catalogue
                            </NavLink>
                        </li>
                        <li class="nav-item">
                            <NavLink :href="route('book-drive')" :active="route().current('book-drive')">
                                Donation Drive
                            </NavLink>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                aria-expanded="false">
                                {{ $page.props.auth.user.name }}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <Link class="dropdown-item" :href="route('profile.edit')"> Profile </Link>
                                </li>
                                <li>
                                    <Link class="dropdown-item" :href="route('logout')" method="post" as="button">
                                    Log Out
                                    </Link>
                                </li>

                            </ul>
                        </li>

                    </ul>
                </div>

            </nav>
            <!-- Page Content -->

            <main>
                <slot />
            </main>
        </div>


    </AnimatedBackground>
</template>

<style>
.navbar-toggler-icon {
    width: 0.5em;
    height: 0.5em;
}</style>
