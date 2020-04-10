export const CommonMixin = {
  methods: {
    isCurrentPage(route) {
      console.log(route)
      return this.$route.name == route
    },
    redirectTo(path, id) {
      this.$router.push({ name: path, params: { id: id }})
    },
  }
}
