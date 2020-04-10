import { commonStore } from 'store/common'
import { contestsStore } from 'store/contests'
import { criterionsStore } from 'store/criterions'
import { participantsStore } from 'store/participants'
import { nominationsStore } from 'store/nominations'
import { expertsStore } from 'store/experts'
export default {
  modules: {
    common: { namespaced: true, ...commonStore },
    contests: { namespaced: true, ...contestsStore },
    criterions: { namespaced: true, ...criterionsStore },
    participants: { namespaced: true, ...participantsStore },
    nominations: { namespaced: true, ...nominationsStore },
    experts: { namespaced: true, ...expertsStore }
  }
}
