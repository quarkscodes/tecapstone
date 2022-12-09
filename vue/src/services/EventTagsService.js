import axios from 'axios'

export default {
    getEventTags() {
      return axios.get('/eventtags')
    }
  }
  