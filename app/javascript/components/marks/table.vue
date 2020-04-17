<template>
  <div class="marks-table-wrapper">
    <table class="table">
      <tr>
        <th>Название доклада</th>
        <th>Организация</th>
        <th>Описание проекта</th>
        <template v-for='criterion in criterions'>
          <th>{{criterion.title}}</th>
        </template>
        <th>Суммарный балл</th>
      </tr>
      <tr>
        <td>{{participant.project_title}}</td>
        <td>{{participant.organization}}</td>
        <td>{{participant.project_info}}</td>
        <template v-for='criterion in criterions'>
          <td>
            <div v-if="marks[criterion.id]">
              {{marks[criterion.id].grade}}
            </div>
          </td>
        </template>
        <td></td>
      </tr>
    </table>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
        marks: {}
      }
    },
    props: ['participant', 'criterions', 'expert_id', 'contest_id'],
    methods: {
      ...mapActions('marks', ['getMarks']),
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
      }
    },
    created () {
      console.warn('Marks table')
      this.selfGetMarks()
    }
  }
</script>
