<template>
  <div v-if='isCurrentPage("expert_new")'>
    <h3 class="mt-4">Добавить эксперта</h3>
    <expert-form>
    </expert-form>
    <span class='btn btn-green' @click='selfCreateExpert'>
      Сохранить
    </span>
    <span class='btn btn-light-blue' @click='redirectBack'>
      Отменить
    </span>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
  import { CommonMixin } from 'mixins/common'
  import { NotificationsMixin } from 'mixins/notifications'
  import ExpertForm from 'components/experts/form'

  export default {
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState('experts', ['expert']),
      ...mapGetters('contests', ['currentContest'])
    },
    components: {
      ExpertForm
    },
    methods: {
      ...mapActions('experts', ['createExpert', 'getExperts', 'clearExpert']),
      ...mapActions('permissions', ['createPermission']),
      selfCreateExpert() {
        this.$set(this.expert, 'contest_id', this.currentContest.id)
        let params = {
          expert: this.expert,
          contest_id: this.currentContest.id
        }
        this.createExpert(params).then(data => {
          if (data.status == 200) {
            this.notificate({
              title: data.body.notifications.title,
              text: data.body.notifications.text
            })
            if (this.expert.permission.user_id) {
              this.selfCreatePermission(data.body.id)
            }
            this.getExperts({ contest_id: this.currentContest.id })
            this.redirectBack()
          }
        })
      },
      selfCreatePermission(expert_id) {
        this.$set(this.expert.permission, 'context_id', expert_id)
        let params = { permission: this.expert.permission }
        this.createPermission(params).then(data => {
          if (data.status == 200) {
            this.notificate({
              title: data.body.notifications.title,
              text: data.body.notifications.text
            })
          }
        })
      },
      redirectBack() {
        this.clearExpert()
        this.redirectTo('experts', this.currentContest.id )
      }
    }
  }
</script>
