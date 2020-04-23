import Vue from 'vue'

export const permissionsStore = {
  state: {
    available_roles: {},
    permissions: {}
  },
  mutations: {
    getAvailableRoles(state) {
      Vue.http.get('permissions/available_roles').then(data => {
        if (data.ok) Vue.set(state, 'available_roles', data.body)
      })
    },
    setPermissions(state, permissions) {
      state.permissions = permissions
    },
    createPermission(state, params) {
      let { resolve, reject } = params
      Vue.http.post('/permissions', params.params).then(data => {
        if (data.ok) {
          resolve(data.body)
        }
      })
    }
  },
  actions: {
    getAvailableRoles({ commit }) {
      commit('getAvailableRoles')
    },
    getPermissions({ commit, state }) {
      return new Promise((resolve, reject) => {
        Vue.http.get(`/permissions`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setPermissions', data.body)
          }
        })
      })
    },
    createPermission({ commit }, params) {
      console.log(params)
      return new Promise((resolve, reject) => {
        commit('createPermission', { params, resolve, reject })
      })
    },
    deletePermission({ state }, params) {
      let { permission } = params
      return new Promise((resolve, reject) => {
        Vue.http.delete(`permissions/${permission.id}`).then(data => {
          if (data.status && data.body.status == 200) resolve(data.body)
        })
      })
    }
  }
}
