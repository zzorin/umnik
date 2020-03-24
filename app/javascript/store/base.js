import { contestsStore } from 'store/contests'
export default {
  modules: {
    contests: { namespaced: true, ...contestsStore }
  }
}
