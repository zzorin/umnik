<template>
  <div v-if='isCurrentPage("participant_edit")'>
    <h1>Изменить информацию об участнике</h1>
    <participant-form>
    </participant-form>
    <span class='btn btn-green' @click='selfUpdateParticipant'>
      Сохранить
    </span>
    <span class='btn btn-blue' @click='redirectBack'>
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
            this.clearParticipant()
            this.getParticipants({ contest_id: this.currentContest.id })
            this.redirectBack()
          }
        })
      },
      redirectBack() {
        this.redirectTo('participants', this.currentContest.id )
      }
    }
  }
</script>
