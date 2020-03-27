<template>
  <div>
    <div v-if='isCurrentPage("contests")'>
      <h1>Конкурсы</h1>
      <table>
        <tr>
          <th>Название</th>
          <th colspan="2"></th>
        </tr>

        <tr v-for='contest in contests'>
          <td>
            <router-link :to="{name: 'criterions', params: { id: contest.id }}">
              {{ contest.title }}
            </router-link>
          </td>
        </tr>
      </table>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { mapState, mapMutations, mapActions } from 'vuex'

  export default {
    mixins: [CommonMixin],
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
