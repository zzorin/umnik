<template>
  <div>
      <h1>Конкурсы</h1>
      <table>
        <tr>
          <th>Название</th>
          <th colspan="2"></th>
        </tr>

        <tr v-for='contest in contests'>
          <td>
            <router-link :to="{name: 'show_contest', params: { id: contest.id }}">
              {{ contest.title }}
            </router-link>
          </td>
        </tr>
      </table>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions } from 'vuex'

  export default {
    computed: {
      ...mapState( 'contests', ['contests'])
    },
    methods: {
      contestsRequester() {
        this.request()
      },
      ...mapActions('contests', ['request'])
    },
    created() {
      console.warn('Конкурсы')
      this.contestsRequester()
    }
  }
</script>
