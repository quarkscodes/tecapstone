<template>
  <div>
    <router-link v-bind:to="{ name: 'home' }">
      <div>
        <h2 class="event" id="event_title">{{ event.name }}</h2>
        <img class="event" id="event_image" :src="event.imgUrl" alt="idk fam" />
        <p class="event" id="event_start">Start Date: {{ event.startTime }}</p>
        <p class="event" id="event_end">End Date: {{ event.endTime }}</p>
        <p class="event" id="event_tag">Tags: {{ event.tag }}</p>
        <p class="content" id="event_location">
          Location: {{ event.location }}
        </p>
        <p class="content" id="event_description">{{ event.description }}</p>
      </div>
    </router-link>
  </div>
</template>

<script>
export default {
    props:[],
  data() {
    return { event: {} };
  },
  created() {
      let id = this.$route.params.id;
    let events = this.$store.state.events;
    console.log("Reached Created in Details.vue");
    console.log(events);
    this.event = events.find((item) => {
      return item.eventId == id;
    });
    console.log(this.event)
  },
};
</script>

<style>
</style>