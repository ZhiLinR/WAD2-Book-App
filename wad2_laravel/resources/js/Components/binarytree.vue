<template>
    <div>
      <span @click="toggleChildren">{{ data.head }}</span>
      <ul v-if="isExpanded">
        <binary-tree-node v-if="data.left" :data="data.left"></binary-tree-node>
        <binary-tree-node v-if="data.right" :data="data.right"></binary-tree-node>
      </ul>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      data: Object,
    },
    data() {
      return {
        isExpanded: false,
      };
    },
    methods: {
      toggleChildren() {
        this.isExpanded = !this.isExpanded;
      },
    },
  };
  </script>
  