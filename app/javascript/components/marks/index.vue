<template>
  <div class="marks-wrapper mt-4">
    <div v-if='isCurrentPage("marks")'>
      <div class="row">
      <div class='col-md-3 col-lg-2 left-menu-nav'>
        <ul class="nav nav-pills">
          <li class="nav-item">
            <a class="nav-link cursor-pointer" @click='selfGetParticipants()' v-bind:class="{active : activeNomination == false}">
              Все
            </a>
          </li>
          <template v-for='nomination in nominations'>
            <li class="nav-item">
              <a @click='selfGetNominationParticipants(nomination.id)' v-bind:class="{active : nomination.id == activeNomination}"
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
            <h2>{{participant.name}}</h2>
            <marks-table
              :contest_id='currentContest.id'
              :participant='participant'
              :criterions='criterions'
              :expert_id='$route.params.expert_id'>
            </marks-table>
          </li>
        </ul>
        <pagination :page-count='paginationInfo.total_pages'
              :page='paginationInfo.current_page'
              :click-handler='paginateHandler'
              v-if='paginationInfoIsLoaded'>
        </pagination>
      </div>
    </div>
  </div>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
  import Pagination from 'components/common/pagination'
  import { PaginationMixin } from 'mixins/pagination'
  import { CommonMixin } from 'mixins/common'
  import MarksTable from 'components/marks/table'
  export default {
    data() {
      return {
        activeNomination: ''
      }
    },
    mixins: [CommonMixin, PaginationMixin],
    computed: {
      ...mapState( 'nominations', ['nominations']),
      ...mapState( 'participants', ['participants', 'paginationInfo']),
      ...mapState( 'criterions', ['criterions']),
      ...mapGetters('contests', ['currentContest'])
    },
    components: {
      MarksTable,
      Pagination
    },
    methods: {
      ...mapActions('nominations', ['getActiveNominations']),
      ...mapActions('participants',
        ['clearParticipants', 'getParticipants', 'getNominationParticipants']
      ),
      ...mapActions('criterions', ['getCriterions']),
      selfGetNominations() {
        let params = {
          contest_id: this.currentContest.id,
        }
        this.getActiveNominations(params)
      },
      selfGetCriterions() {
        let params = {
          contest_id: this.currentContest.id,
        }
        this.getCriterions(params)
      },
      selfGetParticipants(page = 0) {
        let params = {
          contest_id: this.currentContest.id,
          page: page,
          active: true
        }
        this.clearParticipants()
        this.getParticipants(params)
        this.activeNomination = false
      },
      paginateHandler(page) { this.selfGetParticipants(page) },
      selfGetNominationParticipants(nomination_id) {
        let params = {
          contest_id: this.currentContest.id,
          nomination_id: nomination_id
        }
        this.clearParticipants()
        this.getNominationParticipants(params)
        this.activeNomination = nomination_id
      }
    },
    created () {
      this.selfGetNominations()
      this.selfGetCriterions()
      this.selfGetParticipants()
    }
  }
</script>
