<template>
  <div>
    <!--link to details view-->
    <router-link
      :to="{ name: 'details', params: { id: event.eventId } }"
      v-for="event in filteredEvents"
      :key="event.eventId"
    >
      <!--event cards-->
      <div class="event_card">
        <p class="event" id="event_title">{{ event.name }}</p>
        <img class="event" id="event_image" :src="event.imgUrl" alt="loading..." />
        <p class="event" id="event_dates">
          <b>Start Date:</b> {{ DateOnly(event.startTime) }} <br />
          <b>End Date:&nbsp;&nbsp;</b> {{ DateOnly(event.endTime) }}
        </p>
        <div id="event_tag_list">
          <div v-for="(event_tag, index) in eventTagsList" :key="index">
            <p
              class="event"
              id="event_tag"
              v-if="event_tag.eventId == event.eventId"
            >
              {{ event_tag.tag }}
            </p>
          </div>
        </div>
      </div>
    </router-link>

    <div v-if="deleting" class="popup">
      <p><br/>Are you sure you want to delete this event?</p>
      <button v-on:click="deleteEvent(eventId)" class="popupInfo">Yes</button>
      <button v-on:click="notSure" class="popupInfo">Cancel</button>
    </div>

    <div v-for="event in yourEvents" :key="event.eventId">
      <router-link :to="{ name: 'details', params: { id: event.eventId } }">
        <div class="event_card">
          <p class="event" id="event_title">{{ event.name }}</p>
          <img
            class="event"
            id="event_image"
            :src="event.imgUrl"
            alt="loading..."
          />
          <p class="event" id="event_dates">
            <b>Start Date:</b> {{ DateOnly(event.startTime) }} <br />
            <b>End Date:&nbsp;&nbsp;</b> {{ DateOnly(event.endTime) }}
          </p>
          <div id="event_tag_list">
            <div v-for="(event_tag, index) in eventTagsList" :key="index">
              <p
                class="event"
                id="event_tag"
                v-if="event_tag.eventId == event.eventId"
              >
                {{ event_tag.tag }}
              </p>
            </div>
          </div>
        </div>
      </router-link>
      <button id="delete_button" @click="areYouSure(event.eventId)">Delete Event</button>
    </div>
  </div>
</template>

<script>
import EventsService from "../services/EventsService";

export default {
  name: "Events",
  data() {
    return {
      deleting: false,
      eventId: null,
    };
  },
  props: ["filteredEvents", "eventTags", "yourEvents"], //this is the new list to show
  methods: {
    deleteEvent(id) {
      console.log("bruh");
      console.log(id);
      console.log("dude");
      console.log(EventsService);

      this.deleting = false;
      EventsService.deleteEvent(id);
    },
    areYouSure(id) {
      console.log(id);
      this.deleting = true;
      this.eventId = id;
    },
    notSure() {
      this.deleting = false;
      this.eventId = null;
    },
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
  padding: 12px;
  border-radius: 8px;
  margin-top: 4px;
}

#event_image {
  grid-area: img;
  width: 95%;
  aspect-ratio: 1/1;
  border-radius: 12px;
  background-color: #efe6dd;
}

#event_dates {
  grid-area: dates;
  font-size: large;
  background-color: #efe6dd;
  padding: 8px;
  border-radius: 12px;
}

#event_tag_list {
  grid-area: tag;
  display: flex;
  flex-wrap: wrap;
}

#event_tag {
  font-size: large;
  text-align: left;
  background-color: #efe6dd;
  padding: 4px;
  padding-left: 8px;
  padding-right: 8px;
  border-radius: 6px;
  margin: 4px 4px;
  margin-bottom: 0px;

}
.popup {
  position: fixed;
  top: 30%;
  height: 30%;
  left: 30%;
  width: 40%;
  text-align: center;
  background-color: #fffafa;
  border: 2px solid black;
}
.popup p{
  font-size: x-large;
  padding: 12px;
}
.popup button{
  padding: 4px;
  margin: 8px;
  font-size: larger;
  width: 30%;
}
#delete_button{
  width: 100%;
  font-size: larger;
}
</style>