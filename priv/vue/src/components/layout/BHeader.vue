<template>
  <header class="b-header" role="banner">
    <div class="sidebar-btn">
      <BIcon class="sidebar-icon" :icon="menuIcon" :scale="0.5" @click.native="onSidebarToggle" />
    </div>
    <BIcon class="logo" :icon="beemoIcon" />
    <slot class="b-header-content"></slot>
  </header>
</template>

<script>
import BIcon from '../layout/BIcon.vue';
import BeemoIcon from '../icons/Beemo.vue';
import MenuIcon from '../icons/Menu.vue';

export default {
  name: 'BHeader',
  components: {
    BIcon,
  },
  data: () => {
    return {
      beemoIcon: BeemoIcon,
      menuIcon: MenuIcon,
    };
  },
  methods: {
    onSidebarToggle() {
      this.$emit('sidebar-toggle');
    },
  },
};
</script>

<style>
header {
  box-sizing: border-box;
  width: 100%;
  display: block;
  height: 4rem;
  background-color: var(--b-darkest);
  display: flex;
}

.b-header .b-header-content {
  margin-left: 1rem;
  margin-right: 1rem;
  display: flex;
  height: 100%;
  align-items: center;
}

.b-header .sidebar-btn {
  cursor: pointer;
  height: 4rem;
  width: 4rem;
}

.b-header .sidebar-btn .sidebar-icon {
  width: 100%;
  height: 100%;
}

.b-header .logo {
  fill: #007fff;
  height: 100%;
}

.b-header .logo svg {
  width: auto;
}
</style>