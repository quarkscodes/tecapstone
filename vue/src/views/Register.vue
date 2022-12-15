<template>
  <div id="register" class="text-center">
    <form class="form-register" @submit.prevent="register">
      <div id="register_head">
        <p>Create Account</p>
      </div>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>

      <div class="edit_inputs">
        <div id="register_input">
          <label for="username" class="sr-only"> <p>Username</p></label>
          <input
            type="text"
            id="username"
            class="form-control"
            placeholder="Username"
            v-model="user.username"
            required
            autofocus
          />
        </div>
        <div id="register_input">
          <label for="organization" class="sr-only"><p>Organization</p></label>
          <input
            type="text"
            id="organization"
            class="form-control"
            placeholder="Organization"
            v-model="user.organization"
            required
          />
        </div>
        <div id="register_input">
          <label for="location" class="sr-only"><p>Location</p></label>
          <input
            type="text"
            id="location"
            class="form-control"
            placeholder="Location"
            v-model="user.location"
            required
          />
        </div>
        <div id="register_input">
          <label for="name" class="sr-only"><p>Name</p></label>
          <input
            type="text"
            id="name"
            class="form-control"
            placeholder="Name"
            v-model="user.name"
            required
          />
        </div>
        <div id="register_input">
          <label for="phone" class="sr-only"><p>Phone</p></label>
          <input
            type="text"
            id="phone"
            class="form-control"
            placeholder="Phone"
            v-model="user.phone"
            required
          />
        </div>
        <div id="register_input">
          <label for="email" class="sr-only"><p>Email</p></label>
          <input
            type="text"
            id="email"
            class="form-control"
            placeholder="Email"
            v-model="user.email"
            required
          />
        </div>
        <div id="register_input">
          <label for="password" class="sr-only"><p>Password</p></label>
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
      </div>
      <div>
        <button id="button">
          <router-link :to="{ name: 'login' }">Have an account?</router-link>
        </button>
        <button class="btn btn-lg btn-primary btn-block" type="submit">
          Create Account
        </button>
      </div>
    </form>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "register",
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
      registrationErrors: false,
      registrationErrorMsg: "There were problems registering this user.",
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = "Password & Confirm Password do not match.";
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: "/login",
                query: { registration: "success" },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = "Bad Request: Validation Errors";
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = "There were problems registering this user.";
    },
  },
};
</script>

<style>
.edit_inputs {
  padding-bottom: 10px;
  row-gap: 10px;
  width: 100%;
  justify-content: center;
}

.form-register {
  display: flexbox;
  justify-content: center;
  background: #7ebdc2;
  padding: 5%;
  margin: 0px 15%;
  border: 3px solid #275053;
  margin-top: 16px;
}
#register_head {
  background: #fcbb70;
  border: 2px solid #231f20;
  margin: 4px;
  margin-bottom: 12px;
  border-radius: 4px;
}
#register_head p {
  text-align: center;
  font-weight: bold;
  font-size: x-large;
}
div#register_input {
  display: flexbox;
  background: #efe6dd;
  padding: 6px;
  margin: 4px;
  border-radius: 4px;
  width: auto;
}
#register_input input {
  width: 98%;
}
#register button {
  margin: 0px;
  margin-bottom: 8px;
  padding: 4px;
  width: 100%;
  font-size: larger;
}
</style>
