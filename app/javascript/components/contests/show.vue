<template>
  <div>
    <h1>{{currentContest.title}}</h1>
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
    <router-view v-if='currentContest.id'></router-view>

  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions } from 'vuex'

  export default {
    computed: {
      ...mapState( 'contests', ['currentContest']),
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
        this.getContest(params)
      }
    },
    created() {
      console.warn('Конкурс')
      this.selfGetContest()
    }
  }
</script>
