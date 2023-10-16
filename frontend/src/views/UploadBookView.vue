<script setup>
import axios from 'axios'
import.meta.env.BASE_URL
</script>


<script>
//Startup load calls
export default {
  data() {
    return {
      url: "http://localhost:8000/api/sample",
      name: 'Apples',
      message: 'I like apples',
      button: "btn",
      theme: "btn-primary",
      type: "d-block",
      center: "mx-auto",
    }
  },
  methods: {
    getUser() {
      console.log("in getUser")
      axios.get(this.url)
        .then(
          response => {
            console.log(response.data[0]);
            this.message = response.data[0]["book_name"];
          }
        )
    }
  }
};
</script>


<template>
  <div id="app">
    <h2>{{ name }}</h2>
    <p>{{ message }}</p>
    <button v-bind:class="[button, theme, type, center]" @click="getUser" class="m-2">Get Random User</button>
  </div>
</template>

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
