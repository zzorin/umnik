<template>
  <div>
    <div v-if='isCurrentPage("experts")'>
      <router-link v-if='access_rules.experts.new' tag="span" class="btn btn-blue mt-4 mb-3" :to="{name: 'expert_new', params: { id: currentContest.id }} ">
        Добавить эксперта
      </router-link>

      <ul v-for='expert in experts' class="list-unstyled">
        <li>
          <router-link :to="{name: 'marks', params: { id: currentContest.id, expert_id: expert.id }}">
            {{ expert.shortname }}
          </router-link>
          <template v-if='access_rules.experts.manage'>
            <router-link :to="{name: 'expert_edit', params: { id: currentContest.id, expert_id: expert.id }} ">
              <svg class="bi bi-pencil ml-2" width="16px" height="16px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M11.293 1.293a1 1 0 011.414 0l2 2a1 1 0 010 1.414l-9 9a1 1 0 01-.39.242l-3 1a1 1 0 01-1.266-1.265l1-3a1 1 0 01.242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z" clip-rule="evenodd"/>
                <path fill-rule="evenodd" d="M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 00.5.5H4v.5a.5.5 0 00.5.5H5v.5a.5.5 0 00.5.5H6v-1.5a.5.5 0 00-.5-.5H5v-.5a.5.5 0 00-.5-.5H3z" clip-rule="evenodd"/>
              </svg>
            </router-link>
            <span class='cursor-pointer' @click='selfDeleteExpert(expert)'>
              <svg class="bi bi-x" width="26px" height="26px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 010 .708l-7 7a.5.5 0 01-.708-.708l7-7a.5.5 0 01.708 0z" clip-rule="evenodd"/>
                <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 000 .708l7 7a.5.5 0 00.708-.708l-7-7a.5.5 0 00-.708 0z" clip-rule="evenodd"/>
              </svg>
            </span>
          </template>
        </li>
      </ul>
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
      ...mapState( 'experts', ['experts']),
      ...mapGetters('contests', ['currentContest'])
    },
    methods: {
      ...mapActions('experts', ['getExperts', 'deleteExpert']),
      selfGetExperts() {
        let params = { contest_id: this.currentContest.id }
        this.getExperts(params)
      },
      selfDeleteExpert(expert) {
        if (!confirm('Точно хотите удалить?')) return
        this.deleteExpert({ expert }).then(data => {
          this.selfGetExperts()
        })
      }
    },
    created() {
      console.warn('Experts')
      this.selfGetExperts()
    }
  }
</script>
