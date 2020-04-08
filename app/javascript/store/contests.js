import Vue from 'vue'

export const contestsStore = {
  state: {
    newContest: {},
    contests: []
  },
  mutations: {
    clearNewContest(state) {
      Vue.set(state, 'newContest', {})
    },
    setContests(state, contests) {
      state.contests = contests
    },
    createContest(state, params) {
      let { resolve, reject } = params
      Vue.http.post('/contests', params.params).then(data => {
        if (data.ok) {
          resolve(data)
        }
      })
    }
  },
  actions: {
    clearNewContest({ commit }) {
      commit('clearNewContest')
    },
    getContests({ commit, state }) {
      return new Promise((resolve, reject) => {
        Vue.http.get(`/contests`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setContests', data.body)
          }
        })
      })
    },
    createContest({ commit }, params) {
      return new Promise((resolve, reject) => {
        commit('createContest', { params, resolve, reject })
      })
    },
    deleteContest({ state }, params) {
      let { contest } = params
      return new Promise((resolve, reject) => {
        Vue.http.delete(`contests/${contest.id}`).then(data => {
          if (data.status && data.body.status == 200) resolve(data.body)
        })
      })
    }
  }
}
