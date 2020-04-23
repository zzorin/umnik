import Vue from 'vue'

export const expertsStore = {
  state: {
    experts: [],
    expert: {}
  },
  mutations: {
    clearExpert(state) {
      Vue.set(state, 'expert', {})
    },
    setExpert(state, expert) {
      Vue.set(state, 'expert', expert)
    },
    setExperts(state, experts) {
      state.experts = experts
    },
    createExpert(state, params) {
      let { resolve, reject } = params
      Vue.http.post(`contests/${params.params.contest_id}/experts`, params.params).then(data => {
        if (data.ok) {
          resolve(data)
        }
      })
    }
  },
  actions: {
    clearExpert({ commit }) {
      commit('clearExpert')
    },
    getExperts({ commit, state }, params) {
      let { contest_id, active } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/experts?active=${active}`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setExperts', data.body)
          }
        })
      })
    },
    getExpert({ commit, state }, params) {
      let { contest_id, expert_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/experts/${expert_id}`).then(data => {
          if (data.status && data.status == 200) {
            commit('setExpert', data.body)
          }
        })
      })
    },
    createExpert({ commit }, params) {
      return new Promise((resolve, reject) => {
        commit('createExpert', { params, resolve, reject })
      })
    },
    updateExpert({ state }, params) {
      let { expert } = params
      return new Promise((resolve, reject) => {
        Vue.http.put(`contests/${expert.contest_id}/experts/${expert.id}`, params).then(data => {
          if (data.status) resolve(data.body)
        })
      })
    },
    deleteExpert({ state }, params) {
      let { expert } = params
      return new Promise((resolve, reject) => {
        Vue.http.delete(`contests/${expert.contest_id}/experts/${expert.id}`).then(data => {
          if (data.status && data.body.status == 200) resolve(data.body)
        })
      })
    }
  }
}
