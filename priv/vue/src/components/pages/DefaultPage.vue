<template>
  <div class="default">
    <button @click="onClick">Get api</button>
    <pre>{{ response }}</pre>
  </div>
</template>

<script>
export default {
  name: 'DefaultPage',
  data: () => {
    return {
      response: null,
    };
  },
  methods: {
    onClick() {
      this.$api
        .get('public/hello')
        .then(resp => {
          this.response = resp;
        })
        .catch(error => {
          this.response = error;
        });
    },
  },
};
</script>