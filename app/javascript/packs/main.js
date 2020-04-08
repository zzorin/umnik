import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import Vuex from 'vuex'
import Notifications from 'vue-notification'
import baseStore from 'store/base'
import { routes } from 'routes/index'
import interceptorsSetup from 'interceptors'


Vue.use(VueRouter)
Vue.use(VueResource)
Vue.use(Vuex)
Vue.use(Notifications)

interceptorsSetup()


const router = new VueRouter({
  routes
})

document.addEventListener('DOMContentLoaded', () => {
  const store = new Vuex.Store(baseStore)
  const app = new Vue({
    store,
    router,
    mounted() {
      this.$store.dispatch('common/setAuthenticityToken')
    }
  }).$mount('#app')
})
