import Vue from 'vue';
import VueRouter from 'vue-router';

// Pages
import DefaultPage from '@/components/pages/DefaultPage.vue';

Vue.use(VueRouter);

const ROUTES = [
  { path: '*', redirect: '/default_path' },
  { name: 'Home', path: '/home', component: DefaultPage },
];

export function createRouter() {
  return new VueRouter({ routes: ROUTES });
}
