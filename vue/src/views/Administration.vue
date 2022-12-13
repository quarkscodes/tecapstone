<template>
    <div class="admin">
      <router-link :to="{ name: 'viewProfile' }">
        <button id="option">
          View Profile
        </button>
      </router-link>
      <img id='admin' src="https://www.freepnglogos.com/uploads/line-png/faded-black-line-png-images-19.png" alt="meh">
      <router-link :to="{ name: 'home' }">
        <button id="option">
          View Events
        </button>
      </router-link>
      <router-link :to="{ name: 'createEvent' }">
        <button id="option">
          Create Event
        </button>
      </router-link>
      <router-link :to="{ name: 'updateEvent' }">
        <button id="option">
          Edit Event
        </button>
      </router-link>
      <router-link :to="{ name: 'deleteEvent' }">
        <button id="option">
          Delete Event
        </button>
      </router-link>
      <router-link :to="{ name: 'register' }">
        <button id="option">
          Register New Admin
        </button>
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
  margin: 32px 15%;
}

#option{
  width: 100%;
  padding: 12px;
  margin: 4px 0px;
  font-size: larger;
}
hr{
  border-top: 3px dashed #EFE6DD;
  color: #EFE6DD;
}
#admin{
  width: 100%;
  margin: 0px;
  padding: 0px;
  max-height: 16px;
}
</style>