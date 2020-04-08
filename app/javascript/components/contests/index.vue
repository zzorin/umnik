<template>
  <div>
    <div v-if='isCurrentPage("contests")'>
      <h1>Список конкурсов</h1>
      <h2>Название конкурса</h2>
      <input type="text" v-model='newContest.title'/>
      <span class='btn btn-blue mt-3' @click='selfCreateContest' :class="{'disabled': !newContest.title}">
        Добавить конкурс
      </span>
      <table>
        <tr v-for='contest in contests'>
          <td>
            <router-link :to="{name: 'criterions', params: { id: contest.id }}">
              {{ contest.title }}
            </router-link>
          </td>
          <td>
            <span class='btn btn-blue mt-3' @click='selfDeleteContest(contest)'>
              Удалить
            </span>
          </td>
        </tr>
      </table>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { NotificationsMixin } from 'mixins/notifications'
  import { mapState, mapMutations, mapActions } from 'vuex'

  export default {
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState( 'contests', ['contests', 'newContest'])
    },
    methods: {
      ...mapActions('contests', ['clearNewContest', 'getContests', 'createContest', 'deleteContest']),
      contestsRequester() {
        this.getContests()
      },
      selfCreateContest() {
        let params = { contest: this.newContest }
        this.createContest(params).then(data => {
          if (data.status == 200) {
            this.notificate({
              title: data.body.notifications.title,
              text: data.body.notifications.text
            })
            this.clearNewContest()
            this.getContests()
          }

        })
      },
      selfDeleteContest(contest) {
        if (!confirm('Точно хотите удалить?')) return
        this.deleteContest({ contest }).then(data => {
          this.getContests()
        })
      },
    },
    created() {
      console.warn('Конкурсы')
      this.contestsRequester()
    }
  }
</script>
