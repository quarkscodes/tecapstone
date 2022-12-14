<template>
  <div>
    <form>
      <label for="">choose event</label>
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
    <div
      v-for="(event_tag, index) in this.$store.state.eventTags"
      :key="index"
      id="display_tags"
    >
      <p
        class="event"
        id="event_tag"
        v-if="event_tag.eventId == selectedEvent.eventId"
      >
        {{ event_tag.tag }}
      </p>
      <button @click="deleteTag(event_tag)" v-if="event_tag.eventId == selectedEvent.eventId">
        Delete Tag
      </button>
    </div>
    <div id="add_event_list">
      <form action="">
        <label for="">choose tag</label>
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
        <label for=""></label>
        <input type="text" v-model="selectedTagName" />
      </form>
    </div>
    <button @click="addTag()">Add Tag</button>
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
        eventId: ""
      },
      deletedTag: {
        tag: "",
        eventId: ""
      }
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
        })
        .catch((error) => {
          console.log(error.response.data.status);
        });
    },
    deleteTag(dTag) {
      this.deletedTag.tag = dTag.tag;
      this.deletedTag.eventId = dTag.eventId;
      console.log(this.deletedTag)
      EventTagsService.deleteEventTags(this.deletedTag)
        // .then((response) => {
        //   this.$store.commit(("SET_EVENT_TAGS", response.data));
        // })
        .catch((error) => {
          console.log(error.response.data.status);
        });
    }
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
      console.log("here" + selectedTags);
      //turn list from objects to strings
      selectedTags.forEach((t) => {
        if (!selectedTagsNames.includes(t.tag)) {
          selectedTagsNames.push(t.tag);
        }
      });
      console.log("here " + selectedTagsNames);
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
</style>