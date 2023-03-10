import Vue from 'vue'
import Router from 'vue-router'
import store from '../store/index'

import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import Profile from '../views/Profile.vue'
import NotFound from '@/views/NotFound.vue'
import Details from '../views/Details.vue'
import Administration from '@/views/Administration.vue'
import CreateEvent from '@/views/CreateEvent.vue'
import DeleteEvent from '@/views/DeleteEvent.vue'
import UpdateEvent from '@/views/UpdateEvent.vue'
import EditTags from '@/views/EditTags.vue'

Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/administration",
      name: "administration",
      component: Administration,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/administration/profile",
      name: "profile",
      component: Profile,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/administration/createevent",
      name: "createEvent",
      component: CreateEvent,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/deleteEvent",
      name: "deleteEvent",
      component: DeleteEvent,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/updateEvent",
      name: "updateEvent",
      component: UpdateEvent,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/editTags",
      name: "editTags",
      component: EditTags,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/events/:id",
      name: "details",
      component: Details,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "*",
      name: "not-found",
      component: NotFound,
      meta: {
        requiresAuth: false
      }
    }
  ]
})

 router.beforeEach((to, from, next) => {
   const requiresAuth = to.matched.some(x => x.meta.requiresAuth);
   if (requiresAuth && store.state.token === '') {
     next("/login");
   } else {
     next();
   }
 });

export default router;
