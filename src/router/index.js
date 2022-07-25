import { createRouter, createWebHashHistory } from 'vue-router'
import HomeView from '../views/Home.vue'
import CopyrightAddView from '../components/CopyrightAdd.vue'
import CasinoDapp from '../components/casino-dapp.vue'

const routes = [
  // {
  //   path: '/',
  //   name: 'home',
  //   component: HomeView
  // },
  // {
  //   path: '/about',
  //   name: 'about',
  //   // route level code-splitting
  //   // this generates a separate chunk (about.[hash].js) for this route
  //   // which is lazy-loaded when the route is visited.
  //   component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  // }
  {
    path: '/',
    name: 'home',
    component: HomeView,
    redirect: '/CopyrightAdd',
    children: [
      { path: '/CopyrightAdd', component: CopyrightAddView }
    ]
  }
  // {
  //   path: '/',
  //   name: 'casino-dapp',
  //   component: CasinoDapp
  // }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
