<template>
  <div>
    <div class="event_card" v-for="event in EventList" :key="event.eventId">
      <h2 class="event" id="event_title">{{ event.name }}</h2>
      <img class="event" id="event_image" :src="event.imgUrl" alt="idk fam" />
      <p class="event" id="event_start">Start Date: {{ event.startTime }}</p>
      <p class="event" id="event_end">End Date: {{ event.endTime }}</p>
      <p class="event" id="event_tag">Tags: {{ event.tag }}</p>
    </div>
  </div>
</template>

<script>
import eventsService from "../services/EventsService.js";

export default {
  name: "Events",
  created() {
    eventsService
      .getEvents()
      .then((response) => {
        this.$store.commit("SET_EVENTS", response.data);
      })
      .catch((error) => {
        console.log(error.response.data.status);
      });
  },
  components: {},

  methods: {},
  computed: {
    EventList() {
      return this.$store.state.events;
    },
  },
};
</script>

<style>
#event_title {
  grid-area: title;
  background-color: #EFE6DD
}
#event_description {
  grid-area: description;
}
#event_image {
  height: 100px;
  width: 100px;
  grid-area: img;
}
#event_start {
  grid-area: start;
}
#event_end {
  grid-area: end;
}
#event_tag {
  grid-area: tag;
}

.event_card {
  border: 2px solid black;
  margin: 21px;
  background-color: #7EBDC2;
  display: grid;
  grid-template-columns: 1fr 3fr 2fr;
  grid-template-areas:
    'img title start'
    'img title end'
    'img tag tag'
}
</style>