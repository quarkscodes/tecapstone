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
    <router-link :to="{ name: 'home' }">
      <button id="option">View Events</button>
    </router-link>
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
      <button id="option">Event Tags</button>
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
  align-items: center;
  background: #7ebdc2;
  padding: 5%;
  margin: 32px 15%;
}

#option {
  width: 100%;
  padding: 12px;
  margin: 4px 0px;
  font-size: larger;
  border-radius: 16px;
  border: none;
}
hr {
  border-top: 3px dashed #efe6dd;
  color: #efe6dd;
}
#admin {
  width: 100%;
  margin: 0px;
  padding: 0px;
  max-height: 16px;
}

#option_straight{
  width: 100%;
  padding: 12px;
  margin: 8px 0px;
  font-size: larger;
  font-weight: bold;
}
</style>