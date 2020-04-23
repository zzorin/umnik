import Vue from 'vue'

export const contestsStore = {
  state: {
    newContest: {},
    currentContest: {},
    contests: []
  },
  mutations: {
    clearNewContest(state) {
      Vue.set(state, 'newContest', {})
    },
    setContests(state, contests) {
      state.contests = contests
    },
    setCurrentContest(state, params) {
      let { contest } = params
      state.currentContest = contest
    },
    createContest(state, params) {
      let { resolve, reject } = params
      Vue.http.post('/contests', params.params).then(data => {
        if (data.ok) {
          resolve(data.body)
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
    getContest({ commit, state }, params) {
      let { id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${id}`, params).then(data => {
          if (data.status && data.status == 200) {
            commit('setCurrentContest', data.body)
          }
        })
      })
    },
    createContest({ commit }, params) {
      return new Promise((resolve, reject) => {
        commit('createContest', { params, resolve, reject })
      })
    },
    updateContest({ state }, params) {
      let { contest } = params
      return new Promise((resolve, reject) => {
        Vue.http.put(`contests/${contest.id}`, params).then(data => {
          if (data.status) resolve(data.body)
        })
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
  },
  getters: {
    currentContest(state) {
      return state.currentContest
    }
  }
}
