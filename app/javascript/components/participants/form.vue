<template>
  <div>
    {{participant}}
    <form>
      <div class="form-group">
        <b><label for="">Фамилия</label><span class="necessary-field">*</span></b>
        <input type="text" v-model='participant.surname' />
        <b><label for="">Имя</label><span class="necessary-field">*</span></b>
        <input type="text" v-model='participant.name' />
        <b><label for="">Отчество</label></b>
        <input type="text" v-model='participant.patronymic' />
      </div>
      <div class="form-group">
        <b><label for="">Полное название доклада участника</label><span class="necessary-field">*</span></b>
        <input type="text" v-model='participant.project_title' />
      </div>
      <div class="form-group">
        <b><label for="">Направление</label><span class="necessary-field">*</span></b>
        <select v-model='participant.nomination_id'>
          <option v-for="nomination in nominations" v-bind:value="nomination.id">
            {{ nomination.code +' '+nomination.title}}
          </option>
        </select>
      </div>
      <div class="form-group">
        <b><label for="">Принадлежность к организации (ВУЗ, институт и пр.)</label><span class="necessary-field">*</span></b>
        <input type="text" v-model='participant.organization' />
      </div>
      <div class="form-group">
        <b><label for="">Контактная информация</label><span class="necessary-field">*</span></b>
        <input type="text" v-model='participant.contact_info' />
      </div>
      <div class="form-group">
        <b><label for="">Описание проекта</label><span class="necessary-field">*</span></b>
        <textarea type="text" v-model='participant.project_info' />
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
