<template>
  <div class="home_page">
    <!--home header-->
    <p id="home_header">Tap on an event to see more details</p>
    <!--home filter-->
    <div class="home_filter">
      <p id="filter_header">Filter</p>
      <!--filter by tag-->
      <form>
        <label id="filter_tag" for="resource_types">Resource Type:</label>
        <select id="filter_tag" name="resource_types" v-model="inputTag">
          <option
            id="filter_tag_options"
            v-for="(tag, index) in tagsAvailable"
            :key="index"
            :value="tag"
          >
            {{ tag }}
          </option>
        </select>
      </form>
      <!--filter by zip-->
      <form>
        <label for="filter_zip" id="filter_zip">Zip Code:&nbsp;</label>
        <input
          @click="numpadToggle"
          name="filter_zip"
          id="filter_zip"
          type="text"
          v-model="inputZip"
        />
        <!--number pad-->
        <div v-if="numpad == true" id="buttons">
          <button type="button" @click="removeText()" id="bc">
            &lt;==
          </button>
          <button type="button" @click="clearText()" id="clear">
            CLEAR
          </button>
          <button type="button" @click="numpadToggle()" id="bx">HIDE</button>
          <button type="button" @click="inputText(1)" id="b1">1</button>
          <button type="button" @click="inputText(2)" id="b2">2</button>
          <button type="button" @click="inputText(3)" id="b3">3</button>
          <button type="button" @click="inputText(4)" id="b4">4</button>
          <button type="button" @click="inputText(5)" id="b5">5</button>
          <button type="button" @click="inputText(6)" id="b6">6</button>
          <button type="button" @click="inputText(7)" id="b7">7</button>
          <button type="button" @click="inputText(8)" id="b8">8</button>
          <button type="button" @click="inputText(9)" id="b9">9</button>
          <button type="button" @click="inputText(0)" id="b0">0</button>
        </div>
      </form>
    <!--events view-->
    </div>
    <events
      class="home"
      id="home_events"
      :filteredEvents="filteredEvents"
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
    //sort and filter events
    filteredEvents() {
      //sort by date
      const listUnsorted = this.$store.state.events;
      const listSorted = listUnsorted.sort((a, b) => {
        return new Date(a.startTime) - new Date(b.startTime);
      });
      //filter by zipcode
      let zipFilter = listSorted.filter((e) => {
        return e.zip.toString().startsWith(this.inputZip) || !this.inputZip;
      });
      //filter by type
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
    //get imported list of tags
    eventTags() {
      return this.$store.state.eventTags;
    },
    //generate a non-repeating list of tags
    tagsAvailable() {
      let output = [""];
      this.$store.state.eventTags.forEach((t) => {
        if (!output.includes(t.tag)) {
          output.push(t.tag);
        }
      });
      return output;
    },
  },
  methods: {
    //number pad, input
    inputText(num) {
      if (this.inputZip !== "") {
        let zipString = this.inputZip.toString();
        let numString = num.toString();
        zipString = zipString.concat(numString);
        this.inputZip = zipString;
      } else {
        this.inputZip = num.toString();
      }
    },
    //number pad, remove characters
    removeText() {
      if (this.inputZip !== "") {
        this.inputZip = this.inputZip.slice(0, -1);
      }
    },
    //number pad, reset input
    clearText() {
      this.inputZip = "";
    },
    //number pad toggle
    numpadToggle() {
      this.numpad = !this.numpad;
    }
  },
};
</script>

<style>
/*grid view*/
.home_page {
  display: grid;
  grid-template-columns: 1fr 3fr;
  grid-template-areas:
    "header header"
    "filter events";
}
/*grid areas*/
#home_header {
  grid-area: header;
  margin: 16px 8px;
  font-size: larger;
}
.home_filter {
  grid-area: filter;
  background-color: #7EBDC2;
  margin: 8px;
  padding: 8px;
  border-radius: 12px;
  height: 95vh;
  position: -webkit-sticky;
  position: sticky;
  top: 1.3vh;
    border: 3px solid #275053;

}
#home_events {
  grid-area: events;
}
/*filter styling*/
#filter_header {
  font-size: xx-large;
  font-weight: bold;
  text-align: center;
  margin: 24px;
  margin-bottom: 12px;
}
#filter_tag{
  font-size: x-large;
  width: 90%;
  margin-bottom: 8px;
  
}
#filter_tag_options{
  font-size: small;
}
#filter_zip {
  font-size: x-large;
  width: 90%;
  margin-bottom: 8px;
}
/*touchscreen numbers styling*/
#buttons {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  grid-template-areas:
    "bc clear bx"
    "b7 b8 b9"
    "b4 b5 b6"
    "b1 b2 b3"
    "b0 b0 b0";
  margin-top: 8px;
  width: auto;
  height: 350px;
  border: 2px solid #231f20;
}
#bx {
  grid-area: bx;
  background-color: crimson;
}
#clear { grid-area: clear }
#bc { grid-area: bc }
#b0 { grid-area: b0 }
#b1 { grid-area: b1 }
#b2 { grid-area: b2 }
#b3 { grid-area: b3 }
#b4 { grid-area: b4 }
#b5 { grid-area: b5 }
#b6 { grid-area: b6 }
#b7 { grid-area: b7 }
#b8 { grid-area: b8 }
#b9 { grid-area: b9 }
#b0 { grid-area: b0 }
</style>