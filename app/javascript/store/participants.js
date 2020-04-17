import Vue from 'vue'

export const participantsStore = {
  state: {
    participants: [],
    participant: {}
  },
  mutations: {
    clearParticipant(state) {
      Vue.set(state, 'participant', {})
    },
    clearParticipants(state) {
      Vue.set(state, 'participants', [])
    },
    setParticipant(state, participant) {
      Vue.set(state, 'participant', participant)
    },
    setParticipants(state, participants) {
      state.participants = participants
    },
    createParticipant(state, params) {
      let { resolve, reject } = params
      Vue.http.post(`contests/${params.params.contest_id}/participants`, params.params).then(data => {
        if (data.ok) {
          resolve(data)
        }
      })
    }
  },
  actions: {
    clearParticipant({ commit }) {
      commit('clearParticipant')
    },
    clearParticipants({ commit }) {
      commit('clearParticipants')
    },
    getParticipants({ commit, state }, params) {
      let { contest_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/participants`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setParticipants', data.body)
          }
        })
      })
    },
    getParticipant({ commit, state }, params) {
      let { contest_id, participant_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/participants/${participant_id}`).then(data => {
          if (data.status && data.status == 200) {
            commit('setParticipant', data.body)
          }
        })
      })
    },
    createParticipant({ commit }, params) {
      return new Promise((resolve, reject) => {
        commit('createParticipant', { params, resolve, reject })
      })
    },
    updateParticipant({ state }, params) {
      let { participant, contest_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.put(`contests/${contest_id}/participants/${participant.id}`, params).then(data => {
          if (data.status) resolve(data.body)
        })
      })
    },
    deleteParticipant({ state }, params) {
      let { participant, contest_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.delete(`contests/${contest_id}/participants/${participant.id}`).then(data => {
          if (data.status && data.body.status == 200) resolve(data.body)
        })
      })
    },
    getNominationParticipants({ commit, state }, params) {
      let { contest_id, nomination_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/participants/by_nomination?nomination_id=${nomination_id}`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setParticipants', data.body)
          }
        })
      })
    },
  }
}
