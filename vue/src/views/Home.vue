<template>
  <div class="home_page">
    <p class="home" id="home_header">Tap on an event to see more details</p>
    <div class="home" id="home_filter">
      <p id="filter_header">Filter</p>

      <form>
        <label for="filter_zip" id="filter_zip">Zip Code: </label>
        <input
          v-on:click="numpadOn"
          name="filter_zip"
          type="text"
          id="filter_zip"
          v-model="inputZip"
        />&nbsp;

        <div v-if="numpad == true" id="buttons">
          <button type="button" v-on:mouseup="removeText()" id="bc">
            &lt;==Backspace
          </button>
          <button type="button" v-on:mouseup="clearText()" id="clear">
            CLEAR
          </button>
          <button type="button" v-on:mouseup="numpadOff()" id="bx">X</button>
          <button type="button" v-on:mouseup="inputText(1)" id="b1">1</button>
          <button type="button" v-on:mouseup="inputText(2)" id="b2">2</button>
          <button type="button" v-on:mouseup="inputText(3)" id="b3">3</button>
          <button type="button" v-on:mouseup="inputText(4)" id="b4">4</button>
          <button type="button" v-on:mouseup="inputText(5)" id="b5">5</button>
          <button type="button" v-on:mouseup="inputText(6)" id="b6">6</button>
          <button type="button" v-on:mouseup="inputText(7)" id="b7">7</button>
          <button type="button" v-on:mouseup="inputText(8)" id="b8">8</button>
          <button type="button" v-on:mouseup="inputText(9)" id="b9">9</button>
          <button type="button" v-on:mouseup="inputText(0)" id="b0">0</button>
        </div>
      </form>
      <form>
        <label for="resource_types">Resource Type:</label>
        <select name="resource_types" v-model="inputTag">
          <option
            v-for="(tag, index) in tagsAvailable"
            v-bind:key="index"
            :value="tag"
          >
            {{ tag }}
          </option>
        </select>
      </form>
    </div>
    <events
      class="home"
      id="home_events"
      v-bind:filteredEvents="filteredEvents"
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
      numpad: false,
    };
  },
  computed: {
    filteredEvents() {
      const EList = this.$store.state.events;
      console.log(EList);
      const sorted = EList.sort((a, b) => {
        return new Date(a.startTime) - new Date(b.startTime);
      });
      console.log(sorted);
      let zipFilter = sorted.filter((e) => {
        console.log(e);
        return e.zip.toString().includes(this.inputZip) || !this.inputZip;
      });

      let typeFilter = [];
      zipFilter.forEach((e) => {
        this.$store.state.eventTags.forEach((t) => {
          if (
            !typeFilter.includes(e) &&
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

    tagsAvailable() {
      let output = [''];
      this.$store.state.eventTags.forEach((t) => {
        if (!output.includes(t.tag)) {
          output.push(t.tag);
        }
      });
      return output;
    },
  },
  methods: {
    inputText(num) {
      if (this.inputZip !== "") {
        let zipString = this.inputZip.toString();
        console.log(zipString);
        let numString = num.toString();
        console.log(numString);
        let newString = zipString.concat(numString);
        this.inputZip = newString;
      } else {
        this.inputZip = num.toString();
      }
    },

    removeText() {
      if (this.inputZip !== "") {
        this.inputZip = this.inputZip.slice(0, -1);
      }
    },
        clearText() {
        this.inputZip = ''
    },
    numpadOn() {
      this.numpad = true;
    },
    numpadOff() {
      this.numpad = false;
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
    "clear clear bx"
    "b7 b8 b9"
    "b4 b5 b6"
    "b1 b2 b3"
    "b0 bc bc";
}

#bx {
  grid-area: bx;
  background-color: crimson;
}
#clear {
  grid-area: clear;
  background-color: rgb(134, 8, 33);
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