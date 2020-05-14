<template>
  <div class="marks-table-wrapper">
    <table class="table">
      <tr>
        <th>Название доклада</th>
        <th>Организация</th>
        <template v-for='criterion in criterions'>
          <th>{{criterion.title}}</th>
        </template>
        <th>Суммарный балл</th>
      </tr>
      <tr>
        <td>{{participant.project_title}}</td>
        <td>{{participant.organization}}</td>
        <template v-for='criterion in criterions'>
          <td>
            <div v-if="marks[criterion.id]">
              <select v-model='marks[criterion.id].grade'
                      @change='selfUpdateMark(criterion.id)'
                      class="form-control dark-grey-select mark-slecting">
                <option value=''>-</option>
                <option v-for="grade in available_marks"
                        class="dark-grey-select dark-grey-option">
                  {{ grade }}
                </option>
              </select>
            </div>
            <div v-if="!marks[criterion.id]">
              <select v-model='new_grages[criterion.id]'
                      @change='selfCreateMark(criterion.id)'
                      class="form-control dark-grey-select mark-slecting">
                <option value=''>-</option>
                <option v-for="grade in available_marks"
                        class="dark-grey-select dark-grey-option">
                  {{ grade }}
                </option>
              </select>
            </div>
          </td>
        </template>
        <td class="mark-result">{{marks['marks_sum']}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import { NotificationsMixin } from 'mixins/notifications'
  export default {
    mixins: [NotificationsMixin],
    data() {
      return {
        marks: {},
        available_marks: [1, 2, 3, 4, 5],
        new_grages: {},
      }
    },
    props: ['participant', 'criterions', 'expert_id', 'contest_id'],
    methods: {
      ...mapActions('marks', ['getMarks', 'createMark', 'updateMark']),
      selfGetMarks() {
        let params = {
          contest_id: this.contest_id,
          participant_id: this.participant.id,
          expert_id: this.expert_id,
        }
        this.getMarks(params).then(data => {
          if (data.status == 200) {
            this.marks = data.body
          }
        })
      },
      selfCreateMark(criterion_id) {
        let params = {
          contest_id: this.contest_id,
          expert_id: this.expert_id,
          mark: {
            grade: this.new_grages[criterion_id],
            criterion_id: criterion_id,
            participant_id: this.participant.id,
            expert_id: this.expert_id
          }
        }
        this.createMark(params).then(data => {
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
            this.new_grages = {}
            this.selfGetMarks()
          }
        })
      },
      selfUpdateMark(criterion_id) {
        let params = {
          contest_id: this.contest_id,
          expert_id: this.expert_id,
          mark: this.marks[criterion_id]
        }
        this.updateMark(params).then(data => {
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
            this.selfGetMarks()
          }
        })
      }
    },
    created () {
      console.warn('Marks table')
      this.selfGetMarks()
    }
  }
</script>
