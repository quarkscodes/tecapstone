<template>
  <div class="event_details" v-if="event">
    <p class="details" id="details_title">{{ event.name }}</p>
    <img class="details" id="details_image" :src="event.imgUrl" alt="idk fam" />
    <p class="details" id="details_start">
      <b>Start Date:</b> {{ event.startTime }}
    </p>
    <p class="details" id="details_end"><b>End Date:</b> {{ event.endTime }}</p>
    <p class="details" id="details_duration">
      <b>Duration:</b> duration goes here
    </p>
    <p class="details" id="details_tag">{{ event.tag }}</p>
    <p class="details" id="details_location">
      <b>Location:</b> {{ event.address }}, {{ event.city }}, {{ event.state }},
      {{ event.zip }}
    </p>
    <p class="details" id="details_description">{{ event.description }}</p>
  </div>
</template>

<script>
import eventsService from "@/services/EventsService.js";

export default {
  data() {
    return { event: {} };
  },
  created() {
    eventsService
      .getEvents()
      .then((response) => {
        this.$store.commit("SET_EVENTS", response.data);
        this.event = response.data.find((item) => {
          return item.eventId == this.$route.params.id;
        });
      })
      .catch((error) => {
        console.log(error.response.data.status);
      });
  },
};
</script>

<style>
.event_details {
  display: grid;
  grid-template-columns: 3fr 2fr;
  grid-column-gap: 8px;
  grid-template-areas:
    "title img"
    "tag img"
    "start img"
    "end img"
    "duration img"
    "location img"
    "desc desc";
  background-color: #efe6dd;
  border: 4px solid #7ebdc2;
  margin: 16px;
  padding: 24px;
  border-radius: 12px;
}

#details_title {
  grid-area: title;
  text-align: center;
  font-size: xx-large;
  font-weight: bold;
}

#details_image {
  grid-area: img;
  border: 4px solid #7ebdc2;
  width: 100%;
  aspect-ratio: 1/1;
  border-radius: 12px;
}

#details_start {
  grid-area: start;
  text-align: left;
  font-size: large;
}

#details_end {
  grid-area: end;
  text-align: left;
  font-size: large;
}

#details_duration {
  grid-area: duration;
  text-align: left;
  font-size: large;
}

#details_tag {
  grid-area: tag;
  font-size: large;
  text-align: center;
  border: 4px solid #7ebdc2;
  margin: auto;
  padding: 4px;
  padding-left: 10px;
  padding-right: 10px;
  border-radius: 6px;
}

#details_location {
  grid-area: location;
  text-align: left;
  font-size: large;
}

#details_description {
  grid-area: desc;
  display: flex;
  align-content: left;
  text-align: left;
  font-size: large;
}
</style>