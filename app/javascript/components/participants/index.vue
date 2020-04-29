<template>
  <div>
    <div v-if='isCurrentPage("participants")'>
        <router-link v-if='access_rules.participants.new'
                     tag="span"
                     class="btn btn-blue mt-4 mb-3"
                     :to="{
                       name: 'participant_new',
                       params: { id: currentContest.id }
                     } ">
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
            {{participant.name}}
          </td>
          <td>
            {{participant.project_title}}
          </td>
          <td>
            {{participant.nomination.title}}
          </td>
          <td>
            <a v-if='participant.chat_link'
               :href="participant.chat_link"
               target="_blank">
               <svg class="bi bi-camera-video" width="1em" height="1em" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                 <path fill-rule="evenodd" d="M2.667 3.5c-.645 0-1.167.522-1.167 1.167v6.666c0 .645.522 1.167 1.167 1.167h6.666c.645 0 1.167-.522 1.167-1.167V4.667c0-.645-.522-1.167-1.167-1.167H2.667zM.5 4.667C.5 3.47 1.47 2.5 2.667 2.5h6.666c1.197 0 2.167.97 2.167 2.167v6.666c0 1.197-.97 2.167-2.167 2.167H2.667A2.167 2.167 0 01.5 11.333V4.667z" clip-rule="evenodd"/>
                 <path fill-rule="evenodd" d="M11.25 5.65l2.768-1.605a.318.318 0 01.482.263v7.384c0 .228-.26.393-.482.264l-2.767-1.605-.502.865 2.767 1.605c.859.498 1.984-.095 1.984-1.129V4.308c0-1.033-1.125-1.626-1.984-1.128L10.75 4.785l.502.865z" clip-rule="evenodd"/>
               </svg>
            </a>
            <router-link v-if='access_rules.participants.manage'
                         :to="{
                           name: 'participant_edit',
                           params: {
                             id: currentContest.id,
                             participant_id: participant.id
                           }
                         } ">
              <svg class="bi bi-pencil" width="16px" height="16px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M11.293 1.293a1 1 0 011.414 0l2 2a1 1 0 010 1.414l-9 9a1 1 0 01-.39.242l-3 1a1 1 0 01-1.266-1.265l1-3a1 1 0 01.242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z" clip-rule="evenodd"/>
                <path fill-rule="evenodd" d="M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 00.5.5H4v.5a.5.5 0 00.5.5H5v.5a.5.5 0 00.5.5H6v-1.5a.5.5 0 00-.5-.5H5v-.5a.5.5 0 00-.5-.5H3z" clip-rule="evenodd"/>
              </svg>
            </router-link>
            <span v-if='access_rules.participants.manage'
                  class='cursor-pointer'
                  @click='selfDeleteParticipant(participant)'>
              <svg class="bi bi-trash" width="1em" height="1em" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                <path d="M5.5 5.5A.5.5 0 016 6v6a.5.5 0 01-1 0V6a.5.5 0 01.5-.5zm2.5 0a.5.5 0 01.5.5v6a.5.5 0 01-1 0V6a.5.5 0 01.5-.5zm3 .5a.5.5 0 00-1 0v6a.5.5 0 001 0V6z"/>
                <path fill-rule="evenodd" d="M14.5 3a1 1 0 01-1 1H13v9a2 2 0 01-2 2H5a2 2 0 01-2-2V4h-.5a1 1 0 01-1-1V2a1 1 0 011-1H6a1 1 0 011-1h2a1 1 0 011 1h3.5a1 1 0 011 1v1zM4.118 4L4 4.059V13a1 1 0 001 1h6a1 1 0 001-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z" clip-rule="evenodd"/>
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
