<template>
  <div v-if='isCurrentPage("participant_edit")' class="margin-bottom-40">
    <h3 class="mt-4">Изменить информацию об участнике</h3>
    <participant-form>
    </participant-form>
    <span class='btn btn-green' @click='selfUpdateParticipant'>
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
  import ParticipantForm from 'components/participants/form'

  export default {
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState('participants', ['participant']),
      ...mapGetters('contests', ['currentContest'])
    },
    components: {
      ParticipantForm
    },
    methods: {
      ...mapActions('participants', ['updateParticipant', 'getParticipants', 'clearParticipant']),
      ...mapActions('permissions', ['createPermission']),
      selfUpdateParticipant() {
        let params = {
          contest_id: this.currentContest.id,
          participant: this.participant
        }
        this.updateParticipant(params).then(data => {
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
            if (this.participant.permission.user_id) {
              this.selfCreatePermission(data.id)
            }
            this.getParticipants({ contest_id: this.currentContest.id })
            this.redirectBack()
          }
        })
      },
      selfCreatePermission(participant_id) {
        this.$set(this.participant.permission, 'context_id', participant_id)
        let params = { permission: this.participant.permission }
        this.createPermission(params).then(data => {
          if (data.status == 200) {
            this.notificate({
              title: data.notifications.title,
              text: data.notifications.text
            })
          }
        })
      },
      redirectBack() {
        this.clearParticipant()
        this.redirectTo('participants', this.currentContest.id )
      }
    }
  }
</script>
