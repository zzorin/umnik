<template>
  <div class="participant-form background-gray with-paddings mb-4">
    {{participant}}
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
      <div class="form-group">
        <b><label class="mt-3">Пользователь</label></b>
        <br>
        <div v-if='participant.permission && participant.permission.user_id'>
          {{participant.permission.fullname}}
          <span @click='selfDeletePermission()'
                class='cursor-pointer'>
            <svg class="bi bi-x" width="26px" height="26px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
              <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 010 .708l-7 7a.5.5 0 01-.708-.708l7-7a.5.5 0 01.708 0z" clip-rule="evenodd"/>
              <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 000 .708l7 7a.5.5 0 00.708-.708l-7-7a.5.5 0 00-.708 0z" clip-rule="evenodd"/>
            </svg>
          </span>
        </div>
        <autocomplete
                v-if='!(participant.permission && participant.permission.user_id)'
                source='/users/search?term='
                @selected='selectedUser'
                resultsDisplay='label'
                ref="autocomplete"
                class="mb-3"
                placeholder='Введите фамилию, имя и отчество'>
                <slot slot="noResults">
                  Нет результатов
                </slot>
        </autocomplete>
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
      ...mapActions('permissions', ['deletePermission']),
      selectedUser(object) {
        this.$set(this.participant.permission, 'user_id', object.selectedObject.id),
        this.$set(this.participant.permission, 'context_type', 'Participant')
        this.$set(this.participant.permission, 'role', 'participant')
        this.$set(this.participant.permission, 'fullname', object.selectedObject.label)
      },
      clearPermission() {
        this.$set(this.participant, 'permission', {})
      },
      selfDeletePermission() {
        if (this.participant.permission.id) {
          if (!confirm('Точно хотите удалить?')) return
          this.deletePermission({ permission: this.participant.permission })
        }
        this.clearPermission()
      },
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
        this.$set(this.participant, 'permission', {})
      }
      if (this.isCurrentPage("participant_edit")) {
        console.warn('Edit participant')
        this.selfGetParticipant()
      }
    }
  }
</script>
