<template>
  <div>
    <div v-if='isCurrentPage("participants")'>
      <h1>Список участников</h1>
      <table>
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
          </td>
        </tr>
      </table>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions } from 'vuex'
  import { CommonMixin } from 'mixins/common'

  export default {
    mixins: [CommonMixin],
    computed: {
      ...mapState( 'participants', ['participants'])
    },
    methods: {
      participantsRequester() {
        this.request(this.$route.params.id)
      },
      ...mapActions('participants', ['request'])
    },
    created() {
      console.warn('Participants')
      this.participantsRequester()
    }
  }
</script>
