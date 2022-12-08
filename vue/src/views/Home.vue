<template>
  <div class="home">
    <p>Tap on an event to see more details</p>
    <event-list />
  </div>
</template>

<script>
import EventList from "../components/Events"

export default {
  name: "home",
  components: {
    EventList
  },
    data(){
      let zipcode = true,
  },
      methods:{
    zipFilter(zip){
      this.$state.store.event.forEach(event => {
        if (event.zip!=zip)
        zipcode = false
      });
    }
  },
};
</script>