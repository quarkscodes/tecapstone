<template>
  <div id="app">
    <div id="nav">
      <router-link :to="{ name: 'home' }">
        <button>
          <img
            class="home_icon"
            src="https://cdn-icons-png.flaticon.com/512/25/25694.png"
            alt=""
          />
          &nbsp;Go Home
        </button>
      </router-link>
      <router-link
        v-bind:to="{ name: 'logout' }"
        v-if="$store.state.token != ''"
        >&nbsp;|&nbsp; Logout</router-link
      >
      <p v-if="$store.state.user.username">
        User is {{ $store.state.user.username }}
      </p>
    </div>
    <router-view />
    <!--<div is='Details' v-bind:eventList="events" v:if='false' />-->
  </div>
</template>

<script>
import eventsService from "@/services/EventsService.js";
//import Details from "./views/Details.vue"
export default {
  components: {
    //Details,
  },
  computed: {
      eventList() {
      return this.$state.store.events;
    },
  },
  created() {
    eventsService
      .getEvents()
      .then((response) => {
        this.$store.commit("SET_EVENTS", response.data);
      })
      .catch((error) => {
        console.log(error.response.data.status);
      });
  },
};
</script>

<style>
body {
  background-color: #f3dfa2;
}

* {
  font-family: Verdana, Helvetica, sans-serif;
}

a {
  text-decoration: none;
  color: #000000;
}

.home_icon {
  height: 20px;
  width: 20px;
}
</style>