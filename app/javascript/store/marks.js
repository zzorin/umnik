import Vue from 'vue'
export const marksStore = {
  state: {
  },
  mutations: {
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
  }
}
