<template>
  <div>
      <div v-if='isCurrentPage("dashboard")'>
        <router-link :to="{name: 'contests'}">Конкурсы</router-link>
      </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  export default {
    mixins: [CommonMixin],
    computed: {
    }
  }
</script>
