<template>
  <div class="home_page">
    <p class="home" id="home_header">Tap on an event to see more details</p>
    <div class="home" id="home_filter">
      <p id="filter_header">Filter</p>
      <form>
        <label for="zipcode" id="filter_zip">Zip Code: </label>
        <input
          v-model="inputZip"
          type="text"
          id="filter_zip"
          name="filter_zip"
        />&nbsp;
        <input
          v-on:click.prevent="zipFilter(inputZip)"
          type="submit"
          value="Submit"
        />
      </form>
    </div>
    <events class="home" id="home_events" v-bind:zipcode="inputZip" />
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
    };
  },
};
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