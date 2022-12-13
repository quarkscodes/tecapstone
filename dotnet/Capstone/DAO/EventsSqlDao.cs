using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO
{
    public class EventsSqlDao : IEventsDao
    {
        private readonly string connectionString;
        private readonly string sqlGetEvent = "SELECT event_id, name, description, img_url, start_time, end_time, address, state, city, zip, user_id FROM events WHERE event_id = @event_id;";
        private readonly string sqlGetEvents =
            "SELECT event_id, name, description, img_url, start_time, end_time, address, state, city, zip, user_id FROM events;";
        private readonly string sqlAddEvent =
            "INSERT INTO events (name, description, img_url, start_time, end_time, address, state, city, zip, user_id) VALUES (@name, @description, @img_url, @start_time, @end_time, @address, @state, @city, @zip, @user_id);";
        private readonly string sqlUpdateEvent =
            "UPDATE events SET name = @name, description = @description, img_url = @img_url, start_time = @start_time, end_time = @end_time, address = @address, state = @state, city = @city, zip = @zip, user_id = @user_id WHERE event_id = @event_id;";
        private readonly string sqlDeleteEvent =
            "DELETE FROM events WHERE event_id = @event_id;";

        public EventsSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<Event> GetEvents()
        {
            List<Event> returnEvents = new List<Event>();


            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlGetEvents, conn);

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Event temp = GetEventFromReader(reader);
                returnEvents.Add(temp);
            }

            return returnEvents;
        }

        public Event GetEvent(int EventId)
        {
            Event returnEvent = null;

            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlGetEvent, conn);
            cmd.Parameters.AddWithValue("@event_id", EventId);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                returnEvent = GetEventFromReader(reader);
            }

            return returnEvent;
        }


        public bool AddEvent(Event e)
        {
            DateTime startTime = DateTime.Parse(e.StartTime);
            DateTime endTime = DateTime.Parse(e.EndTime);
            int rowsAffected;

            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(sqlAddEvent, conn);
            cmd.Parameters.AddWithValue("@name", e.Name);
            cmd.Parameters.AddWithValue("@description", e.Description);
            cmd.Parameters.AddWithValue("@img_url", e.ImgUrl);
            cmd.Parameters.AddWithValue("@start_time", startTime);
            cmd.Parameters.AddWithValue("@end_time", endTime);
            cmd.Parameters.AddWithValue("@address", e.Address);
            cmd.Parameters.AddWithValue("@city", e.City);
            cmd.Parameters.AddWithValue("@state", e.State);
            cmd.Parameters.AddWithValue("@zip", e.Zip);
            cmd.Parameters.AddWithValue("@user_id", e.UserId);

            rowsAffected = cmd.ExecuteNonQuery();

            return rowsAffected > 0;
        }
        public bool UpdateEvent(Event e)
        {
            int rowsAffected;

            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(sqlUpdateEvent, conn);
            cmd.Parameters.AddWithValue("@name", e.Name);
            cmd.Parameters.AddWithValue("@description", e.Description);
            cmd.Parameters.AddWithValue("@img_url", e.ImgUrl);
            cmd.Parameters.AddWithValue("@start_time", e.StartTime);
            cmd.Parameters.AddWithValue("@end_time", e.EndTime);
            cmd.Parameters.AddWithValue("@address", e.Address);
            cmd.Parameters.AddWithValue("@city", e.City);
            cmd.Parameters.AddWithValue("@state", e.State);
            cmd.Parameters.AddWithValue("@zip", e.Zip);
            cmd.Parameters.AddWithValue("@event_id", e.EventId);
            cmd.Parameters.AddWithValue("@user_id", e.UserId);

            rowsAffected = cmd.ExecuteNonQuery();

            return rowsAffected > 0;
        }
        public bool DeleteEvent(int eventId)
        {
            //todo delete all references (event_tags) to event id

            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(sqlDeleteEvent, conn);
            cmd.Parameters.AddWithValue("@event_id", eventId);

            cmd.ExecuteNonQuery();

            return true;
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
                Address = Convert.ToString(reader["address"]),
                State = Convert.ToString(reader["state"]),
                City = Convert.ToString(reader["city"]),
                Zip = Convert.ToInt32(reader["zip"]),
                UserId = Convert.ToInt32(reader["user_id"])
            };

            return e;
        }
    }
}
