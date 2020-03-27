import Vue from 'vue'

export const criterionsStore = {
  state: {
    criterions: []
  },
  mutations: {
    setCriterions(state, criterions) {
      state.criterions = criterions
    }
  },
  actions: {
    request({ commit, state }, contest_id) {
      console.log(contest_id)
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/criterions`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setCriterions', data.body)
          }
        })
      })
    }
  }
}
