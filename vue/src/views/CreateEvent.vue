<template>
  <form v-on:submit.prevent="submitCreate">
    <label for="name">Event Name:&nbsp;</label>
    <input type="text" id="name" v-model="newEvent.name" required />
    <label for="description">Description:&nbsp;</label>
    <input
      type="textarea"
      id="description"
      v-model="newEvent.description"
      required
    />
    <label for="img_url">Image URL:&nbsp;</label>
    <input type="text" id="img_url" v-model="newEvent.imgUrl" />
    <label for="start_time">Start Date and Time:&nbsp;</label>
    <input type="datetime-local" id="start_time" v-model="newEvent.startTime" />
    <label for="end_time">End Date and Time:&nbsp;</label>
    <input type="datetime-local" id="end_time" v-model="newEvent.endTime" />
    <label for="address">Address:&nbsp;</label>
    <input type="text" id="address" v-model="newEvent.address" />
    <label for="city">City:&nbsp;</label>
    <input type="text" id="city" v-model="newEvent.city" />
    <label for="state">State:&nbsp;</label>
    <input type="text" id="state" v-model="newEvent.state" />
    <label for="zip">Zip:&nbsp;</label>
    <input type="number" id="zip" v-model="newEvent.zip" />
    <button type="submit" id="submit">Submit</button>
  </form>
</template>

<script>
import eventsService from "@/services/EventsService.js";

export default {
  name: "create-event",
  data() {
    return {
      newEvent: {
        userId: this.$store.state.user.userId,
      },
    };
  },
  methods: {
    submitCreate() {
      this.newEvent.zip = parseInt(this.newEvent.zip);
      eventsService
        .createEvent(this.newEvent)
        .then((response) => {
          if (response.status == 200) {
            this.$store.commit('ADD_EVENT', this.newEvent)
            this.$router.push("/administration");
          }
        })
        .catch((error) => {
          console.log(error.response.data.status);
        });
    },
  },
};
</script>

<style>
</style>