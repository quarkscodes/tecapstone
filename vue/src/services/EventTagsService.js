import axios from 'axios'

export default {
  getEventTags() {
    return axios.get('/eventtags')
  },
  createEventTags(tag) {
    return axios.post('/eventtags', tag)
  },
  deleteEventTags(tag) {
    return axios.delete('/eventtags', tag)
  }
}
