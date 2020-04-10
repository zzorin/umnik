<template>
  <div>
    {{expert}}
    <form>
      <div class="form-group">
        <b><label for="">Фамилия</label><span class="necessary-field">*</span></b>
        <input type="text" v-model='expert.surname' />
        <b><label for="">Имя</label><span class="necessary-field">*</span></b>
        <input type="text" v-model='expert.name' />
        <b><label for="">Отчество</label></b>
        <input type="text" v-model='expert.patronymic' />
      </div>
    </form>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
  import { CommonMixin } from 'mixins/common'
  export default {
    mixins: [CommonMixin],
    computed: {
      ...mapState( 'experts', ['expert']),
      ...mapGetters('contests', ['currentContest'])
    },
    methods: {
      ...mapActions('experts', ['getExpert']),
      selfGetExpert() {
        let params = {
          contest_id: this.$route.params.id,
          expert_id: this.$route.params.expert_id
         }
        this.getExpert(params)
      }
    },
    created() {
      if (this.isCurrentPage("expert_new")) {
        console.warn('New expert')
      }
      if (this.isCurrentPage("expert_edit")) {
        console.warn('Edit expert')
        this.selfGetExpert()
      }
    }
  }
</script>
