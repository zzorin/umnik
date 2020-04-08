export const NotificationsMixin = {
  methods: {
    notificate(params) {
      let { type, title, text, duration } = params
      this.$notify({
        type: type,
        title: title,
        text: text,
        group: "manage",
        position: 'bottom right',
        duration: duration
      })
    }
  }
}
