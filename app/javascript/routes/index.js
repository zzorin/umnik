import Dashboard from 'components/dashboard'
import ContestsIndex from 'components/contests/index'
import ContestShow from 'components/contests/show'
import CriterionsIndex from 'components/criterions/index'
import CriterionShow from 'components/criterions/show'

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
                name: 'criterion_show',
                path: '/contests/:id/criterions/',
                component: CriterionShow
              }
            ]
          }
        ]
      }
    ]
  }
]
