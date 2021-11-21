<template>
  <div v-show="show" class="b-sidebar-wrapper">
    <transition name="slide-fade">
      <div v-if="show" class="b-sidebar">
        <BRoute
          v-for="route in routes"
          :key="route.fullPath"
          :route="route"
          :icon="route.icon"
          @select="onRouteSelect"
        />
      </div>
    </transition>

    <div class="b-sidebar-outer" @click="onOuterClick"></div>
  </div>
</template>

<script>
import BIcon from '../layout/BIcon.vue';
import BeemoIcon from '../icons/Beemo.vue';
import BRoute from './BRoute.vue';

function parseRoute(route, absPath) {
  const fullPath = absPath ? `${absPath}/${route.path}` : route.path;

  const children = (route.children || []).map(c => parseRoute(c, fullPath));

  return {
    name: route.name,
    icon: route.icon,
    fullPath,
    children,
  };
}

export default {
  name: 'BNavbar',
  props: {
    show: { type: Boolean, default: false },
  },
  components: {
    BIcon,
    BRoute,
  },
  data: () => {
    return {
      routes: [],
      icon: BeemoIcon,
    };
  },
  watch: {
    show(bool) {
      if (bool) {
        const routes = this.$router.options.routes || [];
        const route = this.$route;
        this.setRoutes(routes, route);
      }
    },
  },
  mounted() {
    const routes = this.$router.options.routes || [];
    const route = this.$route;
    this.setRoutes(routes, route);
  },
  methods: {
    setRoutes(routes, curRoute) {
      this.routes = routes.filter(r => r.path !== '*').map(r => parseRoute(r, ''));
    },
    onRouteSelect(path) {
      this.$emit('select', path);
      const curRoute = this.$route;
      if (!curRoute || curRoute.fullPath !== path) {
        this.$router.push(path);
      }
    },
    onOuterClick() {
      this.$emit('close');
    },
    onArrowClick(route) {
      route.open = !route.open;
    },
  },
};
</script>

<style>
.b-sidebar-wrapper {
  display: flex;
  position: absolute;
  width: 100vw;
  z-index: 100;
  min-height: calc(100% - 4rem);
  background-color: rgba(0, 0, 0, 0.1);
}

.b-sidebar {
  background-color: var(--b-dark);
  position: absolute;
  width: 16rem;
  height: 100%;
}

.b-sidebar-outer {
  width: 100%;
}

.b-sidebar .outer-click {
  background: purple;
  position: fixed;
  width: 100vw;
  height: 100vh;
}

.slide-fade-enter-active {
  transition: all 0.2s ease;
}

.slide-fade-leave-active {
  transition: all 0.2s ease;
}
.slide-fade-enter,
.slide-fade-leave-to {
  transform: translateX(-100%);
  opacity: 0;
}
</style>