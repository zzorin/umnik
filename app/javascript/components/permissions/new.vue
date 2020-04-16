<template>
  <div>
    <div v-if='isCurrentPage("permission_new")'>
      <h1>Добавление прав</h1>

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

      <div v-if='permission.user_id' class="form-group">
        <div class="row">
          <div class="col-lg-8">
            <b>
              <label for="">Роль</label>
            </b>
            <select v-model='permission.role'
                    @change='clearPermissionContext'
                    class="form-control dark-grey-select">
              <option v-for="(value, key) in available_roles"
                      v-bind:value="key"
                      class="dark-grey-select dark-grey-option">
                {{ value.title }}
              </option>
            </select>
          </div>
        </div>
      </div>

      <div v-if="permission.role && available_roles[permission.role].context_type"
           class="form-group">
         <div class="row">
           <div class="col-lg-8">
             <b>
               <label for="">Контекст</label>
             </b>
             <select v-model='permission.context_id'
                     @change='setContextType(permission.role)'
                     class="form-control dark-grey-select">
               <option v-for="context in available_roles[permission.role].contexts"
                       v-bind:value="context.context_id"
                       class="dark-grey-select dark-grey-option">
                 {{ context.title }}
               </option>
             </select>
           </div>
         </div>
      </div>

      <span v-if='isValidPermission()'
            class='btn btn-green mr-2'
            @click='selfCreatePermission'>
        Сохранить
      </span>
      <span class='btn btn-light-blue' @click='redirectBack'>
        Отменить
      </span>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { NotificationsMixin } from 'mixins/notifications'
  import { mapState, mapActions, mapGetters } from 'vuex'
  export default {
    data: () => {
      return {
        permission: {}
      }
    },
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState('permissions', ['available_roles'])
    },
    methods: {
      ...mapActions('permissions',
                    {
                      getAvailableRoles: 'getAvailableRoles',
                      createPermission: 'createPermission',
                      getPermissions: 'getPermissions'
                    }
                ),
      selectedUser(object) {
        this.$set(this.permission, 'user_id', object.selectedObject.id)
      },
      clearPermissionContext() {
        this.$delete(this.permission, 'context_type')
        this.$delete(this.permission, 'context_id')
      },
      setContextType(role) {
        this.$set(this.permission,
                  'context_type',
                  this.available_roles[role].context_type)
      },
      isValidPermission() {
        if (this.permission.role) {
          if (this.available_roles[this.permission.role].context_type) {
            if (this.permission.context_id) return true
          } else {
            return true
          }
        }
        return false
      },
      selfCreatePermission() {
        let params = { permission: this.permission }
        this.createPermission(params).then(data => {
          if (data.status == 200) {
            this.notificate({
              title: data.body.notifications.title,
              text: data.body.notifications.text
            })
            this.getPermissions()
            this.redirectBack()
          }
        })
      },
      redirectBack() {
        this.redirectTo('permissions')
      }
    },
    created() {
      console.warn('New permission')
      this.getAvailableRoles()
    }
  }
</script>
