<template>
  <div class="home_page">
    <p class="home" id="home_header">Tap on an event to see more details</p>
    <div class="home" id="home_filter">
      <p id="filter_header">Filter</p>
      <form>
        <label for="filter_zip" id="filter_zip">Zip Code: </label>
        <input
          name="filter_zip"
          type="text"
          id="filter_zip"
          v-model="inputZip"
        />&nbsp;
      </form>
      <form>
        <label for="filter_tags" id="filter_tags">Catagories: </label>
        <input
          name="filter_tags"
          type="text"
          id="filter_tags"
          v-model="inputTag"
        />&nbsp;
      </form>
      <div id="buttons">
        <button v-on:mouseup="removeText()" id="bc">&lt;==Backspace</button>
        <button v-on:mouseup="inputText(1)" id="b1">1</button>
        <button v-on:mouseup="inputText(2)" id="b2">2</button>
        <button v-on:mouseup="inputText(3)" id="b3">3</button>
        <button v-on:mouseup="inputText(4)" id="b4">4</button>
        <button v-on:mouseup="inputText(5)" id="b5">5</button>
        <button v-on:mouseup="inputText(6)" id="b6">6</button>
        <button v-on:mouseup="inputText(7)" id="b7">7</button>
        <button v-on:mouseup="inputText(8)" id="b8">8</button>
        <button v-on:mouseup="inputText(9)" id="b9">9</button>
        <button v-on:mouseup="inputText(0)" id="b0">0</button>
      </div>
    </div>
    <events
      class="home"
      id="home_events"
      v-bind:filteredEvents="filteredEvents.sort(dateSort)"
    />
  </div>
</template>

<script>
import Events from "../components/Events";

export default {
  name: "home",
  components: {
    Events,
  },
  data() {
    return {
      inputZip: "",
      inputTag: "",
    };
  },
  computed: {
    filteredEvents() {
      let zipFilter = this.$store.state.events.filter((e) => {
        return e.zip.toString().includes(this.inputZip) || !this.inputZip;
      });
      let typeFilter = [];
      zipFilter.forEach((e) => {
        this.$store.state.eventTags.forEach((t) => {
          if (!typeFilter.includes(e) &&
          (this.inputTag == "" ||
            (t.eventId == e.eventId && t.tag == this.inputTag))
          ) {
              typeFilter.push(e);
          }
        });
      });
      return typeFilter;
    },
    eventTags() {
      return this.$store.state.eventTags;
    },
  },
  methods: {
    inputText(num) {
      if (this.inputZip !== "") {
        let zipString = this.inputZip;
        console.log(zipString);
        let numString = num.toString();
        console.log(numString);
        let newString = zipString.concat(numString);
        this.inputZip = newString;
      } else {
        this.inputZip = num.toString();
      }
    },

    dateSort() {
      //edit this code to filter your list by date
      // array.sort(function(a,b){
      //   // Turn your strings into dates, and then subtract them
      //   // to get a value that is either negative, positive, or zero.
      //   return new Date(b.date) - new Date(a.date);
      // });
    },
    removeText() {
      if (this.inputZip !== "") {
        this.inputZip = this.inputZip.slice(0, -1);
      }
    },
  },
};
</script>

<style>
.home_page {
  display: grid;
  grid-template-columns: 1fr 4fr;
  grid-template-areas:
    "header header"
    "filter events";
}

#home_header {
  grid-area: header;
}

#home_filter {
  grid-area: filter;
  background-color: #7ebdc2;
  margin: 8px;
  padding: 8px;
  border-radius: 12px;
}

#filter_header {
  font-size: x-large;
  font-weight: bold;
}

#filter_zip {
  font-size: large;
  font-weight: bold;
  width: 45%;
}

#buttons {
  border: 3px solid black;
  display: grid;
  margin-top: 20px;
  width: auto;
  height: 350px;
  grid-template-areas:
    "b7 b8 b9"
    "b4 b5 b6"
    "b1 b2 b3"
    "b0 bc bc";
}

#bc {
  grid-area: bc;
}
#b0 {
  grid-area: b0;
}
#b1 {
  grid-area: b1;
}
#b2 {
  grid-area: b2;
}
#b3 {
  grid-area: b3;
}
#b4 {
  grid-area: b4;
}
#b5 {
  grid-area: b5;
}
#b6 {
  grid-area: b6;
}
#b7 {
  grid-area: b7;
}
#b8 {
  grid-area: b8;
}
#b9 {
  grid-area: b9;
}
#b0 {
  grid-area: b0;
}

#home_events {
  grid-area: events;
}
</style>