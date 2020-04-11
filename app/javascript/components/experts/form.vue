<template>
  <div class="background-gray with-paddings mb-4">
    <form>
      <div class="form-group">
        <div class="row">
          <div class="col-lg-4">
            <b><label for="">Фамилия</label><span class="necessary-field text-danger">*</span></b>
            <input type="text" class="form-control" v-model='expert.surname' />
          </div>
          <div class="col-lg-4">
            <b><label for="">Имя</label><span class="necessary-field text-danger">*</span></b>
            <input type="text" class="form-control" v-model='expert.name' />
          </div>
          <div class="col-lg-4">
            <b><label for="">Отчество</label></b>
            <input type="text" class="form-control" v-model='expert.patronymic' />
          </div>
        </div>
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
