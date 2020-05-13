<template>
  <div>
    <paginate :page-count='pageCount'
              v-model='currentPage'
              :container-class="'pagination'"
              :click-handler='clickHandler'
              :prevText="'&lsaquo;'"
              :nextText="'&rsaquo;'"></paginate>
  </div>
</template>

<script>
  export default {
    data: () => {
      return {}
    },
    computed: {
      currentPage: {
        get: function () {
          return this.page
        },
        set: function (value) {
          this.$emit('currentPageChanged', value)
        }
      }
    },
    props: {
      pageCount: Number,
      clickHandler: Function,
      page: {
        type: Number,
        required: true
      }
    },
  }
</script>
