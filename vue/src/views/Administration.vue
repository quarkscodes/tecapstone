<template>
  <div class="admin">
    <button id="option_straight">Profile</button>
    <router-link :to="{ name: 'profile' }">
      <button id="option">Edit Profile</button>
    </router-link>
    <router-link :to="{ name: 'register' }">
      <button id="option">Create New User</button>
    </router-link>
    <button id="option_straight">Events</button>
    <router-link :to="{ name: 'createEvent' }">
      <button id="option">Create Event</button>
    </router-link>
    <router-link :to="{ name: 'updateEvent' }">
      <button id="option">Edit Event</button>
    </router-link>
    <router-link :to="{ name: 'deleteEvent' }">
      <button id="option">Delete Event</button>
    </router-link>
    <router-link :to="{ name: 'editTags' }">
      <button id="option">Edit Event Tags</button>
    </router-link>
  </div>
</template>

<script>
export default {
  name: "administration",
};
</script>

<style>
.admin {
  display: flexbox;
  justify-content: center;
  background: #7ebdc2;
  padding: 5%;
  margin: 0px 15%;
  border: 3px solid #275053;
  margin-top: 16px;
}
#option {
  width: 100%;
  padding: 12px;
  margin: 4px 0px;
  font-size: larger;
  border-radius: 16px;
  border: none;
}
#option_straight {
  background: #fcbb70;
  width: 100%;
  padding: 12px;
  margin: 16px 0px;
  font-size: larger;
  font-weight: bold;
  border-radius: 8px;
}
</style>