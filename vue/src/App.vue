<template>
  <div id="app">
    <div id="nav">
      <!--home button-->
      <router-link :to="{ name: 'home' }">
        <button>
          <img
            class="icon"
            src="https://cdn-icons-png.flaticon.com/512/25/25694.png"
            alt=""
          />
          <div>&nbsp;Home</div>
        </button>
      </router-link>
      <!--admin menu button-->
      <router-link :to="{ name: 'administration' }" v-if="$store.state.token != ''">
        &nbsp;
        <button>
          <img
            class="icon"
            src="http://cdn.onlinewebfonts.com/svg/img_184513.png"
            alt=""
          />
          <div>&nbsp;Menu</div>
        </button>
      </router-link>
      &nbsp;
      <!--login button-->
      <router-link :to="{ name: 'login' }" v-if="$store.state.token == ''">
        <button>
          <img
            class="icon"
            src="https://www.nicepng.com/png/full/138-1387674_png-file-svg-user-login-icon-png.png"
            alt=""
          />
          <div>&nbsp;Log In</div>
        </button>
      </router-link>
      <!--logout button-->
      <router-link :to="{ name: 'logout' }" v-if="$store.state.token != ''">
        <button>
          <img
            class="icon"
            src="https://www.pngfind.com/pngs/m/339-3396821_png-file-svg-download-icon-logout-transparent-png.png"
            alt=""
          />
          <div>&nbsp; Logout</div>
        </button>
      </router-link>
      <!--signed-in user greeting-->
      <a v-if="$store.state.user.username">
        &nbsp;Welcome, {{ $store.state.user.username }}
      </a>
    </div>
    <router-view />
  </div>
</template>

<script>
import eventsService from "@/services/EventsService.js";
import eventTagsService from "@/services/EventTagsService.js";

export default {
  created() {
    //get imported list of events
    eventsService
      .getEvents()
      .then((response) => {
        this.$store.commit("SET_EVENTS", response.data);
      })
      .catch((error) => {
        console.log(error.response.data.status);
      });
    //get imported list of tags
    eventTagsService
      .getEventTags()
      .then((response) => {
        this.$store.commit("SET_EVENT_TAGS", response.data);
      })
      .catch((error) => {
        console.log(error.response.data.status);
      });
  },
};
</script>

<style>
/*universal styling*/
body { background-color: #EFE6DD }
* { font-family: Verdana, Helvetica, sans-serif }
a {
  text-decoration: none;
  color: #000000;
}
/*button styling: text*/
button{
  display: inline-block;
  width: 120px;
  text-align: center;
  background-color: #FFFAFA;
  border-radius: 8px;
}
.icon {
  height: 25px;
  width: 25px;
}
button > div { font-size: large; }
</style>

