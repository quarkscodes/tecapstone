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
      <p v-if="$store.state.user.username">
        User is {{ $store.state.user.username }}
      </p>
    </div>
    <router-view />
  </div>
</template>

<script>
import eventsService from "@/services/EventsService.js";
export default {
  components: {},
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
.login_icon {
  height: 20px;
  width: 20px;
}
.logout_icon {
  height: 20px;
  width: 20px;
}
</style>