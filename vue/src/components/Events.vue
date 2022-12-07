<template>
  <div>
    <router-link
      v-bind:to="{ name: 'details', params: { id: event.eventId } }"
      class="event_card"
      v-for="event in EventList"
      :key="event.eventId"
    >
      <h2 class="event" id="event_title">{{ event.name }}</h2>
      <img class="event" id="event_image" :src="event.imgUrl" alt="idk fam" />
      <p class="event" id="event_dates">
        <b>Start Date:</b> {{ DateOnly(event.startTime) }} <br />
        <b>End Date:&nbsp;&nbsp;</b> {{ DateOnly(event.endTime) }}
      </p>
      <p class="event" id="event_tag">{{ event.tag }}</p>
    </router-link>
  </div>
</template>

<script>
export default {
  name: "Events",
  methods: {
    DateOnly(date) {
      let text = date.split(" ");
      return text[0];
    },
  },
  computed: {
    EventList() {
      return this.$store.state.events;
    },
  },
};
</script>

<style>
.event_card {
  display: grid;
  grid-template-columns: 3fr 7fr 4fr;
  grid-template-areas:
    "img title dates"
    "img tag tag";
  background-color: #7ebdc2;
  margin: 16px;
  padding: 8px;
  border-radius: 12px;
}

.event{
  font-family: Verdana, Helvetica, sans-serif;
  width: fit-content;
  height: fit-content;
  margin: auto;
}

#event_title {
  grid-area: title;
  background-color: #efe6dd;
  padding: 12px;
  border-radius: 8px;
}

#event_image {
  grid-area: img;
  width: 95%;
  aspect-ratio: 1/1;
  border-radius: 12px;
}

#event_dates {
  grid-area: dates;
  background-color: #efe6dd;
  padding: 12px;
  border-radius: 12px;
}

#event_tag {
  grid-area: tag;
  background-color: #efe6dd;
  padding: 4px;
  border-radius: 4px;
  font-weight: bold;
  margin-left: 24px;
  margin-right: 24px;
}
</style>