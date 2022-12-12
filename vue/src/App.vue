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
          &nbsp;Home
        </button>
      </router-link>

      <router-link :to="{ name: 'administration' }" v-if="$store.state.token != ''">
        &nbsp;
        <button>
          <img
            class="home_icon"
            src="http://cdn.onlinewebfonts.com/svg/img_184513.png"
            alt=""
          />
          &nbsp;Menu
        </button>
      </router-link>
      &nbsp;

      <router-link :to="{ name: 'login' }" v-if="$store.state.token == ''">
        <button>
          <img
            class="login_icon"
            src="https://www.nicepng.com/png/full/138-1387674_png-file-svg-user-login-icon-png.png"
            alt=""
          />
          &nbsp;Log In
        </button>
      </router-link>

      <router-link :to="{ name: 'logout' }" v-if="$store.state.token != ''">
        <button>
          <img
            class="logout_icon"
            src="https://www.pngfind.com/pngs/m/339-3396821_png-file-svg-download-icon-logout-transparent-png.png"
            alt=""
          />
          &nbsp; Logout
        </button>
      </router-link>

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
    eventsService
      .getEvents()
      .then((response) => {
        this.$store.commit("SET_EVENTS", response.data);
      })
      .catch((error) => {
        console.log(error.response.data.status);
      });
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
.login_icon {
  height: 20px;
  width: 20px;
}
.logout_icon {
  height: 20px;
  width: 20px;
}
</style>