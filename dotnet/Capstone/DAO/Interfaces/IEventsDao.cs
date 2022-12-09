using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IEventsDao
    {
        List<Event> GetEvents();
        bool AddEvent(Event e);
        bool UpdateEvent(Event e);
        bool DeleteEvent(int eventId);
    }
}