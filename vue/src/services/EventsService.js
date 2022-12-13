import axios from 'axios';

export default {
  getEvents() {
    return axios.get('/events');
  },
  createEvent(event) {
    return axios.post('/events', event);
  },
  updateEvent(event) {
    return axios.put('/events', event);
  },
  deleteEvent(eventId) {
    return axios.delete('/events/' + eventId);
  }
}
