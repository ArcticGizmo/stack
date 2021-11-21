<template>
  <div class="b-layout">
    <BHeader @sidebar-toggle="onSidebarToggle"></BHeader>
    <BSidebar :show="showSidebar" @select="onRouteSelect" @close="onSidebarClose"></BSidebar>
    <router-view class="page-view"></router-view>
  </div>
</template>

<script>
import vue from 'vue';
import BHeader from './BHeader.vue';
import BSidebar from './BSidebar.vue';
import BFooter from './BFooter.vue';

export default {
  name: 'BLayout',
  components: {
    BHeader,
    BSidebar,
    BFooter,
  },
  data: () => {
    return {
      showSidebar: false,
    };
  },
  methods: {
    onSidebarToggle() {
      this.showSidebar = !this.showSidebar;
    },
    onRouteSelect() {
      this.showSidebar = false;
    },
    onSidebarClose() {
      this.showSidebar = false;
    },
  },
};
</script>

<style>
:root {
  --dark: #2c3531;
  --green: #116466;
  --cream: #d9b08c;
  --brown: #ffcb9a;
  --blue: #d1e9e2;

  --b-normal: #253037;
  --b-darkish: #1f282e;
  --b-dark: #1e262c;
  --b-darkest: #1b232a;

  --c-normal: #808892;
  --c-light: #9fa7b1;
  --c-lightest: #f1f2f3;
}

body {
  margin: 0;
  color: var(--c-normal);
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

div {
  box-sizing: border-box;
}

.b-btn {
  cursor: pointer;
  background-color: #bebebe;
  outline: none;
}

.b-btn:hover {
  opacity: 0.75;
}

.page-view {
  background-color: var(--b-normal);
  min-height: calc(100vh - 4rem);
}
</style>