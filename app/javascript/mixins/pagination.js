export const PaginationMixin = {
  computed: {
    paginationInfoIsLoaded() {
      return this.paginationInfo && this.paginationInfo.total_pages > 1
    }
  }
}
