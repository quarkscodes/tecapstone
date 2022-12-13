using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IEventsDao
    {
        Event GetEvent(int EventId);
        List<Event> GetEvents();
        bool AddEvent(Event e);
        bool UpdateEvent(Event e);
        bool DeleteEvent(int eventId);
    }
}