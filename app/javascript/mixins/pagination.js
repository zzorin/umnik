export const PaginationMixin = {
  computed: {
    paginationInfoIsLoaded() {
      console.log(this.paginationInfo)
      return this.paginationInfo && this.paginationInfo.total_pages > 1
    }
  }
}
