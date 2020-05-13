import Vue from 'vue'

export const participantsStore = {
  state: {
    participants: [],
    participant: {},
    paginationInfo: {}
  },
  mutations: {
    clearParticipant(state) {
      Vue.set(state, 'participant', {})
    },
    clearParticipants(state) {
      Vue.set(state, 'participants', [])
    },
    clearPagination(state) {
      Vue.set(state, 'paginationInfo', {})
    },
    setParticipant(state, participant) {
      Vue.set(state, 'participant', participant)
    },
    setParticipants(state, participants) {
      state.participants = participants
    },
    setPaginationInfo(state, paginationInfo) {
      state.paginationInfo = paginationInfo
    },
    createParticipant(state, params) {
      let { resolve, reject } = params
      Vue.http.post(`contests/${params.params.contest_id}/participants`, params.params).then(data => {
        if (data.ok) {
          resolve(data.body)
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
    clearPagination({ commit }) {
      commit('clearPagination')
    },
    getParticipants({ commit, state }, params) {
      let { contest_id, page, active } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/participants`, {params: params}).then(data => {
          if (data.ok && data.status == 200) {
            commit('setParticipants', data.body.participants)
            commit('setPaginationInfo', data.body.pagination_info)
          }
        })
      })
    },
    getResultParticipants({ commit, state }, params) {
      let { contest_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/participants/for_results`).then(data => {
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
    getResultNominationParticipants({ commit, state }, params) {
      let { contest_id, nomination_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`contests/${contest_id}/participants/by_nomination_results?nomination_id=${nomination_id}`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setParticipants', data.body)
          }
        })
      })
    }
  }
}
