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

        public EventsController (IEventsDao _eventsDao)
        {
            eventsDao = _eventsDao;
        }

        [HttpGet()]
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
    }
}
