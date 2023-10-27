<script setup>
import { ref } from 'vue';
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import Dropdown from '@/Components/Dropdown.vue';
import DropdownLink from '@/Components/DropdownLink.vue';
import NavLink from '@/Components/NavLink.vue';
import ResponsiveNavLink from '@/Components/ResponsiveNavLink.vue';
import { Link } from '@inertiajs/vue3';

const showingNavigationDropdown = ref(false);
</script>

<template>
        <div class="container-fluid m-0 p-0 ">
            <nav class="navbar navbar-expand-md w-auto p-3" style="background-color: #e3f2fd;">
                <div class="container-fluid d-flex justify-content-between">
                    <div class="p-2 flex-grow-1 bd-highlight">
                        <Link :href="route('dashboard')" class="navbar-brand">
                        <!-- <ApplicationLogo /> -->
                        BookQuest
                        </Link>
                    </div>
                    <div class="collapse navbar-collapse justify-content-end px-10">
                        <ul class="navbar-nav w-auto nav-underline">
                            <li class="nav-item">
                                <NavLink :href="route('dashboard')" :active="route().current('dashboard')">
                                    Home
                                </NavLink>
                            </li>
                            <li class="nav-item">
                                <NavLink :href="route('catalogue')" :active="route().current('catalogue')">
                                    Book Catalogue
                                </NavLink>
                            </li>
                            <li class="nav-item">
                                <NavLink :href="route('upload-books')" :active="route().current('upload-books')">
                                    Upload Books
                                </NavLink>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    {{ $page.props.auth.user.name }}
                                </a>
                                <ul class="dropdown-menu">
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
                </div>
            </nav>

            <!-- Page Heading -->
            <header class="bg-white shadow" v-if="$slots.header">
                <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                    <slot name="header" />
                </div>
            </header>

            <!-- Page Content -->
            <main>
                <slot />
            </main>
        </div>
    
</template>
