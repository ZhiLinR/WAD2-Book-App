<script setup>
import { RouterLink, RouterView } from 'vue-router'

</script>
<template>
  <div id="app">
    <div class="container">
      <nav class="navigation border navbar-expand-md d-none d-md-block ">
        <ul class="nav nav-underline justify-content-end">
          <li class="nav-item">
            <router-link class="nav-link" to="/">Home</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" to="/about">Upload Book</router-link>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Book Catalogue</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">My Profile</a>
          </li>
        </ul>
      </nav>

      <router-view></router-view>
    </div>
  </div>
</template>

<style scoped></style>


