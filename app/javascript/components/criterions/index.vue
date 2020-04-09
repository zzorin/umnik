<template>
  <div>
    <div v-if='isCurrentPage("criterions")'>
      <h2>Название критерия</h2>
      <input type="text" v-model='newCriterion.title'/>
      <span class='btn btn-blue mt-3' @click='selfCreateCriterion' :class="{'disabled': !newCriterion.title}">
        Добавить критерий
      </span>
      <table>
        <tr v-for='criterion in criterions'>
          <td v-if='editableCriterion.id == criterion.id'>
            <input type="text" v-model='editableCriterion.title'/>
            <span class='btn btn-blue mt-3' @click='selfUpdateCriterion(editableCriterion)'>
              Сохранить
            </span>
            <span class='btn btn-blue mt-3' @click='clearEditableCriterion'>
              Отменить
            </span>
          </td>
          <td v-if='!(editableCriterion.id == criterion.id)'>
            {{ criterion.title }}
          </td>
          <td>
            <span class='btn btn-blue mt-3' @click='setEditableCriterion(criterion)'>
              Редактировать
            </span>
          </td>
          <td>
            <span class='btn btn-blue mt-3' @click='selfDeleteCriterion(criterion)'>
              Удалить
            </span>
          </td>
        </tr>
      </table>
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
      ...mapGetters('contests', ['currentContest']),
      isCriterionsIndex() {
        return this.$route.name == 'criterions'
      }
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
        let params = {
          criterion: this.newCriterion,
          contest_id: this.currentContest.id
        }
        this.createCriterion(params).then(data => {
          if (data.status == 200) {
            this.notificate({
              title: data.body.notifications.title,
              text: data.body.notifications.text
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
