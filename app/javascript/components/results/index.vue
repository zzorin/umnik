<template>
  <div>
    <div v-if='isCurrentPage("results")' class="mt-3">
      <span class='btn btn-blue'>
        <a :href="generateRateList()">Экспорт в итоговую таблицу</a>
      </span>
      <div><strong>Критерии отбора:</strong></div>
      {{getCriterionString()}}
      <div class="results-table-wrapper">
        <table class="table results-table">
          <tr>
            <th rowspan="2"></th>
            <th rowspan="2">№</th>
            <th rowspan="2">Организация</th>
            <th rowspan="2">ФИО участника</th>
            <th rowspan="2">Название доклада</th>
            <template v-for='expert in experts'>
              <th :colspan='criterions.length'>{{expert.shortname}}</th>
            </template>
            <th rowspan="2">Итого баллов</th>
            <th rowspan="2">Количество экспертов</th>
            <th rowspan="2">Рейтинговый балл</th>
          </tr>
          <tr>
            <template v-for='expert in experts'>
              <template v-for='index in criterions.length'>
                <th>К{{index}}</th>
              </template>
            </template>
          </tr>
          <tr v-for='(participant, key) in participants'>
            <td></td>
            <td>
              {{ key + 1 }}
            </td>
            <td>
              {{ participant.organization }}
            </td>
            <td>
              {{ participant.shortname }}
            </td>
            <td>
              {{ participant.project_title }}
            </td>
            <template v-for='expert in experts'>
              <template v-for='criterion in criterions'>
                <td>{{marks[participant.id][expert.id][criterion.id].grade}}</td>
              </template>
            </template>
            <td>{{marks[participant.id].marks_sum}}</td>
            <td>{{experts.length}}</td>
            <td>{{marks[participant.id].marks_sum / experts.length}}</td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { mapState, mapActions, mapGetters} from 'vuex'
  export default {
    data() {
      return {
        marks: {}
      }
    },
    mixins: [CommonMixin],
    computed: {
      ...mapState( 'participants', ['participants']),
      ...mapState( 'criterions', ['criterions']),
      ...mapState( 'experts', ['experts']),
      ...mapGetters('contests', ['currentContest'])
    },
    methods: {
      ...mapActions('participants', ['getParticipants']),
      ...mapActions('criterions', ['getCriterions']),
      ...mapActions('experts', ['getExperts']),
      ...mapActions('marks', ['getAllMarks']),
      getCriterionString() {
        let criterion_string = ''
        for (let [key, criterion] of Object.entries(this.criterions)) {
          criterion_string += 'K'+(parseInt(key)+1) +'-' + criterion.title
          if (key != (this.criterions.length - 1)) { criterion_string += ', ' }
        }
        return criterion_string
      },
      selfGetParticipants() {
        let params = { contest_id: this.currentContest.id }
        this.getParticipants(params)
      },
      selfGetCriterions() {
        let params = { contest_id: this.currentContest.id }
        this.getCriterions(params)
      },
      selfGetExperts() {
        let params = { contest_id: this.currentContest.id }
        this.getExperts(params)
      },
      selfGetMarks() {
        let params = { contest_id: this.currentContest.id }
        this.getAllMarks(params).then(data => {
          if (data.status == 200) {
            this.marks = data.body
          }
        })
      },
      generateRateList() {
        return `contests/${this.currentContest.id}/results/generate_rate_list`
      }
    },
    created() {
      this.selfGetParticipants()
      this.selfGetCriterions()
      this.selfGetExperts()
      this.selfGetMarks()
    }
  }
</script>
