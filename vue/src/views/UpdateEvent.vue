<template>
  <div>
    <form class="choose-update" v-on:submit.prevent="setEvent(e)">
      <label for="choose-event">Choose an event:&nbsp;</label>
      <select name="choose-event" id="choose-event" v-model="updateEvent">
        <option
          id="choose-event-options"
          v-for="(event, index) in filteredEvents"
          :key="index"
          :value="event"
        >
          {{ event.name }}
        </option>
      </select>
    </form>
    <form class="update" v-on:submit.prevent="submitUpdate">
      <div id="update">
        <label for="name">Event Name:<br /></label>
        <input type="text" id="name" v-model="updateEvent.name" required />
      </div>
      <div id="update">
        <label for="description">Description:<br /></label>
        <textarea
          type="textarea"
          id="description"
          rows="3"
          v-model="updateEvent.description"
          required
        />
      </div>
      <div id="update">
        <label for="img_url">Image URL:<br /></label>
        <input type="text" id="img_url" v-model="updateEvent.imgUrl" />
      </div>
      <div id="update">
        <label for="start_time">Start Date and Time:<br /></label>
        <d>(MM/DD/YYYY HH/MM/SS [A/P]M)</d><br />
        <input id="start_time" v-model="updateEvent.startTime" />
      </div>
      <div id="update">
        <label for="end_time">End Date and Time:<br /></label>
        <d>(MM/DD/YYYY HH/MM/SS [A/P]M)</d><br />
        <input id="end_time" v-model="updateEvent.endTime" />
      </div>
      <div id="update">
        <label for="address">Address:<br /></label>
        <input type="text" id="address" v-model="updateEvent.address" />
      </div>
      <div id="update">
        <label for="city">City:<br /></label>
        <input type="text" id="city" v-model="updateEvent.city" />
      </div>
      <div id="update">
        <label for="state">State:<br /></label>
        <input type="text" id="state" v-model="updateEvent.state" />
      </div>
      <div id="update">
        <label for="zip">Zip:<br /></label>
        <input type="number" id="zip" v-model="updateEvent.zip" />
      </div>
      <button type="submit" id="submit">Submit</button>
    </form>
  </div>
</template>

<script>
import eventsService from "@/services/EventsService.js";
import eventTagsService from "@/services/EventTagsService.js";

export default {
  name: "updateEvent",

  data() {
    return {
      updateEvent: {},
    };
  },
  created() {
    eventsService
      .getEvents()
      .then((response) => {
        this.$store.commit("SET_EVENTS", response.data);
        console.log(this.$store.state.events);
      })
      .catch((error) => {
        console.log(error.response.data.status);
      });
    eventTagsService
      .getEventTags()
      .then((response) => {
        this.$store.commit("SET_EVENT_TAGS", response.data);
      })
      .catch((error) => {
        console.log(error.response.data.status);
      });
  },
  methods: {
    submitUpdate() {
      this.updateEvent.zip = parseInt(this.updateEvent.zip);
      eventsService
      .updateEvent(this.updateEvent)
      .then((response) => {
        if (response.status == 200) {
          eventsService
            .getEvents()
            .then((response) => {
              this.$store.commit("SET_EVENTS", response.data);
            })
            .catch((error) => {
              console.log(error.response.data.status);
            });
          this.$router.push("/administration");
        }
      });
    },
  },
  computed: {
    filteredEvents() {
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
.update {
  display: flexbox;
  justify-content: center;
  background: #7ebdc2;
  padding: 5%;
  margin: 32px 15%;
}
.choose-update {
  margin: 8px;
}
div #update {
  display: flexbox;
  background: #efe6dd;
  padding: 6px;
  margin: 4px;
  border-radius: 4px;
}
#update input {
  width: 95%;
}
.update button {
  margin: 8px;
  margin-bottom: 0px;
  padding: 4px;
}
#description {
  height: 80px;
  width: 95%;
  resize: none;
}
d {
  font-size: small;
}
</style>