<template>
  <div class="home-page">
    home page
  </div>
</template>

<script>
export default {
  name: 'HomePage',
  data: () => {
    return {
      items: [],
    };
  },
  methods: {
    add() {
      this.items.push(this.items.length + 1);
    },
  },
};
</script>

<style>
</style>