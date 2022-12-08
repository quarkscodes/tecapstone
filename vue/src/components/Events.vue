<template>
  <div>
    <router-link
      v-bind:to="{ name: 'details', params: { id: event.eventId } }"
      class="event_card"
      v-for="event in EventList"
      :key="event.eventId"
    >
      <div>
        <p class="event" id="event_title">{{ event.name }}</p>
        <img class="event" id="event_image" :src="event.imgUrl" alt="idk fam" />
        <p class="event" id="event_dates">
          <b>Start Date:</b> {{ DateOnly(event.startTime) }} <br />
          <b>End Date:&nbsp;&nbsp;</b> {{ DateOnly(event.endTime) }}
        </p>
        <p class="event" id="event_tag">{{ event.tag }}</p>
      </div>
    </router-link>
  </div>
</template>

<script>
export default {
  name: "Events",
  props: ['zipcode'],
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
  grid-column-gap: 16px;
  grid-template-areas:
    "img title dates"
    "img tag tag";
  background-color: #7ebdc2;
  margin: 16px;
  padding: 8px;
  border-radius: 12px;
}

.event {
  width: fit-content;
  height: fit-content;
  margin: auto;
}

#event_title {
  grid-area: title;
  font-size: x-large;
  font-weight: bold;
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
  font-size: large;
  background-color: #efe6dd;
  padding: 8px;
  border-radius: 12px;
}

#event_tag {
  grid-area: tag;
  font-size: large;
  text-align: left;
  background-color: #efe6dd;
  padding: 4px;
  padding-left: 8px;
  padding-right: 8px;
  border-radius: 6px;
  margin-left: 0px;
}
</style>