using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface IEventTagsDao
    {
        List<EventTag> GetEventTags();
        bool DeleteByEventId(int eventId);
        bool DeleteEventTag(EventTag tag);
        bool AddEventTag(EventTag tag);
    }
}
