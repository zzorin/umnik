<template>
  <div>
      <div v-if='isCurrentPage("dashboard")' class='mt-3'>
        <router-link :to="{name: 'contests'}" class="mr-2">Конкурсы</router-link>
        <router-link :to="{name: 'permissions'}">Права доступа</router-link>
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
