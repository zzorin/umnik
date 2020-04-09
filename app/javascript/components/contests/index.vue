<template>
  <div>
    <div v-if='isCurrentPage("contests")' class="contests-list">
      <h1>Список конкурсов</h1>
      <div class="mb-1"><strong>Название конкурса</strong></div>
      <div class="d-flex">
        <input type="text" class="input-with-button form-control" v-model='newContest.title'/>
        <span class='btn btn-blue' @click='selfCreateContest' :class="{'disabled': !newContest.title}">
          Добавить конкурс
        </span>
      </div>
      <div class="contests-list-table">
        <table>
          <tr v-for='contest in contests'>
            <td>
              <router-link :to="{name: 'criterions', params: { id: contest.id }}">
                {{ contest.title }}
              </router-link>
            </td>
            <td>
              <span @click='selfDeleteContest(contest)' class='cursor-pointer'>
                <svg class="bi bi-x" width="26px" height="26px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 010 .708l-7 7a.5.5 0 01-.708-.708l7-7a.5.5 0 01.708 0z" clip-rule="evenodd"/>
                  <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 000 .708l7 7a.5.5 0 00.708-.708l-7-7a.5.5 0 00-.708 0z" clip-rule="evenodd"/>
                </svg>
              </span>
            </td>
          </tr>
        </table>
      </div>
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
