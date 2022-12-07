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
/*.event_card {
  display: grid;
  grid-template-columns: 3fr 7fr 4fr;
  grid-template-areas:
    "img title dates"
    "img tag tag";
  background-color: #7ebdc2;
  margin: 16px;
  padding: 8px;
  border-radius: 12px;
}

.event{
  font-family: Verdana, Helvetica, sans-serif;
  width: fit-content;
  height: fit-content;
  margin: auto;
}

#event_title {
  grid-area: title;
  background-color: #efe6dd;
  padding: 12px;
  border-radius: 8px;
}

#event_image {
  grid-area: img;
  width: 95%;
  aspect-ratio: 1/1;
  border-radius: 12px;
}

#event_dates {
  grid-area: dates;
  background-color: #efe6dd;
  padding: 12px;
  border-radius: 12px;
}

#event_tag {
  grid-area: tag;
  background-color: #efe6dd;
  padding: 4px;
  border-radius: 4px;
  font-weight: bold;
  margin-left: 24px;
  margin-right: 24px;
}*/
</style>