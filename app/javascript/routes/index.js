import Dashboard from 'components/dashboard'
import ContestsIndex from 'components/contests/index'
import ContestShow from 'components/contests/show'
import CriterionsIndex from 'components/criterions/index'
import ParticipantsIndex from 'components/participants/index'
import NominationsIndex from 'components/nominations/index'

export const routes = [
  {
    name: 'dashboard',
    path: '/',
    component: Dashboard,
    children: [
      {
        name: 'contests',
        path: 'contests',
        component: ContestsIndex,
        children: [
          {
            name: 'contest_show',
            path: '/contests/:id',
            component: ContestShow,
            children: [
              {
                name: 'criterions',
                path: '/contests/:id/criterions',
                component: CriterionsIndex
              },
              {
                name: 'participants',
                path: '/contests/:id/participants',
                component: ParticipantsIndex
              },
              {
                name: 'nominations',
                path: '/contests/:id/nominations',
                component: NominationsIndex
              },
            ]
          }
        ]
      }
    ]
  }
]
