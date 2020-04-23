import Vue from 'vue'

export const nominationsStore = {
  state: {
    nominations: [],
    newNomination: {}
  },
  mutations: {
    clearNewNomination(state) {
      Vue.set(state, 'newNomination', {})
    },
    setNominations(state, nominations) {
      state.nominations = nominations
    },
    createNomination(state, params) {
      let { resolve, reject } = params
      Vue.http.post(`contests/${params.params.contest_id}/nominations`, params.params).then(data => {
        if (data.ok) {
          resolve(data.body)
        }
      })
    }
  },
  actions: {
    clearNewNomination({ commit }) {
      commit('clearNewNomination')
    },
    getNominations({ commit, state }, params) {
      let { contest_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/nominations`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setNominations', data.body)
          }
        })
      })
    },
    createNomination({ commit }, params) {
      return new Promise((resolve, reject) => {
        commit('createNomination', { params, resolve, reject })
      })
    },
    updateNomination({ state }, params) {
      let { nomination } = params
      return new Promise((resolve, reject) => {
        Vue.http.put(`contests/${nomination.contest_id}/nominations/${nomination.id}`, params).then(data => {
          if (data.status) resolve(data.body)
        })
      })
    },
    deleteNomination({ state }, params) {
      let { nomination } = params
      return new Promise((resolve, reject) => {
        Vue.http.delete(`contests/${nomination.contest_id}/nominations/${nomination.id}`).then(data => {
          if (data.status && data.body.status == 200) resolve(data.body)
        })
      })
    }
  },
  getters: {
    nominations(state) {
      return state.nominations
    }
  }
}
