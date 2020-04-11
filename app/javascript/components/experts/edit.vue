<template>
  <div v-if='isCurrentPage("expert_edit")'>
    <h3 class="mt-4">Изменить информацию об эксперте</h3>
    <expert-form>
    </expert-form>
    <span class='btn btn-green' @click='selfUpdateExpert'>
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
      ...mapActions('experts', ['updateExpert', 'getExperts', 'clearExpert']),
      selfUpdateExpert() {
        this.updateExpert({expert: this.expert} ).then(data => {
          if (data.status == 'error') {
            this.notificate({
              title: data.errors.title,
              text: data.errors.text,
              type: 'error'
            })
            return
          }
          if (data.status == 200) {
            this.notificate({
              title: data.notifications.title,
              text: data.notifications.text,
              type: 'warn'
            })
            this.getExperts({ contest_id: this.currentContest.id })
            this.redirectBack()
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
