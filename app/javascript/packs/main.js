import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import Vuex from 'vuex'
import Notifications from 'vue-notification'
import Autocomplete from 'vuejs-auto-complete'
import Datepicker from 'vuejs-datepicker'
import baseStore from 'store/base'
import { routes } from 'routes/index'
import interceptorsSetup from 'interceptors'


Vue.use(VueRouter)
Vue.use(VueResource)
Vue.use(Vuex)
Vue.use(Notifications)

Vue.component('autocomplete', Autocomplete)
Vue.component('datepicker', Datepicker)

interceptorsSetup()

document.addEventListener('DOMContentLoaded', () => {
  const router = new VueRouter({
    routes
  })
  const store = new Vuex.Store(baseStore)
  const app = new Vue({
    store,
    router,
    methods: {
      initParams(params) {
        console.log(router)
        console.log(params)
        this.$store.dispatch('common/setUser', params.user)
        this.$store.dispatch('common/setAccessRules', params.access_rules)
      }
    },
    mounted() {
      this.$store.dispatch('common/setAuthenticityToken')
    }
  }).$mount('#app')
})
