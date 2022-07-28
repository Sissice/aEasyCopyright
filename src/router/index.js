import { createRouter, createWebHashHistory } from 'vue-router'
import HomeView from '../views/Home.vue'
import WelcomeView from '../views/Welcome.vue'
import CopyrightAddView from '../components/CopyrightAdd.vue'
import CopyrightQueryView from '../components/CopyrightQuery.vue'
import CopyrightUpdateView from '../components/CopyrightUpdate.vue'
import DataFingerView from '../components/DataFinger.vue'
import UserAdminView from '../components/UserAdmin.vue'

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
    redirect: '/welcome',
    children: [
      { path: '/welcome', component: WelcomeView },
      {
    path: '/copyright/add',
    name: 'copyrightadd',
    component: CopyrightAddView
  },
  {
    path: '/copyright/query',
    name: 'copyrightquery',
    component: CopyrightQueryView
  },
  {
    path: '/copyright/update',
    name: 'copyrightupdate',
    component: CopyrightUpdateView
  },
  {
    path: '/other/datafinger',
    name: 'datafinger',
    component: DataFingerView
  },
  {
    path: '/user/admin',
    name: 'admin',
    component: UserAdminView
  },
    ]
  }
  
]

const router = createRouter({
  // mode: 'history',
  history: createWebHashHistory(),
  routes
})

export default router
