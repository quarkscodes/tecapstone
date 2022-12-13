using Microsoft.AspNetCore.Mvc;
using Capstone.DAO;
using Capstone.Models;
using Capstone.Security;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;

namespace Capstone.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize]
    public class EventsController : Controller
    {
        private readonly IEventsDao eventsDao;
        private readonly IUserDao userDao;
        private readonly IEventTagsDao eventTagsDao;


        public EventsController(IEventsDao _eventsDao, IUserDao _userDao, IEventTagsDao _eventTagsDao)
        {
            eventsDao = _eventsDao;
            userDao = _userDao;
            eventTagsDao = _eventTagsDao;
        }

        [HttpGet]
        [AllowAnonymous]
        public IActionResult GetEvents()
        {
            List<Event> events = eventsDao.GetEvents();

            if (events != null && events.Count > 0)
            {
                return Ok(events);
            }
            else
            {
                return BadRequest("Database not responding");
            }
        }
        [HttpPost]
        public IActionResult AddEvent(Event e)
        {
                bool added = eventsDao.AddEvent(e);

                if (added)
                {
                    return Ok(e);
                }
                else
                {
                    return BadRequest("Database not responding");
                }
        }
        [HttpPut]
        public IActionResult UpdateEvent(Event e)
        {
            if (e.UserId == userDao.GetUser(User.Identity.Name).UserId)
            {
                bool updated = eventsDao.UpdateEvent(e);

                if (updated)
                {
                    return Ok(e);
                }
                else
                {
                    return BadRequest("Database not responding");
                }
            }
            else
            {
                return Unauthorized("Not Authorized");
            }
        }
        [HttpDelete("{eventId}")]
        public IActionResult DeleteEvent(int eventId)
        {
            if (eventsDao.GetEvent(eventId).UserId == userDao.GetUser(User.Identity.Name).UserId)
            {
                eventTagsDao.DeleteByEventId(eventId);

                bool deleted = eventsDao.DeleteEvent(eventId);

                if (deleted)
                {
                    return Ok(eventId);
                }
                else
                {
                    return BadRequest("Database not responding");
                }
            }
            else
            {
                return Unauthorized("Not Authorized");
            }
        }
    }
}
