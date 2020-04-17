<template>
  <div class="">
    <table>
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
          <td>{{criterion.title}}</td>
        </template>
      </tr>
    </table>
  </div>
</template>

<script>
  export default {
    props: ['participant', 'criterions'],
    methods: {
      selfGetMarks() {

      }
    },
    created () {
      console.warn('Marks table')
      this.selfGetMarks()
    }
  }
</script>
