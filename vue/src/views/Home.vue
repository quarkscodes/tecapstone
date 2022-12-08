<template>
  <div class="home_page">
    <p class="home" id="home_header">Tap on an event to see more details</p>
    <div class="home" id="home_filter">
      <p id="filter_header">Filter</p>
      <form v-on:submit.prevent="onSubmit">
        <label for="filter_zip" id="filter_zip">Zip Code: </label>
        <input
          name="filter_zip"
          type="text"
          id="filter_zip"
          maxlength=""
        />&nbsp;
        <input type="submit" value="Submit" />
      </form>
    </div>
    <events class="home" id="home_events" v-bind:filteredEvents="filteredEvents" />
  </div>
</template>

<script>
import Events from "../components/Events";

export default {
  name: "home",
  components: {
    Events,
  },
  data() {
    return {
      inputZip: null,
    }
  },
  computed: {
    filteredEvents() {
      return this.$store.state.events.filter(e => { return e.zip == this.inputZip || !this.inputZip })
    }
  }
    // methods: {
    // zipFilter(zip){
    //   this.$state.store.event.forEach(event => {
    //     if (event.zip==zip){
    //     this.zipcode = false
    //     }
    //   });
    //}
  //},
}
</script>

<style>
.home_page {
  display: grid;
  grid-template-columns: 1fr 4fr;
  grid-template-areas:
    "header header"
    "filter events";
}

#home_header {
  grid-area: header;
}

#home_filter {
  grid-area: filter;
  background-color: #7ebdc2;
  margin: 8px;
  padding: 8px;
  border-radius: 12px;
}

#filter_header {
  font-size: x-large;
  font-weight: bold;
}

#filter_zip {
  font-size: large;
  font-weight: bold;
  width: 45%;
}

#home_events {
  grid-area: events;
}
</style>