import Vue from 'vue'

export const criterionsStore = {
  state: {
    criterions: [],
    newCriterion: {}
  },
  mutations: {
    clearNewCriterion(state) {
      Vue.set(state, 'newCriterion', {})
    },
    setCriterions(state, criterions) {
      state.criterions = criterions
    },
    createCriterion(state, params) {
      let { resolve, reject } = params
      Vue.http.post(`contests/${params.params.contest_id}/criterions`, params.params).then(data => {
        if (data.ok) {
          resolve(data)
        }
      })
    }
  },
  actions: {
    clearNewCriterion({ commit }) {
      commit('clearNewCriterion')
    },
    getCriterions({ commit, state }, params) {
      let { contest_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/criterions`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setCriterions', data.body)
          }
        })
      })
    },
    createCriterion({ commit }, params) {
      return new Promise((resolve, reject) => {
        commit('createCriterion', { params, resolve, reject })
      })
    },
    updateCriterion({ state }, params) {
      let { criterion } = params
      return new Promise((resolve, reject) => {
        Vue.http.put(`contests/${criterion.contest_id}/criterions/${criterion.id}`, params).then(data => {
          if (data.status) resolve(data.body)
        })
      })
    },
    deleteCriterion({ state }, params) {
      let { criterion } = params
      return new Promise((resolve, reject) => {
        Vue.http.delete(`contests/${criterion.contest_id}/criterions/${criterion.id}`).then(data => {
          if (data.status && data.body.status == 200) resolve(data.body)
        })
      })
    }
  }
}
