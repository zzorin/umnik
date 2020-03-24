import Vue from 'vue'

export const contestsStore = {
  state: {
    contests: []
  },
  mutations: {
    setContests(state, contests) {
      state.contests = contests
    }
  },
  actions: {
    request({ commit, state }) {
      return new Promise((resolve, reject) => {
        Vue.http.get(`api/v1/contests/all`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setContests', data.body)
          }
        })
      })
    }
  }
}
