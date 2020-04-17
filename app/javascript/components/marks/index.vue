<template>
  <div>
    <div v-if='isCurrentPage("marks")'>
      <div class='col-xs-3'>
        <ul>
          <li>
            <span @click='selfGetAllMarks()' class=''>
              Все
            </span>
          </li>
          <template v-for='nomination in nominations'>
            <li>
              <span @click='selfGetNominationParticipants(nomination.id)' class=''>
                {{ nomination.title }}
              </span>
            </li>
          </template>
        </ul>
      </div>
      <div class="col-xs-9">
        <ul v-for='participant in participants'>
          <li>
            <h2>{{participant.fullname}}</h2>
            <marks-table :participant='participant' :criterions='criterions'>
            </marks-table>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
  import { CommonMixin } from 'mixins/common'
  import MarksTable from 'components/marks/table'
  export default {
    mixins: [CommonMixin],
    computed: {
      ...mapState( 'nominations', ['nominations']),
      ...mapState( 'participants', ['participants']),
      ...mapState( 'criterions', ['criterions']),
      ...mapGetters('contests', ['currentContest'])
    },
    components: {
      MarksTable
    },
    methods: {
      ...mapActions('nominations', ['getNominations']),
      ...mapActions('participants', ['clearParticipants', 'getNominationParticipants']),
      ...mapActions('criterions', ['getCriterions']),
      selfGetNominations() {
        let params = {
          contest_id: this.currentContest.id,
        }
        this.getNominations(params)
      },
      selfGetCriterions() {
        let params = {
          contest_id: this.currentContest.id,
        }
        this.getCriterions(params)
      },
      selfGetNominationParticipants(nomination_id) {
        let params = {
          contest_id: this.currentContest.id,
          nomination_id: nomination_id
        }
        this.clearParticipants()
        this.getNominationParticipants(params)
      }
    },
    created () {
      console.warn('Marks')
      this.selfGetNominations()
      this.selfGetCriterions()
    }
  }
</script>
