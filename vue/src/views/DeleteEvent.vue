<template>
  <div class="delete_event">
    <div id="delete_head">
      <p id="delete_head">Delete Event</p>
    </div>
    <div>
      <events v-bind:yourEvents="yourEvents"> </events>
    </div>
  </div>
</template>

<script>
import Events from "../components/Events.vue";
export default {
  name: "deleteEvent",
  components: {
    Events,
  },
  computed: {
    yourEvents() {
      let EList = this.$store.state.events;
      let id = this.$store.state.user.userId;
      let userFilter = EList.filter((e) => {
        console.log(e);
        return e.userId == id;
      });
      return userFilter;
    },
  },
};
</script>

<style>
.delete_event {
  display: flexbox;
  justify-content: center;
  padding: 5%;
  margin: 0px 4%;
    border: 3px solid #275053;
    background-color: #7ebdc2;
      margin-top: 16px;

}
div#delete_head {
  background: #FCBB70;
  border: 2px solid #231f20;
  margin: 4px;
  margin-bottom: 16px;
  border-radius: 4px;
}
p#delete_head {
  text-align: center;
  font-weight: bold;
  font-size: x-large;
}
</style>