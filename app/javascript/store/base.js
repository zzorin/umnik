import { contestsStore } from 'store/contests'
import { criterionsStore } from 'store/criterions'
import { participantsStore } from 'store/participants'
export default {
  modules: {
    contests: { namespaced: true, ...contestsStore },
    criterions: { namespaced: true, ...criterionsStore },
    participants: { namespaced: true, ...participantsStore }
  }
}
