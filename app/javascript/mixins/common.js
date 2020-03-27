export const CommonMixin = {
  methods: {
    isCurrentPage(route) {
      console.log(route)
      return this.$route.name == route
    }
  }
}
