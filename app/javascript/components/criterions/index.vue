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
          <td>
            <router-link :to="{name: 'criterion_show', params: { id: criterion.id }}">
              {{ criterion.title }}
            </router-link>
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
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState( 'criterions', ['criterions', 'newCriterion']),
      ...mapGetters('contests', ['currentContest']),
      isCriterionsIndex() {
        return this.$route.name == 'criterions'
      }
    },
    methods: {
      ...mapActions('criterions', ['getCriterions', 'createCriterion', 'clearNewCriterion', 'deleteCriterion']),
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
      selfDeleteCriterion(criterion) {
        if (!confirm('Точно хотите удалить?')) return
        this.deleteCriterion({ criterion }).then(data => {
          this.selfGetCriterions()
        })
      }
    },
    created() {
      console.warn('Критерии')
      this.selfGetCriterions()
    }
  }
</script>
