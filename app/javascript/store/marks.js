import Vue from 'vue'
export const marksStore = {
  state: {
    marks: []
  },
  mutations: {
    setMarks(state, marks) {
      state.marks = marks
    },
  },
  actions: {

  }
}
