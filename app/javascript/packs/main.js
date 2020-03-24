import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import Vuex from 'vuex'
import baseStore from 'store/base'
import { routes } from 'routes/index'


Vue.use(VueRouter)
Vue.use(VueResource)
Vue.use(Vuex)


const router = new VueRouter({
  routes
})

document.addEventListener('DOMContentLoaded', () => {
  const store = new Vuex.Store(baseStore)
  const app = new Vue({
    store,
    router
  }).$mount('#app')
})
