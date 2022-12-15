<template>
  <!-- EDIT TO BE FOR UPDATE -->
  <div id="update" class="text-center">
    <form class="form-update" @submit.prevent="update">
      <h1 class="h3 mb-3 font-weight-normal">Update Account</h1>
      <div class="alert alert-danger" role="alert" v-if="updateErrors">
        {{ updateErrorMsg }}
      </div>

      <div class="inputs">
        <label for="username" class="sr-only"> <h3>Username</h3></label>
        <input
          type="text"
          id="username"
          class="form-control"
          placeholder="Username"
          v-model="user.username"
          required
          autofocus
        />
        <label for="organization" class="sr-only"><h3>Organization</h3></label>
        <input
          type="text"
          id="organization"
          class="form-control"
          placeholder="Organization"
          v-model="user.organization"
          required
        />
        <label for="location" class="sr-only"><h3>Location</h3></label>
        <input
          type="text"
          id="location"
          class="form-control"
          placeholder="Location"
          v-model="user.location"
          required
        />
        <label for="name" class="sr-only"><h3>Name</h3></label>
        <input
          type="text"
          id="name"
          class="form-control"
          placeholder="Name"
          v-model="user.name"
          required
        />
        <label for="phone" class="sr-only"><h3>Phone</h3></label>
        <input
          type="text"
          id="phone"
          class="form-control"
          placeholder="Phone"
          v-model="user.phone"
          required
        />
        <label for="email" class="sr-only"><h3>Email</h3></label>
        <input
          type="text"
          id="email"
          class="form-control"
          placeholder="Email"
          v-model="user.email"
          required
        />
        <label for="password" class="sr-only"><h3>Password</h3></label>
        <input
          type="password"
          id="password"
          class="form-control"
          placeholder="Password"
          v-model="user.password"
          required
        />
        <input
          type="password"
          id="confirmPassword"
          class="form-control"
          placeholder="Confirm Password"
          v-model="user.confirmPassword"
          required
        />
      </div>

      <button class="btn btn-lg btn-primary btn-block" type="submit">
        Update Account
      </button>
    </form>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "profile",
  data() {
    return {
      user: {
        username: "",
        organization: "",
        location: "",
        name: "",
        phone: "",
        email: "",
        password: "",
        confirmPassword: "",
        role: "admin",
      },
      updateErrors: false,
      updateErrorMsg: "There were problems updating this user.",
    };
  },
  created() {
    let name = this.$store.state.user.username;
    authService.get(name).then((response) => {
      this.user = response.data;
    });
  },
  methods: {
    update() {
      console.log(this.user);
      if (this.user.password != this.user.confirmPassword) {
        this.updateErrors = true;
        this.updateErrorMsg = "Password & Confirm Password do not match.";
      } else {
        authService
          .update(this.user)
          .then((response) => {
            if (response.status == 200) {
              this.$store.commit("LOGOUT");
              this.$router.push({
                path: "/login",
                query: { update: "success" },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.updateErrors = true;
            if (response.status === 400) {
              this.updateErrorMsg = "Bad Request: Validation Errors";
            }
          });
      }
    },
    clearErrors() {
      this.updateErrors = false;
      this.updateErrorMsg = "There were problems updating this user.";
    },
  },
};
</script>

<style>
.inputs {
  display: grid;
  padding-bottom: 10px;
  row-gap: 10px;
  width: 75%;
  grid-template-areas:
    ""
    ""
    ""
    ""
    ""
    ""
    ""
    "";
}
</style>