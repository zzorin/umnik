<template>
  <div>
    <h1>{{contest.title}}</h1>
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
    data() {
      return {
        contest: {}
      }
    },
    computed: {
      ...mapState( 'contests', ['contests']),
      isContestIndex() {
        return this.$route.name == 'contests'
      },
      id() {
        return this.$route.params.id
      }
    },
    methods: {
      ...mapActions('contests', ['getContest']),
      selfGetContest() {
        let params = { id: this.id }
        this.getContest(params).then(data => {
          this.$set(this, 'contest', data.contest)
        })
      }
    },
    created() {
      console.warn('Конкурс')
      this.selfGetContest()
    }
  }
</script>
