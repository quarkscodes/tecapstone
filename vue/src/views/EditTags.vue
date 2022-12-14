<template>
  <div class="edit_tags">
    <div id="tags_head">
      <p id="tags_head">Event Tags</p>
    </div>
    <div id="tags_edit">
      <form>
        <label for="">Choose an event: </label>
        <select name="" id="" v-model="selectedEvent">
          <option
            v-for="(event, index) in filteredEvents"
            :key="index"
            :value="event"
          >
            {{ event.name }}
          </option>
        </select>
      </form>
    </div>
    <div id="tags_edit">
      <p>Tags associated:</p>
      <ul>
        <div
          v-for="(event_tag, index) in this.$store.state.eventTags"
          :key="index"
          id="display_tags"
        >
          <li
            class="event"
            id="event_tag"
            v-if="event_tag.eventId == selectedEvent.eventId"
          >
            {{ event_tag.tag }}
          </li>
        </div>
      </ul>
    </div>
    <div id="tags_edit">
      <div id="add_event_list">
        <form action="">
          <label for="">Choose an existing tag: </label>
          <select name="" id="" v-model="selectedTagName">
            <option
              v-for="(tag, index) in filteredTagsAvailable"
              :key="index"
              :value="tag"
            >
              {{ tag }}
            </option>
          </select>
        </form>
      </div>
      <div id="add_event_manual">
        <form action="">
          <label for="">Or create your own: </label>
          <input type="text" v-model="selectedTagName" />
        </form>
      </div>
    </div>
    <div id="submit_tag">
      <button id="submit_tag_button" type="submit" @click="addTag()">Add Tag</button>
    </div>
  </div>
</template>

<script>
import EventTagsService from "../services/EventTagsService.js";

export default {
  name: "editTags",
  data() {
    return {
      selectedEvent: {},
      selectedTagName: "",
      addedTag: {
        tag: "",
        eventId: "",
      },
    };
  },
  methods: {
    getTags() {
      EventTagsService.getEventTags()
        .then((response) => {
          this.$store.commit(("SET_EVENT_TAGS", response.data));
        })
        .catch((error) => {
          console.log(error.response.data.status);
        });
    },
    addTag() {
      this.addedTag.eventId = this.selectedEvent.eventId;
      this.addedTag.tag = this.selectedTagName;
      EventTagsService.createEventTags(this.addedTag)
        .then((response) => {
          this.$store.commit(("SET_EVENT_TAGS", response.data));
         alert("Success: added tag to event");
         this.$router.go()
        })
        .catch((error) => {
          console.log(error.response.data.status);
          alert("Unable to add tag, try again");
        });
    },
  },
  computed: {
    filteredEvents() {
      const sorted = this.$store.state.events;
      console.log("sorted = " + sorted);
      let userFilter = sorted.filter((e) => {
        return e.userId == this.$store.state.user.userId;
      });
      return userFilter;
    },
    filteredTagsAvailable() {
      //set up variables
      let result = [];
      const TagsList = this.$store.state.eventTags;
      let selectedTagsNames = [];
      //create list of used tags
      let selectedTags = TagsList.filter((t) => {
        return t.eventId == this.selectedEvent.eventId;
      });
      //turn list from objects to strings
      selectedTags.forEach((t) => {
        if (!selectedTagsNames.includes(t.tag)) {
          selectedTagsNames.push(t.tag);
        }
      });
      //all possible tags as strings
      let TagsListNames = [];
      TagsList.forEach((t) => {
        TagsListNames.push(t.tag);
      });
      //for each string possible
      //if result doesn't contain the string
      //and used tags doesn't include the string
      TagsListNames.forEach((t) => {
        if (!result.includes(t) && !selectedTagsNames.includes(t)) {
          result.push(t);
        }
      });
      return result;
    },
  },
};
</script>

<style>
.edit_tags {
  display: flexbox;
  justify-content: center;
  background-color: #7ebdc2;
  padding: 5%;
  margin: 32px 15%;
}
div#tags_head {
  background: #efe6dd;
  border: 2px solid black;
  padding: 2px;
  margin: 4px;
  margin-bottom: 12px;
  border-radius: 4px;
}
p#tags_head {
  text-align: center;
  font-weight: bold;
  font-size: x-large;
}
#tags_edit {
  display: flexbox;
  background: #efe6dd;
  padding: 12px;
  margin: 4px;
  border-radius: 4px;
}
#tags_edit input {
  width: 98%;
}
#tags_edit li {
  font-size: medium;
  padding: 0px;
}
#submit_tag {
  text-align: center;
}
#submit_tag_button {
  width: 60%;
  font-size: larger;
}
.edit_tags button{
  margin: 8px;
  margin-bottom: 0px;
  padding: 4px;
}
#add_event_list{
  padding-bottom: 8px;
}
</style>