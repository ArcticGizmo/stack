<template>
  <div id="app">
    <BLayout></BLayout>
    <!-- <DefaultPage /> -->
    <!-- <img alt="Vue logo" src="./assets/logo.png"> -->
    <!-- <HelloWorld msg="Welcome to Your Vue.js App"/> -->
  </div>
</template>

<script>
import BLayout from './components/layout/BLayout.vue';
import DefaultPage from './components/pages/DefaultPage.vue';

export default {
  name: 'App',
  components: {
    DefaultPage,
    BLayout,
  },
};
</script>

<style>
</style>
