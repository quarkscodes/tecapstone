<template>
  <div class="event_details" v-if="event">
    <p class="details" id="details_title">{{ event.name }}</p>
    <img
      class="details"
      id="details_image"
      :src="event.imgUrl"
      alt="loading..."
    />
    <p class="details" id="details_start">
      <b>Start Date:</b> {{ event.startTime }}
    </p>
    <p class="details" id="details_end"><b>End Date:</b> {{ event.endTime }}</p>
    <div id="details_tag_list">
      <div v-for="(event_tag, index) in eventTagsList" :key="index">
        <li id="details_tag" v-if="event_tag.eventId == event.eventId">
          {{ event_tag.tag }}
        </li>
      </div>
    </div>
    <p class="details" id="details_location">
      <b>Location:</b> {{ event.address }}, {{ event.city }}, {{ event.state }},
      {{ event.zip }}
    </p>
    <p class="details" id="details_description">{{ event.description }}</p>
  </div>
</template>

<script>
import eventsService from "@/services/EventsService.js";
import eventTagsService from "@/services/EventTagsService.js";

export default {
  data() {
    return {
      event: {},
      eventTagsList: [],
    };
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
    eventTagsService
      .getEventTags()
      .then((response) => {
        this.$store.commit("SET_EVENT_TAGS", response.data);
        this.eventTagsList = response.data;
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
  grid-column-gap: 16px;
  grid-template-areas:
    "title img"
    "tag img"
    "start img"
    "end img"
    "location img"
    "desc desc";
  background-color: #7ebdc2;
  margin: 16px;
  padding: 24px;
  border-radius: 12px;
  border: 3px solid #275053;
}

#details_title {
  grid-area: title;
  background-color: #efe6dd;
  text-align: center;
  font-size: xx-large;
  font-weight: bold;
  width: auto;
  padding: 8px;
  margin: 16px 0px;
  margin-top: 0px;
  border-radius: 8px;
}

#details_image {
  grid-area: img;
  background-color: #efe6dd;
  width: 100%;
  aspect-ratio: 1/1;
  object-fit: contain;
  border-radius: 12px;
  border-radius: 12px;
}

#details_start {
  grid-area: start;
  text-align: left;
  font-size: large;
  background-color: #efe6dd;
  width: auto;
  padding: 8px;
  border-radius: 8px;
}

#details_end {
  grid-area: end;
  text-align: left;
  font-size: large;
  margin-top: 8px;
  background-color: #efe6dd;
  width: auto;
  padding: 8px;
  border-radius: 8px;
}

#details_tag_list {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  margin-top: 0px;
  margin-bottom: 8px;
}

#details_tag {
  grid-area: tag;
  font-size: large;
  text-align: center;
  padding: 4px;
  padding-left: 10px;
  padding-right: 10px;
  border-radius: 6px;
  border-top-left-radius: 25px 10px;
  border-bottom-left-radius: 25px 10px;
  margin: auto;
  margin-left: 4px;
  margin-right: 4px;
  background-color: #fdd8b4;
}

#details_location {
  grid-area: location;
  text-align: left;
  font-size: large;
  margin-top: 8px;
  background-color: #efe6dd;
  width: auto;
  padding: 8px;
  border-radius: 8px;
}

#details_description {
  grid-area: desc;
  display: flex;
  align-content: left;
  text-align: left;
  font-size: large;
  margin-top: 16px;
  background-color: #efe6dd;
  width: auto;
  padding: 8px;
  border-radius: 8px;
}
</style>