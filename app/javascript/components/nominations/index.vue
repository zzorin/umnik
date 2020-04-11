<template>
  <div>
    <div v-if='isCurrentPage("nominations")' class="mt-4">
      <div class="row">
        <div class="col-lg-3">
          <label><strong>Код номинации</strong></label>
          <input type="text" class="form-control" v-model='newNomination.code'/>
        </div>
        <div class="col-lg-6">
          <label><strong>Название номинации</strong></label>
          <input type="text" class="form-control" v-model='newNomination.title'/>
        </div>
        <div class="col-lg-3">
          <span class='btn btn-blue margin-top-30' @click='selfCreateNomination' :class="{'disabled': (!newNomination.title || !newNomination.code)}">
              Добавить номинацию
          </span>
        </div>
      </div>

      <div class="nominations-list">
        <div v-for='nomination in nominations'>
          <div  v-if='!(editableNomination.id == nomination.id)' class="mb-2">
            <span>
              {{ nomination.code }}
              {{ nomination.title }}
            </span>
            <span class='cursor-pointer' @click='setEditableNomination(nomination)'>
              <svg class="bi bi-pencil ml-2" width="16px" height="16px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M11.293 1.293a1 1 0 011.414 0l2 2a1 1 0 010 1.414l-9 9a1 1 0 01-.39.242l-3 1a1 1 0 01-1.266-1.265l1-3a1 1 0 01.242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z" clip-rule="evenodd"/>
                <path fill-rule="evenodd" d="M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 00.5.5H4v.5a.5.5 0 00.5.5H5v.5a.5.5 0 00.5.5H6v-1.5a.5.5 0 00-.5-.5H5v-.5a.5.5 0 00-.5-.5H3z" clip-rule="evenodd"/>
              </svg>
            </span>
            <span class='cursor-pointer' @click='selfDeleteNomination(nomination)'>
              <svg class="bi bi-x" width="26px" height="26px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 010 .708l-7 7a.5.5 0 01-.708-.708l7-7a.5.5 0 01.708 0z" clip-rule="evenodd"/>
                <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 000 .708l7 7a.5.5 0 00.708-.708l-7-7a.5.5 0 00-.708 0z" clip-rule="evenodd"/>
              </svg>
            </span>
          </div>

          <div v-if='editableNomination.id == nomination.id' class="mb-2">
            <div class="row">
              <div class="col-lg-3"><input type="text" class="form-control" v-model='editableNomination.code'/></div>
              <div class="col-lg-6"><input type="text" class="form-control" v-model='editableNomination.title'/></div>
              <span class='btn btn-green mr-2 ml-3' @click='selfUpdateNomination(editableNomination)'>
                Сохранить
              </span>
              <span class='btn btn-light-blue' @click='clearEditableNomination'>
                Отменить
              </span>
            </div>
          </div>

        </div>
      </div>
    </div>

    <router-view></router-view>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
  import { CommonMixin } from 'mixins/common'
  import { NotificationsMixin } from 'mixins/notifications'

  export default {
    data() {
      return {
        editableNomination: {}
      }
    },
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState( 'nominations', ['nominations', 'newNomination']),
      ...mapGetters('contests', ['currentContest'])
    },
    methods: {
      ...mapActions('nominations', ['getNominations', 'createNomination', 'clearNewNomination', 'deleteNomination', 'updateNomination']),
      selfGetNominations() {
        let params = {
          contest_id: this.currentContest.id,
        }
        this.getNominations(params)
      },
      selfCreateNomination() {
        let params = {
          nomination: this.newNomination,
          contest_id: this.currentContest.id
        }
        this.createNomination(params).then(data => {
          if (data.status == 200) {
            this.notificate({
              title: data.body.notifications.title,
              text: data.body.notifications.text
            })
            this.clearNewNomination()
            this.selfGetNominations()
          }
        })
      },
      selfUpdateNomination(nomination) {
        this.updateNomination({ nomination }).then(data => {
          if (data.status == 'error') {
            this.notificate({
              title: data.errors.title,
              text: data.errors.text,
              type: 'error'
            })
            return
          }
          if (data.status == 200) {
            this.notificate({
              title: data.notifications.title,
              text: data.notifications.text,
              type: 'warn'
            })
            this.clearEditableNomination()
            this.selfGetNominations()
          }
        })
      },
      selfDeleteNomination(nomination) {
        if (!confirm('Точно хотите удалить?')) return
        this.deleteNomination({ nomination }).then(data => {
          this.selfGetNominations()
        })
      },
      setEditableNomination(nomination) {
        this.editableNomination = {...nomination }
      },
      clearEditableNomination() {
        this.editableNomination = {}
      }
    },
    created() {
      console.warn('Номинации')
      this.selfGetNominations()
    }
  }
</script>
