<template>
  <div>
    <div v-if='isCurrentPage("permissions")'>
      <h1>Права доступа</h1>
      <router-link tag="span"
                   class="btn btn-blue mb-3"
                   :to="{name: 'permission_new'} "
                  >
        Добавить права
      </router-link>
      <div>
        <table class="table">
          <tr>
            <th>ФИО</th>
            <th>Роль</th>
            <th>Действия</th>
          </tr>
          <tr v-for='permission in permissions'>
            <td>
              {{ permission.fullname }}
            </td>
            <td>
              {{ permission.text_role }}
            </td>
            <td>
              <span @click='selfDeletePermission(permission)' class='cursor-pointer'>
                <svg class="bi bi-x" width="26px" height="26px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 010 .708l-7 7a.5.5 0 01-.708-.708l7-7a.5.5 0 01.708 0z" clip-rule="evenodd"/>
                  <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 000 .708l7 7a.5.5 0 00.708-.708l-7-7a.5.5 0 00-.708 0z" clip-rule="evenodd"/>
                </svg>
              </span>
            </td>
          </tr>
        </table>
      </div>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { mapActions, mapState } from 'vuex'
  export default {
    mixins: [CommonMixin],
    computed: {
      ...mapState('permissions', ['permissions'])
    },
    methods: {
      ...mapActions('permissions',
                    {
                      getPermissions: 'getPermissions',
                      deletePermission: 'deletePermission'
                    }
                  ),
      selfDeletePermission(permission) {
        if (!confirm('Точно хотите удалить?')) return
        this.deletePermission({ permission }).then(data => {
          this.getPermissions()
        })
      },
    },
    created() {
      console.warn('Permissions')
      this.getPermissions()
    }
  }
</script>
