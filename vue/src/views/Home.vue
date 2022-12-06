<template>
  <div class="home">
    <h1>Home</h1>
    <event-list />
  </div>
</template>

<script>
import EventList from "../components/Events"

export default {
  name: "home",
  components: {
    EventList
  }
};
</script>
