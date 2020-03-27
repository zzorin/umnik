<template>
  <div>
    <div v-if='isCurrentPage("criterions")'>
      <h1>Критерии</h1>
      <table>
        <tr>
          <th>Название</th>
          <th colspan="2"></th>
        </tr>

        <tr v-for='criterion in criterions'>
          <td>
            <router-link :to="{name: 'criterion_show', params: { id: criterion.id }}">
              {{ criterion.title }}
            </router-link>
          </td>
        </tr>
      </table>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions } from 'vuex'
  import { CommonMixin } from 'mixins/common'

  export default {
    mixins: [CommonMixin],
    computed: {
      ...mapState( 'criterions', ['criterions']),
      isCriterionsIndex() {
        return this.$route.name == 'criterions'
      }
    },
    methods: {
      criterionsRequester() {
        // console.log(this.$route.params.id)
        this.request(this.$route.params.id)
      },
      ...mapActions('criterions', ['request'])
    },
    created() {
      console.warn('Критерии')
      this.criterionsRequester()
    }
  }
</script>
