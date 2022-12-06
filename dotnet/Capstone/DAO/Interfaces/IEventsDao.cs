using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IEventsDao
    {
        List<Event> GetEvents();

        //possible error, string or int?
        //Event GetEvent(int eventId);
        //what parameters?
        //Event AddEvent();
    }
}