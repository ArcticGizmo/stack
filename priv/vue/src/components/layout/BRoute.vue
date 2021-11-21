<template>
  <div class="b-route">
    <div class="header" @click="onHeaderClick">
      <div class="route-icon">
        <BIcon :icon="icon" />
      </div>
      <div class="name">{{ route.name }}</div>
      <div class="arrow-icon">
        <BIcon v-if="hasChildren" :icon="chevron" :scale="0.65" :rotation="open ? 0 : 180" />
      </div>
    </div>
    <div ref="children" :style="expandHeight" class="children">
      <BRoute
        v-for="child in route.children"
        :key="child.fullPath"
        :route="child"
        :icon="child.icon"
        :isChild="true"
        @open="onOpen"
        @close="onClose"
        @select="$emit('select', $event)"
      />
    </div>
  </div>
</template>

<script>
import BIcon from './BIcon.vue';
import DefaultIcon from '../icons/Line.vue';
import ChevronIcon from '../icons/Chevron.vue';

export default {
  name: 'BRoute',
  components: {
    BIcon,
  },
  props: {
    route: { type: Object, required: true },
    icon: { type: Object, default: () => DefaultIcon },
    isChild: { type: Boolean, default: false },
  },
  data: () => {
    return {
      chevron: ChevronIcon,
      open: false,
      maxHeight: 0,
    };
  },
  computed: {
    hasChildren() {
      return (this.route.children || []).length > 0;
    },
    childHeightStyle() {
      const height = this.open ? '2rem' : 0;
      return `max-height: ${height}`;
    },
    expandHeight() {
      return `max-height: ${this.maxHeight}px`;
    },
  },
  methods: {
    onHeaderClick() {
      if (!this.hasChildren) {
        this.$emit('select', this.route.fullPath);
      } else {
        this.toggleOpen();
      }
    },
    toggleOpen() {
      if (this.open) {
        this.open = false;
        this.$emit('close', this.maxHeight);
        this.maxHeight = 0;
      } else {
        this.open = true;
        this.maxHeight = this.$refs.children.scrollHeight;
        this.$emit('open', this.maxHeight);
      }
    },
    onOpen(height) {
      if (this.isChild) {
        this.$emit('open', height);
      } else {
        this.maxHeight += height;
      }
    },
    onClose(height) {
      if (this.isChild) {
        this.$emit('close', height);
      } else {
        this.maxHeight -= height;
      }
    },
  },
};
</script>

<style>
.b-route {
  min-height: 2rem;
}

.b-route .header {
  cursor: pointer;
  user-select: none;
  display: flex;
  height: 100%;
  width: 100%;
}

.b-route .header:hover {
  background-color: rgba(255, 255, 255, 0.068);
}

.b-route .route-icon {
  width: 3rem;
}

.b-route .name {
  padding-left: 0.5rem;
  line-height: 2rem;
  width: 100%;
}

.b-route .arrow-icon {
  width: 2rem;
  height: 2rem;
  /* padding: 10px; */
}

.b-route .arrow-icon .b-icon {
  height: 100%;
  /* height: 1rem; */
  /* padding: 5px; */
}

.b-route .arrow-icon .b-icon {
  transition: transform 0.5s ease-in-out;
}

.b-route .children {
  overflow: hidden;
  transition: max-height 0.5s ease-in-out;
}

.b-route .children .b-route {
  padding-left: 2rem;
}
</style>