using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;
using Capstone.Security;
using Capstone.Security.Models;

namespace Capstone.DAO
{
    public class EventsSqlDao : IEventsDao
    {
        private readonly string connectionString;
        private readonly string sqlGetEvents =
            "SELECT event_id, name, description, img_url, start_time, end_time, tag, location FROM events";

        public EventsSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<Event> GetEvents()
        {
            List<Event> returnEvents = new List<Event>();

            try
            {
                using SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();

                SqlCommand cmd = new SqlCommand(sqlGetEvents, conn);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Event temp = GetEventFromReader(reader);
                    returnEvents.Add(temp);
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnEvents;
        }

        private Event GetEventFromReader(SqlDataReader reader)
        {
            Event e = new Event()
            {
                EventId = Convert.ToInt32(reader["event_id"]),
                Name = Convert.ToString(reader["name"]),
                Description = Convert.ToString(reader["description"]),
                ImgUrl = Convert.ToString(reader["img_url"]),
                StartTime = Convert.ToString(reader["start_time"]),
                EndTime = Convert.ToString(reader["end_time"]),
                Tag = Convert.ToString(reader["tag"]),
                Location = Convert.ToString(reader["location"])

            };

            return e;
        }
    }
}
