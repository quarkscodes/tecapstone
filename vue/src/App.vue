<template>
  <div id="app">
    <div id="main_header">
      <div id="logo">
        <img src="../images/forward_logo.png" alt="" />
      </div>
      <h1 id="front_title">
        Helping Move You ForWARD
      </h1>
      <div id="nav">
        <!--home button-->
        <router-link :to="{ name: 'home' }">
          <button id="b_head">
            <img
              class="icon"
              src="https://cdn-icons-png.flaticon.com/512/25/25694.png"
              alt=""
            />
            <div>&nbsp;Home</div>
          </button>
        </router-link>
        <!--admin menu button-->
        <router-link
          :to="{ name: 'administration' }"
          v-if="$store.state.token != ''"
        >
          &nbsp;
          <button id="b_head">
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
          <button id="b_head">
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
          <button id="b_head">
            <img
              class="icon"
              src="https://www.pngfind.com/pngs/m/339-3396821_png-file-svg-download-icon-logout-transparent-png.png"
              alt=""
            />
            <div>&nbsp; Logout</div>
          </button>
        </router-link>
      </div>
      <!--signed-in user greeting-->
      <div id="signed_in_user">
        <a v-if="$store.state.user.username">
          <br />Welcome, {{ $store.state.user.username }}
        </a>
      </div>
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
body {
  background-color: #efe6dd;
}
* {
  font-family: Verdana, Helvetica, sans-serif;
}
a {
  text-decoration: none;
  color: #000000;
}
/*scroll bar*/
::-webkit-scrollbar {
  width: 18px;
}
::-webkit-scrollbar-track {
  background: #fffafa;
  border-radius: 10px;
}
::-webkit-scrollbar-thumb {
  background: #7ebdc2;
  border-radius: 10px;
}
/*header*/
#main_header {
  display: grid;
  grid-template-columns: 160px auto;
  grid-template-areas:
    "logo front signedin"
    "logo buttons signedin";
  background-color: #7ebdc2;
  border: 4px solid #275053;
  border-radius: 12px;
}
#logo {
  grid-area: logo;
}
#front_title {
  grid-area: front;
  width: fit-content;
  padding: 8px;
  border-radius: 8px;
  color: #fffafa;
  text-shadow: 2px 2px #275053;
  background-color: FCBB70;
}
#logo img {
  margin: 18px;
  height: 120px;
  aspect-ratio: 1/1;
}
#nav {
  grid-area: buttons;
  display: flex;
  align-items: start;
}
#signed_in_user {
  grid-area: signedin;
  font-size: large;
}
/*button styling: text*/
button {
  display: inline-block;
  text-align: center;
  background-color: #fffafa;
}
#b_head {
  width: 120px;
  border-radius: 8px;
}
.icon {
  height: 25px;
  width: 25px;
}
button > div {
  font-size: large;
}
</style>

