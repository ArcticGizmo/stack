<template>
  <div class="b-icon">
    <component
      v-if="icon"
      class="b-icon-svg"
      :is="icon"
      :viewBox="computedViewBox"
      :preserveAspectRatio="computedAspectRatio"
      :transform="transform"
    />
  </div>
</template>

<script>
function parseViewBox(value) {
  if (!isNaN(value)) {
    return [0, 0, value, value];
  }

  if (value.length === 2) {
    return [0, 0, value[0], value[1]];
  }

  return value;
}

function parseScale(value) {
  if (!isNaN(value)) {
    return { x: value, y: value };
  }

  return {
    x: value.x || 1,
    y: value.y || 1,
  };
}

const ASPECT_RATIOS = {
  fill: 'none',
  left: 'xMinYMid meet',
  top: 'xMidYMin meet',
  right: 'xMaxYMid meet',
  bottom: 'xMidYMax meet',
  center: 'xMidYMid meet',
};

export default {
  name: 'BIcon',
  props: {
    icon: { type: Object, default: null },
    viewBox: { type: [Array, Number], default: null },
    rotation: { type: Number, default: null },
    reflectX: { type: Boolean, default: false },
    reflectY: { type: Boolean, default: false },
    scale: { type: [Number, Object], default: 1 },
    aspectRatio: { type: String, default: 'center' },
  },
  computed: {
    computedViewBox() {
      const icon = this.icon || {};
      return parseViewBox(this.viewBox || icon.viewBox);
    },
    computedScale() {
      const scale = parseScale(this.scale);

      const xMod = this.reflectX ? -1 : 1;
      const yMod = this.reflectY ? -1 : 1;

      return {
        x: scale.x * xMod,
        y: scale.y * yMod,
      };
    },
    computedRotation() {
      const icon = this.icon || {};
      return this.rotation != null ? this.rotation : icon.rotation;
    },
    computedAspectRatio() {
      return ASPECT_RATIOS[this.aspectRatio] || this.aspectRatio;
    },
    transform() {
      const rotation = `rotate(${this.computedRotation})`;
      const scale = `scale(${this.computedScale.x} ${this.computedScale.y})`;
      return [rotation, scale];
      s;
    },
  },
};
</script>

<style>
.b-icon {
  height: 2rem;
  width: 2rem;
  transform-origin: 50% 50%;
}

.b-icon-svg {
  height: 100%;
  width: 100%;
}
</style>