<template>
  <div>
    <div v-if='isCurrentPage("participants")'>
        <router-link tag="span" class="btn btn-blue mt-4 mb-3" :to="{name: 'participant_new', params: { id: currentContest.id }} ">
          Добавить участника
        </router-link>

      <table v-if="participants.length" class="table" >
        <tr>
          <th>Организация</th>
          <th>ФИО</th>
          <th>Проект</th>
          <th>Направление</th>
          <th>Действия</th>
        </tr>
        <tr v-for='participant in participants'>
          <td>
            {{participant.organization}}
          </td>
          <td>
            {{participant.fullname}}
          </td>
          <td>
            {{participant.project_title}}
          </td>
          <td>
            {{participant.nomination.title}}
          </td>
          <td>
            <router-link :to="{name: 'participant_edit', params: { id: currentContest.id, participant_id: participant.id }} ">
              <svg class="bi bi-pencil" width="16px" height="16px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M11.293 1.293a1 1 0 011.414 0l2 2a1 1 0 010 1.414l-9 9a1 1 0 01-.39.242l-3 1a1 1 0 01-1.266-1.265l1-3a1 1 0 01.242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z" clip-rule="evenodd"/>
                <path fill-rule="evenodd" d="M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 00.5.5H4v.5a.5.5 0 00.5.5H5v.5a.5.5 0 00.5.5H6v-1.5a.5.5 0 00-.5-.5H5v-.5a.5.5 0 00-.5-.5H3z" clip-rule="evenodd"/>
              </svg>
            </router-link>
            <span class='cursor-pointer' @click='selfDeleteParticipant(participant)'>
              <svg class="bi bi-x" width="26px" height="26px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 010 .708l-7 7a.5.5 0 01-.708-.708l7-7a.5.5 0 01.708 0z" clip-rule="evenodd"/>
                <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 000 .708l7 7a.5.5 0 00.708-.708l-7-7a.5.5 0 00-.708 0z" clip-rule="evenodd"/>
              </svg>
            </span>
          </td>
        </tr>
      </table>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
  import { CommonMixin } from 'mixins/common'

  export default {
    mixins: [CommonMixin],
    computed: {
      ...mapState( 'participants', ['participants']),
      ...mapGetters('contests', ['currentContest'])
    },
    methods: {
      ...mapActions('participants', ['getParticipants', 'deleteParticipant']),
      selfGetParticipants() {
        let params = { contest_id: this.currentContest.id }
        this.getParticipants(params)
      },
      selfDeleteParticipant(participant) {
        if (!confirm('Точно хотите удалить?')) return
        let params = {
          contest_id: this.currentContest.id,
          participant : participant
        }
        this.deleteParticipant(params).then(data => {
          this.selfGetParticipants()
        })
      }
    },
    created() {
      console.warn('Participants')
      this.selfGetParticipants()
    }
  }
</script>
