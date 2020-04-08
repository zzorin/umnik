<template>
  <div>
    <div>
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li class="nav-item">
             <router-link :to="{name: 'criterions'}">
               Критерии обзора
             </router-link>
        </li>
        <li class="nav-item">
             <router-link :to="{name: 'participants'}">
               Список участников
             </router-link>
        </li>
      </ul>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions } from 'vuex'

  export default {
    computed: {
      ...mapState( 'contests', ['contests']),
      isContestIndex() {
        return this.$route.name == 'contests'
      }
    },
    methods: {
      contestsRequester() {
        this.getContests()
      },
      ...mapActions('contests', ['getContests'])
    },
    created() {
      console.warn('Конкурс')
      this.contestsRequester()
    }
  }
</script>
