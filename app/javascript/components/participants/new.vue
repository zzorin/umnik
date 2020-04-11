<template>
  <div v-if='isCurrentPage("participant_new")'>
    <h3 class="mt-4">Добавить участника</h3>
    <div class="margin-bottom-40">
      <participant-form>
      </participant-form>
      <span class='btn btn-green' @click='selfCreateParticipant'>
        Сохранить
      </span>
      <span class='btn btn-blue' @click='redirectBack'>
        Отменить
      </span>
    </div>
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
      ...mapActions('participants', ['createParticipant', 'getParticipants', 'clearParticipant']),
      selfCreateParticipant() {
        let params = {
          participant: this.participant,
          contest_id: this.currentContest.id
        }
        this.createParticipant(params).then(data => {
          if (data.status == 200) {
            this.notificate({
              title: data.body.notifications.title,
              text: data.body.notifications.text
            })
            this.getParticipants({ contest_id: this.currentContest.id })
            this.redirectBack()
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
