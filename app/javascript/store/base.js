import { contestsStore } from 'store/contests'
import { criterionsStore } from 'store/criterions'
export default {
  modules: {
    contests: { namespaced: true, ...contestsStore },
    criterions: { namespaced: true, ...criterionsStore }
  }
}
