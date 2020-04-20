<template>
  <div class="marks-wrapper mt-4">
    <div v-if='isCurrentPage("marks")'>
      <div class="row">
      <div class='col-md-3 col-lg-2 left-menu-nav'>
        <ul class="nav nav-pills">
          <li class="nav-item">
            <a class="nav-link cursor-pointer" @click='selfGetParticipants()' v-bind:class="{active : isActive == '0'}">
              Все
            </a>
          </li>
          <template v-for='nomination in nominations'>
            <li class="nav-item">
              <a @click='selfGetNominationParticipants(nomination.id)' v-bind:class="{active : nomination.id == isActive}"
                 class="nav-link cursor-pointer">
                {{ nomination.title }}
              </a>
            </li>
          </template>
        </ul>
      </div>
      <div class="col-md-9 col-lg-10">
        <ul v-for='participant in participants' class="list-unstyled">
          <li>
            <h2>{{participant.fullname}}</h2>
            <marks-table
              :contest_id='currentContest.id'
              :participant='participant'
              :criterions='criterions'
              :expert_id='$route.params.expert_id'>
            </marks-table>
          </li>
        </ul>
      </div>
    </div>
  </div>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
  import { CommonMixin } from 'mixins/common'
  import MarksTable from 'components/marks/table'
  export default {
    data() {
      return {
        isActive: ''
      }
    },
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
      ...mapActions('participants',
        ['clearParticipants', 'getParticipants', 'getNominationParticipants']
      ),
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
      selfGetParticipants() {
        let params = { contest_id: this.currentContest.id }
        this.clearParticipants()
        this.getParticipants(params)
        this.isActive = '0'
      },
      selfGetNominationParticipants(nomination_id) {
        let params = {
          contest_id: this.currentContest.id,
          nomination_id: nomination_id
        }
        this.clearParticipants()
        this.getNominationParticipants(params)
        this.isActive = nomination_id
      }
    },
    created () {
      this.selfGetNominations()
      this.selfGetCriterions()
      this.selfGetParticipants()
    }
  }
</script>
