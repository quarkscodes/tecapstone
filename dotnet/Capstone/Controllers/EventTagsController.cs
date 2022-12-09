﻿using Microsoft.AspNetCore.Mvc;
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
    public class EventTagsController : Controller
    {
        private readonly IEventTagsDao eventTagsDao;

        public EventTagsController(IEventTagsDao _eventTagsDao)
        {
            eventTagsDao = _eventTagsDao;
        }

        [HttpGet()]
        [AllowAnonymous]
        public IActionResult GetEventTags()
        {
            List<EventTag> eventTags = eventTagsDao.GetEventTags();

            if (eventTags != null && eventTags.Count > 0)
            {
                return Ok(eventTags);
            }
            else
            {
                return BadRequest("Database not responding");
            }
        }
    }
}
