<template>
  <div>
    <div v-if='isCurrentPage("results")' class="mt-3">
      <modal name="mark-history" @before-open="getMarkHistory"
                                 @before-close='clearMarkHistory'
                                 :adaptive="true"
                                 width="70%"
                                 :classes="['overflow-auto']"
                                 :max-height='500'>
        <table class='table table-bordered' v-if='markHistory.length'>
          <thead>
            <tr>
              <th>Инициатор</th>
              <th>От имени эксперта</th>
              <th>Дата</th>
              <th>Действие</th>
              <th>Изменения</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for='version in markHistory'>
              <td>{{ version.whodunnit.fullname }}</td>
              <td>{{ version.expert }}</td>
              <td>{{ version.created_at }}</td>
              <td>{{ version.event }}</td>
              <td>
                <div v-for='(v, k) in version.changes' class='d-flex'>
                  <span>{{ k }}</span>
                  <span>{{ v }}</span>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        <p v-if='!markHistory.length' class="alert alert-danger" role="alert">История отсутствует</p>
      </modal>
      <a :href="generateRateList()" class='btn btn-blue mb-2 mr-2'>Экспорт в итоговую таблицу</a>
      <a :href="generateProtocol()" class='btn btn-blue mb-2'>Экспорт в протокол</a>
      <div><strong>Критерии отбора:</strong></div>
      {{getCriterionString()}}
      <div>
        <input type="checkbox" v-model='showExperts' name='showExperts' class="mt-3">
        <label for="showExperts">
          Разбить баллы экспертов по критериям
        </label>
      </div>
      <div class="d-flex">
        <label class="mr-2 mt-auto"><b>Сортировать по номинациям:</b></label>
        <select v-model='currentNomination' @change='updateParticipants()' class="form-control input-with-button dark-grey-select">
          <option value="all">Все</option>
          <option v-for="nomination in nominations" v-bind:value="nomination.id" class="dark-grey-select dark-grey-option">
            {{ nomination.code +'. '+nomination.title}}
          </option>
        </select>
      </div>
      <div v-if='Object.keys(marks).length !== 0' class="results-table-wrapper">
        <table class="table results-table">
          <tr>
            <th rowspan="2">№</th>
            <th rowspan="2">Организация</th>
            <th rowspan="2">ФИО участника</th>
            <th rowspan="2">Название доклада</th>
            <template v-if='showExperts' v-for='expert in experts'>
              <th :colspan='criterions.length'>{{expert.name}}</th>
            </template>
            <th rowspan="2">Итого баллов</th>
            <th rowspan="2">Количество экспертов</th>
            <th rowspan="2">Рейтинговый балл</th>
          </tr>
          <tr>
            <template v-if='showExperts' v-for='expert in experts'>
              <template v-for='index in criterions.length'>
                <th>К{{index}}</th>
              </template>
            </template>
          </tr>
          <tr v-for='(participant, key) in participants'>
            <td>
              {{ key + 1 }}
            </td>
            <td>
              {{ participant.organization }}
            </td>
            <td>
              {{ participant.name }}
            </td>
            <td>
              {{ participant.project_title }}
            </td>
            <template v-if='showExperts' v-for='expert in experts'>
              <template v-for='criterion in criterions'>
                <td>
                  <span @click='openModal(marks[participant.id][expert.id][criterion.id])' class='cursor-pointer'>
                    {{marks[participant.id][expert.id][criterion.id].grade}}
                  </span>
                </td>
              </template>
            </template>
            <td>{{marks[participant.id].marks_sum}}</td>
            <td>{{participant.experts_count}}</td>
            <td>{{marks[participant.id].rate_mark}}</td>
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
        markHistory: [],
        marks: {},
        showExperts: true,
        currentNomination: 'all'
      }
    },
    mixins: [CommonMixin],
    computed: {
      ...mapState( 'participants', ['participants']),
      ...mapState( 'criterions', ['criterions']),
      ...mapState( 'experts', ['experts']),
      ...mapState( 'nominations', ['nominations']),
      ...mapGetters('contests', ['currentContest']),
    },
    methods: {
      ...mapActions('participants', ['clearParticipants', 'getResultParticipants', 'getResultNominationParticipants']),
      ...mapActions('criterions', ['getCriterions']),
      ...mapActions('experts', ['getResultsExperts']),
      ...mapActions('marks', ['getAllMarks', 'getHistory']),
      ...mapActions('nominations', ['getNominations']),
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
        this.getResultParticipants(params)
      },
      selfGetCriterions() {
        let params = { contest_id: this.currentContest.id }
        this.getCriterions(params)
      },
      selfGetExperts() {
        let params = { contest_id: this.currentContest.id, active: true }
        this.getResultsExperts(params)
      },
      selfGetMarks() {
        let params = { contest_id: this.currentContest.id }
        this.getAllMarks(params).then(data => {
          if (data.status == 200) {
            this.marks = data.body
          }
        })
      },
      updateParticipants() {
        this.clearParticipants()
        if (this.currentNomination == 'all') {
          this.selfGetParticipants()
        } else {
          this.selfGetNominationParticipants(this.currentNomination)
        }
      },
      selfGetNominations() {
        let params = { contest_id: this.currentContest.id }
        this.getNominations(params)
      },
      selfGetNominationParticipants(nomination_id) {
        let params = {
          contest_id: this.currentContest.id,
          nomination_id: nomination_id
        }
        this.getResultNominationParticipants(params)
      },
      generateRateList() {
        return `contests/${this.currentContest.id}/generate_rate_list?nomination_id=${this.currentNomination}`
      },
      generateProtocol() {
        return `contests/${this.currentContest.id}/generate_protocol`
      },
      openModal(mark) {
        this.$modal.show('mark-history', { mark })
      },
      clearMarkHistory() {
        this.$set(this, 'markHistory', [])
      },
      getMarkHistory(event) {
        let mark = event.params.mark
        if (!mark.id) return
        let params = {
          contest_id: this.currentContest.id,
          mark_id: mark.id
        }
        this.getHistory(params).then(data => {
          this.$set(this, 'markHistory', data.history)
        })
      }
    },
    created() {
      this.selfGetParticipants()
      this.selfGetCriterions()
      this.selfGetNominations()
      this.selfGetExperts()
      this.selfGetMarks()
    }
  }
</script>
