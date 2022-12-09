using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO
{
    public class EventTagsSqlDao : IEventTagsDao
    {
        private readonly string connectionString;
        private readonly string sqlGetEventTags =
            "SELECT event_id, tag_name FROM event_tags";

        public EventTagsSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<EventTag> GetEventTags()
        {
            List<EventTag> returnEventTags = new List<EventTag>();

            try
            {
                using SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();

                SqlCommand cmd = new SqlCommand(sqlGetEventTags, conn);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    EventTag temp = GetEventTagFromReader(reader);
                    returnEventTags.Add(temp);
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnEventTags;
        }

        private EventTag GetEventTagFromReader(SqlDataReader reader)
        {
            EventTag e = new EventTag()
            {
                EventId = Convert.ToInt32(reader["event_id"]),
                Tag = Convert.ToString(reader["tag_name"]),
            };

            return e;
        }
    }
}
