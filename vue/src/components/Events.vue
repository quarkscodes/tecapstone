<template>
  <div>
    <router-link
      v-bind:to="{ name: 'details', params: { id: event.eventId } }"
      v-for="event in filteredEvents"
      :key="event.eventId"
    >
      <div class="event_card">
        <p class="event" id="event_title">{{ event.name }}</p>
        <img class="event" id="event_image" :src="event.imgUrl" alt="idk fam" />
        <p class="event" id="event_dates">
          <b>Start Date:</b> {{ DateOnly(event.startTime) }} <br />
          <b>End Date:&nbsp;&nbsp;</b> {{ DateOnly(event.endTime) }}
        </p>
        <div id="event_tag_list">
          <div v-for="(event_tag, index) in eventTagsList" :key="index">
            <p class="event" id="event_tag" v-if="event_tag.eventId == event.eventId">
              {{ event_tag.tag }}
            </p>
          </div>
        </div>
      </div>
    </router-link>
  </div>
</template>

<script>
export default {
  name: "Events",
  props: ["filteredEvents", "eventTags"], //this is the new list to show
  methods: {
    DateOnly(date) {
      let text = date.split(" ");
      return text[0];
    },
  },
  computed: {
    eventTagsList() {
      return this.$store.state.eventTags;
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
  margin: 8px;
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
  width: max;
  padding: 12px;
  border-radius: 8px;
  margin-top: 4px;
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

#event_tag_list{
  grid-area: tag;
  display: flex;
}

#event_tag {
  font-size: large;
  text-align: left;
  background-color: #efe6dd;
  padding: 4px;
  padding-left: 8px;
  padding-right: 8px;
  border-radius: 6px;
  margin-left: 4px;
  margin-right: 4px;
}
</style>