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
        <div class="row">
          <div class="col-lg-4">
            <b><label for="">Статус</label><span class="necessary-field text-danger">*</span></b>
            <br>
            <input type="radio" value='true' v-model="expert.active">
            <label>Активен</label>
            <br>
            <input type="radio" value='false' v-model="expert.active">
            <label>Заблокирован</label>
          </div>
          <div class="col-lg-8">
            <b><label for="">Пользователь</label></b>
            {{permission}}
            <br>
            <autocomplete source='/users/search?term='
                    @selected='selectedUser'
                    resultsDisplay='label'
                    ref="autocomplete"
                    class="mb-3"
                    placeholder='Введите фамилию, имя и отчество'>
                    <slot slot="noResults">
                      Нет результатов
                    </slot>
            </autocomplete>
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
      ...mapState( 'experts', ['expert', 'permission']),
      ...mapGetters('contests', ['currentContest'])
    },
    methods: {
      ...mapActions('experts', ['getExpert']),
      selectedUser(object) {
        this.$set(this.permission, 'user_id', object.selectedObject.id),
        this.$set(this.permission, 'context_type', 'Expert')
        this.$set(this.permission, 'role', 'expert')
      },
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
        this.$set(this.expert, 'active', true)
      }
      if (this.isCurrentPage("expert_edit")) {
        console.warn('Edit expert')
        this.selfGetExpert()
      }
    }
  }
</script>
