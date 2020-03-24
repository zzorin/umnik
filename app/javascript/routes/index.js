import Dashboard from 'components/dashboard'
import ContestIndex from 'components/contests/index'
import ShowContest from 'components/contests/show'

export const routes = [
  {
    name: 'Dashboard',
    path: '/',
    component: Dashboard,
    children: [
      {
        name: 'contests',
        path: 'contests',
        component: ContestIndex,
        children: [
          {
            name: 'show_contest',
            path: '/contests/:id',
            component: ShowContest
          }
        ]
      }
    ]
  }
]
