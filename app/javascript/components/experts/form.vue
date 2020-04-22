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
            <b><label class="mt-3">Статус</label><span class="necessary-field text-danger">*</span></b>
            <br>
            <input type="radio" value='true' v-model="expert.active">
            <label>Активен</label>
            <br>
            <input type="radio" value='false' v-model="expert.active">
            <label>Заблокирован</label>
          </div>
          <div class="col-lg-8">
            <b><label class="mt-3">Пользователь</label></b>
            <br>
            <div v-if='expert.permission && expert.permission.user_id'>
              {{expert.permission.fullname}}
              <span @click='selfDeletePermission()'
                    class='cursor-pointer'>
                <svg class="bi bi-x" width="26px" height="26px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 010 .708l-7 7a.5.5 0 01-.708-.708l7-7a.5.5 0 01.708 0z" clip-rule="evenodd"/>
                  <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 000 .708l7 7a.5.5 0 00.708-.708l-7-7a.5.5 0 00-.708 0z" clip-rule="evenodd"/>
                </svg>
              </span>
            </div>
            <autocomplete
                    v-if='!(expert.permission && expert.permission.user_id)'
                    source='/users/search?term='
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
      ...mapState( 'experts', ['expert']),
      ...mapGetters('contests', ['currentContest'])
    },
    methods: {
      ...mapActions('experts', ['getExpert']),
      ...mapActions('permissions', ['deletePermission']),
      selectedUser(object) {
        this.$set(this.expert.permission, 'user_id', object.selectedObject.id),
        this.$set(this.expert.permission, 'context_type', 'Expert')
        this.$set(this.expert.permission, 'role', 'expert')
        this.$set(this.expert.permission, 'fullname', object.selectedObject.label)
      },
      clearPermission() {
        this.$set(this.expert, 'permission', {})
      },
      selfGetExpert() {
        let params = {
          contest_id: this.$route.params.id,
          expert_id: this.$route.params.expert_id
         }
        this.getExpert(params)
      },
      selfDeletePermission() {
        if (this.expert.permission.id) {
          if (!confirm('Точно хотите удалить?')) return
          this.deletePermission({ permission: this.expert.permission })
        }
        this.clearPermission()
      },
    },
    created() {
      if (this.isCurrentPage("expert_new")) {
        console.warn('New expert')
        this.$set(this.expert, 'active', true)
        this.$set(this.expert, 'permission', {})
      }
      if (this.isCurrentPage("expert_edit")) {
        console.warn('Edit expert')
        this.selfGetExpert()
      }
    }
  }
</script>
