<template>
  <div>
    <div v-if='isCurrentPage("contests")' class="contests-list margin-bottom-40">
      <h1>Список конкурсов</h1>
      <template v-if='access_rules.contests.new'>
        <div class="mb-1"><strong>Название конкурса</strong><span class="text-danger">*</span></div>
        <div class="d-flex">
          <input type="text"
                 class="input-with-button form-control"
                 v-model='newContest.title'/>
        </div>
        <div class="mb-1 mt-3"><strong>Период проведения</strong><span class="text-danger">*</span></div>
        <div class="d-flex">
          <datepicker v-model='newContest.starts_on'
            class='mr-3'
            :value='newContest.starts_on'
            :monday-first='true'
            placeholder='Дата начала'
            input-class='form-control background-color-white-important'
            :language='ru' />
          <datepicker v-model='newContest.ends_on'
            class='mr-3'
            :value='newContest.ends_on'
            :monday-first='true'
            placeholder='Дата окончания'
            input-class='form-control background-color-white-important'
            :language='ru' />
        </div>
        <button type="button"
                class='btn btn-blue mt-3'
                @click='selfCreateContest'
                :disabled='!(newContest.title && newContest.starts_on &&  newContest.ends_on)'>
          Добавить конкурс
        </button>
      </template>

      <div class="contests-list-table">
        <table class="table">
          <thead>
            <tr>
              <th>Название конкурса</th>
              <th>Дата начала</th>
              <th>Дата окончания</th>
              <th>Действия</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for='contest in contests'>
              <template  v-if='!(editableContest.id == contest.id)'>
                <td>
                  <router-link v-if="(contest.is_active || access_rules.contests.manage)"
                  :to="{name: 'experts', params: { id: contest.id }}">
                    {{ contest.title }}
                  </router-link>
                  <template v-if="!(contest.is_active || access_rules.contests.manage)">
                    {{ contest.title }} (закончен)
                  </template>
                </td>
                <td>
                  {{ contest.starts_on_format }}
                </td>
                <td>
                  {{ contest.ends_on_format }}
                </td>
                <td>
                  <span v-if='access_rules.contests.update'
                        class='cursor-pointer'
                        @click='setEditableContest(contest)'>
                    <svg class="bi bi-pencil" width="16px" height="16px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd" d="M11.293 1.293a1 1 0 011.414 0l2 2a1 1 0 010 1.414l-9 9a1 1 0 01-.39.242l-3 1a1 1 0 01-1.266-1.265l1-3a1 1 0 01.242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z" clip-rule="evenodd"/>
                      <path fill-rule="evenodd" d="M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 00.5.5H4v.5a.5.5 0 00.5.5H5v.5a.5.5 0 00.5.5H6v-1.5a.5.5 0 00-.5-.5H5v-.5a.5.5 0 00-.5-.5H3z" clip-rule="evenodd"/>
                    </svg>
                  </span>
                  <span v-if='access_rules.contests.destroy'
                        @click='selfDeleteContest(contest)'
                        class='cursor-pointer'>
                    <svg class="bi bi-x" width="26px" height="26px" viewBox="0 0 16 16" fill="#0390C8" xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 010 .708l-7 7a.5.5 0 01-.708-.708l7-7a.5.5 0 01.708 0z" clip-rule="evenodd"/>
                      <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 000 .708l7 7a.5.5 0 00.708-.708l-7-7a.5.5 0 00-.708 0z" clip-rule="evenodd"/>
                    </svg>
                  </span>
                </td>
              </template>
              <template  v-if='(editableContest.id == contest.id)'>
                <td>
                  <input type="text" v-model='editableContest.title'/>
                </td>
                <td class="contests-table">
                  <datepicker v-model='editableContest.starts_on'
                    :value='editableContest.starts_on'
                    :monday-first='true'
                    placeholder='Дата начала'
                    input-class='form-control background-color-white-important'
                    :language='ru' />
                </td>
                <td>
                  <datepicker v-model='editableContest.ends_on'
                    :value='editableContest.ends_on'
                    :monday-first='true'
                    placeholder='Дата окончания'
                    input-class='form-control background-color-white-important'
                    :language='ru' />
                </td>
                <td>
                  <span class='btn btn-green mr-2'
                        @click='selfUpdateContest(editableContest)'>
                    Сохранить
                  </span>
                  <span class='btn btn-light-blue' @click='clearEditableContest'>
                    Отменить
                  </span>
                </td>
              </template>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { NotificationsMixin } from 'mixins/notifications'
  import { mapState, mapMutations, mapActions } from 'vuex'
  import datepickerRuLocale from 'vuejs-datepicker/dist/locale/translations/ru'

  export default {
    data: () => {
      return {
        ru: datepickerRuLocale,
        editableContest: {}
      }
    },
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState( 'contests', ['contests', 'newContest'])
    },
    methods: {
      ...mapActions('contests', ['clearNewContest', 'updateContest', 'getContests', 'createContest', 'deleteContest']),
      contestsRequester() {
        this.getContests()
      },
      selfCreateContest() {
        let params = { contest: this.newContest }
        this.createContest(params).then(data => {
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
            this.clearNewContest()
            this.getContests()
          }

        })
      },
      selfDeleteContest(contest) {
        if (!confirm('Точно хотите удалить?')) return
        this.deleteContest({ contest }).then(data => {
          this.getContests()
        })
      },
      selfUpdateContest(contest) {
        this.updateContest({ contest }).then(data => {
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
            this.clearEditableContest()
            this.contestsRequester()
          }
        })
      },
      setEditableContest(contest) {
        this.editableContest = {...contest }
      },
      clearEditableContest() {
        this.editableContest = {}
      }
    },
    created() {
      console.warn('Конкурсы')
      this.contestsRequester()
    }
  }
</script>
