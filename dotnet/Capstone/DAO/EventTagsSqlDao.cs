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
            "SELECT event_id, tag_name FROM event_tags;";
        private readonly string sqlDeleteEventTag =
            "DELETE FROM event_tags WHERE tag_name = @tag_name AND event_id = @event_id;";
        private readonly string sqlDeleteTagByEvent =
            "DELETE FROM event_tags WHERE event_id = @event_id;";
        private readonly string sqlAddNewEventTag =
            "INSERT INTO event_tags (tag_name, event_id) VALUES (@tag_name, @event_id);";

        public EventTagsSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<EventTag> GetEventTags()
        {
            List<EventTag> returnEventTags = new List<EventTag>();

            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlGetEventTags, conn);

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                EventTag temp = GetEventTagFromReader(reader);
                returnEventTags.Add(temp);
            }

            return returnEventTags;
        }

        public bool DeleteEventTag(EventTag tag)
        {
            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlDeleteEventTag, conn);
            cmd.Parameters.AddWithValue("@event_id", tag.EventId);
            cmd.Parameters.AddWithValue("@tag_name", tag.Tag);

            return cmd.ExecuteNonQuery() > 0;
        }

        public bool DeleteByEventId(int eventId)
        {
            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlDeleteTagByEvent, conn);
            cmd.Parameters.AddWithValue("@event_id", eventId);

            return cmd.ExecuteNonQuery() > 0;
        }

        public bool AddEventTag(EventTag tag)
        {
            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlAddNewEventTag, conn);
            cmd.Parameters.AddWithValue("@tag_name", tag.Tag);
            cmd.Parameters.AddWithValue("@event_id", tag.EventId);

            return cmd.ExecuteNonQuery() > 0;
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
