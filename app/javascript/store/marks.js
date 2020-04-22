import Vue from 'vue'
export const marksStore = {
  state: {
  },
  mutations: {
    createMark(state, params) {
      let { resolve, reject } = params
      let { contest_id, expert_id, mark } = params.params
      Vue.http.post(`contests/${contest_id}/experts/${expert_id}/marks`, mark).then(data => {
        if (data.ok) {
          resolve(data)
        }
      })
    }
  },
  actions: {
    getMarks({ commit, state }, params) {
      let { contest_id, participant_id, expert_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/experts/${expert_id}/marks/by_participant?participant_id=${participant_id}`).then(data => {
            resolve(data)
        })
      })
    },
    getAllMarks({ commit, state }, params) {
      let { contest_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/marks`).then(data => {
            resolve(data)
        })
      })
    },
    createMark({ commit }, params) {
      return new Promise((resolve, reject) => {
        commit('createMark', { params, resolve, reject })
      })
    },
    updateMark({ state }, params) {
      let { contest_id, expert_id, mark } = params
      return new Promise((resolve, reject) => {
        Vue.http.put(`contests/${contest_id}/experts/${expert_id}/marks/${mark.id}`, mark).then(data => {
          if (data.status) resolve(data.body)
        })
      })
    },
  }
}
