<template>
  <div class="participant-form background-gray with-paddings mb-4">
    <form>
      <div class="form-group">
        <div class="row">
          <div class="col">
            <b><label for="">ФИО</label><span class="necessary-field text-danger">*</span></b>
            <input type="text" class="form-control" v-model='participant.name' />
          </div>
        </div>
      </div>
      <div class="form-group">
        <div class="row">
          <div class="col">
            <b><label for="">Полное название доклада участника</label><span class="necessary-field text-danger">*</span></b>
            <input type="text" class="form-control"v-model='participant.project_title' />
          </div>
        </div>
      </div>

      <div class="form-group">
        <div class="row">
          <div class="col-lg-8">
            <b><label for="">Направление</label><span class="necessary-field text-danger">*</span></b>
            <select v-model='participant.nomination_id' class="form-control dark-grey-select">
              <option v-for="nomination in nominations" v-bind:value="nomination.id" class="dark-grey-select dark-grey-option">
                {{ nomination.code +' '+nomination.title}}
              </option>
            </select>
          </div>
        </div>
      </div>

      <div class="form-group">
        <div class="row">
          <div class="col">
            <b><label for="">Принадлежность к организации (ВУЗ, институт и пр.)</label><span class="necessary-field text-danger">*</span></b>
            <input type="text" v-model='participant.organization' class="form-control" />
          </div>
        </div>
      </div>

      <div class="form-group">
        <div class="row">
          <div class="col">
            <b><label for="">Контактная информация</label><span class="necessary-field text-danger">*</span></b>
            <input type="text" v-model='participant.contact_info' class="form-control" />
          </div>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
  import { CommonMixin } from 'mixins/common'
  export default {
    mixins: [CommonMixin],
    computed: {
      ...mapState( 'participants', ['participant']),
      ...mapGetters('contests', ['currentContest']),
      ...mapGetters('nominations', ['nominations'])
    },
    methods: {
      ...mapActions('nominations', ['getNominations']),
      ...mapActions('participants', ['getParticipant']),
      selfGetParticipant() {
        let params = {
          contest_id: this.$route.params.id,
          participant_id: this.$route.params.participant_id
         }
        this.getParticipant(params)
      },
      selfGetNominations() {
        let params = {
          contest_id: this.currentContest.id,
        }
        this.getNominations(params)
      }
    },
    created() {
      this.selfGetNominations()
      if (this.isCurrentPage("participant_new")) {
        console.warn('New participant')
      }
      if (this.isCurrentPage("participant_edit")) {
        console.warn('Edit participant')
        this.selfGetParticipant()
      }
    }
  }
</script>
