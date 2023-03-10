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
        bool DeleteEventTag(EventTag tag);
        bool DeleteByEventId(int eventId);
        bool AddEventTag(EventTag tag);
    }
}
