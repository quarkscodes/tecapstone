<template>
  <div>
    <form class="create" v-on:submit.prevent="submitCreate">
      <div id="create">
        <label for="name">Event Name:<br/></label>
        <input type="text" id="name" v-model="newEvent.name" required />
      </div>
      <div id="create">
        <label for="description">Description:<br/></label>
        <textarea
          type="textarea"
          id="description"
          rows="3"
          v-model="newEvent.description"
          required
        />
      </div>
      <div id="create">
        <label for="img_url">Image URL:<br/></label>
        <input type="text" id="img_url" v-model="newEvent.imgUrl" />
      </div>
      <div id="create">
        <label for="start_time">Start Date and Time:<br/></label>
        <input
          type="datetime-local"
          id="start_time"
          v-model="newEvent.startTime"
        />
      </div>
      <div id="create">
        <label for="end_time">End Date and Time:<br/></label>
        <input type="datetime-local" id="end_time" v-model="newEvent.endTime" />
      </div>
      <div id="create">
        <label for="address">Address:<br/></label>
        <input type="text" id="address" v-model="newEvent.address" />
      </div>
      <div id="create">
        <label for="city">City:<br/></label>
        <input type="text" id="city" v-model="newEvent.city" />
      </div>
      <div id="create">
        <label for="state">State:<br/></label>
        <input type="text" id="state" v-model="newEvent.state" />
      </div>
      <div id="create">
        <label for="zip">Zip:<br/></label>
        <input type="number" id="zip" v-model="newEvent.zip" />
      </div>
      <button type="submit" id="submit">Submit</button>
    </form>
  </div>
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
.create {
  display: flexbox;
  justify-content: center;
  background: #7ebdc2;
  padding: 5%;
  margin: 32px 15%;
}
div #create {
  display: flexbox;
  background: #efe6dd;
  padding: 6px;
  margin: 4px;
  border-radius: 4px;
}
#create input{
  width:95%;
}
.create button{
  margin: 8px;
  margin-bottom: 0px;
  padding: 4px;
}
#description{
  height: 85px;
  width: 95%;
  resize: none;
}
</style>