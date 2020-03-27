import Vue from 'vue'

export const participantsStore = {
  state: {
    participants: []
  },
  mutations: {
    setParticipants(state, participants) {
      state.participants = participants
    }
  },
  actions: {
    request({ commit, state }, contest_id) {
      console.log(contest_id)
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/participants`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setParticipants', data.body)
          }
        })
      })
    }
  }
}
