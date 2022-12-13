<template>
  <div>
    <events v-bind:yourEvents="yourEvents"> </events>
  </div>
</template>

<script>
import Events from "../components/Events.vue";
export default {
  name: "deleteEvent",
  components: {
    Events,
  },
  computed: {
    yourEvents() {
      let EList = this.$store.state.events;
      let id = this.$store.state.user.userId;
      let userFilter = EList.filter((e) => {
        console.log(e);
        return e.userId == id;
      });
      return userFilter;
    },
  },
};
</script>

<style>
</style>