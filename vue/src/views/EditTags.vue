<template>
  <div>
    <events v-bind:filteredEventsET="filteredEventsET" />
  </div>
</template>

<script>
import EventTagsService from "../services/EventTagsService.js";
import Events from "../components/Events.vue";

export default {
  name: "editTags",
  components: {
      Events
  },
  methods: {
    getTags() {
      EventTagsService.getEventTags()
        .then((response) => {
          this.$store.commit(("SET_EVENT_TAGS", response.data));
        })
        .catch((error) => {
          console.log(error.response.data.status);
        });
    },
  },
  computed: {
    filteredEventsET() {
      const sorted = this.$store.state.events;
      console.log("sorted = " + sorted);
      let userFilter = sorted.filter((e) => {
        return e.userId == this.$store.state.user.userId;
      });
      return userFilter;
    },
  },
};
</script>

<style>
</style>