<template>
  <div class="margin-bottom-40">
    <h1>{{currentContest.title}}</h1>
    <div>
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li v-if='access_rules.contests.update' class="nav-item">
             <router-link :to="{name: 'criterions'}"
                          class="nav-link"
                          v-bind:class="{active: isCurrentPage('criterions')}">
               Критерии оценки проекта
             </router-link>
        </li>
        <li v-if='access_rules.contests.update' class="nav-item">
             <router-link :to="{name: 'nominations'}"
                          class="nav-link"
                          v-bind:class="{active: isCurrentPage('nominations')}">
               Номинации
             </router-link>
        </li>
        <li class="nav-item">
             <router-link :to="{name: 'participants'}"
                          class="nav-link"
                          v-bind:class="{active: isCurrentPage('participants') ||
                                                 isCurrentPage('participant_new') ||
                                                 isCurrentPage('participant_edit')}">
               Участники
             </router-link>
        </li>
        <li v-if='access_rules.experts.index' class="nav-item">
             <router-link :to="{name: 'experts'}" class="nav-link"
                          v-bind:class="{active: isCurrentPage('experts') ||
                                                 isCurrentPage('expert_new') ||
                                                 isCurrentPage('expert_edit') ||
                                                 isCurrentPage('marks')}">
               Эксперты и оценки
             </router-link>
        </li>
        <li v-if='access_rules.contests.update ||
                  (access_rules.experts.index_for_results && currentContest.show_results)'
                  class="nav-item">
             <router-link :to="{name: 'results'}"
                          class="nav-link"
                          v-bind:class="{active: isCurrentPage('results')}">
               Результаты конкурса
             </router-link>
        </li>
      </ul>
    </div>
    <router-view v-if='currentContest.id'></router-view>

  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { mapState, mapMutations, mapActions } from 'vuex'

  export default {
    computed: {
      ...mapState( 'contests', ['currentContest']),
      id() {
        return this.$route.params.id
      }
    },
    mixins: [CommonMixin],
    methods: {
      ...mapActions('contests', ['getContest']),
      selfGetContest() {
        let params = { id: this.id }
        this.getContest(params)
      },
    },
    created() {
      console.warn('Конкурс')
      this.selfGetContest()
    }
  }
</script>
