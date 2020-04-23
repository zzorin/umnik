<template>
  <div>
    <div v-if='isCurrentPage("criterions")'>
      <div class="mt-4 mb-1"><strong>Название критерия</strong></div>
      <div class="d-flex">
        <input type="text" class="form-control input-with-button" v-model='newCriterion.title'/>
        <button type="button"
                class='btn btn-blue'
                @click='selfCreateCriterion'
                :disabled='!newCriterion.title'>
            Добавить критерий
        </button>
      </div>

      <div class="criterions-list">
        <div v-for='criterion in criterions'>

          <ul  v-if='!(editableCriterion.id == criterion.id)' class="mb-2 list-unstyled">
            <li>
              {{ criterion.title }}

              <span class='cursor-pointer ml-2' @click='setEditableCriterion(criterion)'>
                <svg class="bi bi-pencil" width="16px" height="16px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd" d="M11.293 1.293a1 1 0 011.414 0l2 2a1 1 0 010 1.414l-9 9a1 1 0 01-.39.242l-3 1a1 1 0 01-1.266-1.265l1-3a1 1 0 01.242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z" clip-rule="evenodd"/>
                  <path fill-rule="evenodd" d="M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 00.5.5H4v.5a.5.5 0 00.5.5H5v.5a.5.5 0 00.5.5H6v-1.5a.5.5 0 00-.5-.5H5v-.5a.5.5 0 00-.5-.5H3z" clip-rule="evenodd"/>
                </svg>
              </span>
              <span class='cursor-pointer' @click='selfDeleteCriterion(criterion)'>
                <svg class="bi bi-x" width="26px" height="26px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 010 .708l-7 7a.5.5 0 01-.708-.708l7-7a.5.5 0 01.708 0z" clip-rule="evenodd"/>
                  <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 000 .708l7 7a.5.5 0 00.708-.708l-7-7a.5.5 0 00-.708 0z" clip-rule="evenodd"/>
                </svg>
              </span>
            </li>
          </ul>

          <div v-if='editableCriterion.id == criterion.id' class="d-flex mb-2">
            <input type="text" class="form-control input-with-button" v-model='editableCriterion.title'/>
            <span class='btn btn-green mr-2' @click='selfUpdateCriterion(editableCriterion)'>
              Сохранить
            </span>
            <span class='btn btn-light-blue' @click='clearEditableCriterion'>
              Отменить
            </span>
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
        editableCriterion: {}
      }
    },
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState( 'criterions', ['criterions', 'newCriterion']),
      ...mapGetters('contests', ['currentContest'])
    },
    methods: {
      ...mapActions('criterions', ['getCriterions', 'createCriterion', 'clearNewCriterion', 'deleteCriterion', 'updateCriterion']),
      selfGetCriterions() {
        let params = {
          contest_id: this.currentContest.id,
        }
        this.getCriterions(params)
      },
      selfCreateCriterion() {
        this.$set(this.newCriterion, 'contest_id', this.currentContest.id)
        let params = {
          criterion: this.newCriterion,
          contest_id: this.currentContest.id
        }
        this.createCriterion(params).then(data => {
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
              text: data.notifications.text
            })
            this.clearNewCriterion()
            this.selfGetCriterions()
          }
        })
      },
      selfUpdateCriterion(criterion) {
        this.updateCriterion({ criterion }).then(data => {
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
            this.clearEditableCriterion()
            this.selfGetCriterions()
          }
        })
      },
      selfDeleteCriterion(criterion) {
        if (!confirm('Точно хотите удалить?')) return
        this.deleteCriterion({ criterion }).then(data => {
          this.selfGetCriterions()
        })
      },
      setEditableCriterion(criterion) {
        this.editableCriterion = {...criterion }
      },
      clearEditableCriterion() {
        this.editableCriterion = {}
      }
    },
    created() {
      console.warn('Критерии')
      this.selfGetCriterions()
    }
  }
</script>
