using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;
using Capstone.Security;
using Capstone.Security.Models;

namespace Capstone.DAO
{
    public class UserSqlDao : IUserDao
    {
        private readonly string connectionString;

        private readonly string sqlGetUser = "SELECT * FROM users " +
            "WHERE username = @username;";

        private readonly string sqlGetUsers = "SELECT * FROM users; ";

        private readonly string sqlAddUser = "INSERT INTO users (username, password_hash, salt, user_role, organization, location, name, phone, email) " +
            "VALUES(@username, @password_hash, @salt, @user_role, @organization, @location, @name, @phone, @email)";

        private readonly string sqlUpdateUser = "UPDATE users SET username = @username, password_hash = @password_hash, salt = @salt, user_role = @user_role, organization = @organization, name = @name, location = @location, phone = @phone, email = @email WHERE user_id = @user_id;";


        public UserSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public User GetUser(string username)
        {
            User returnUser = null;

            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlGetUser, conn);
            cmd.Parameters.AddWithValue("@username", username);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                returnUser = GetUserFromReader(reader);
            }

            return returnUser;
        }

        public List<User> GetUsers()
        {
            List<User> returnUsers = new List<User>();

            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlGetUsers, conn);

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                User temp = GetUserFromReader(reader);
                returnUsers.Add(temp);
            }

            return returnUsers;
        }

        public User AddUser(RegisterUser user)
        {
            IPasswordHasher passwordHasher = new PasswordHasher();
            PasswordHash hash = passwordHasher.ComputeHash(user.Password);

            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlAddUser, conn);
            cmd.Parameters.AddWithValue("@username", user.Username);
            cmd.Parameters.AddWithValue("@password_hash", hash.Password);
            cmd.Parameters.AddWithValue("@salt", hash.Salt);
            cmd.Parameters.AddWithValue("@user_role", user.Role);
            cmd.Parameters.AddWithValue("@organization", user.Organization);
            cmd.Parameters.AddWithValue("@location", user.Location);
            cmd.Parameters.AddWithValue("@name", user.Name);
            cmd.Parameters.AddWithValue("@phone", user.Phone);
            cmd.Parameters.AddWithValue("@email", user.Email);
            cmd.ExecuteNonQuery();

            return GetUser(user.Username);
        }

        public bool UpdateUser(RegisterUser user)
        {
            IPasswordHasher passwordHasher = new PasswordHasher();
            PasswordHash hash = passwordHasher.ComputeHash(user.Password);

            using SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand(sqlUpdateUser, conn);
            cmd.Parameters.AddWithValue("@username", user.Username);
            cmd.Parameters.AddWithValue("@password_hash", hash.Password);
            cmd.Parameters.AddWithValue("@salt", hash.Salt);
            cmd.Parameters.AddWithValue("@user_role", user.Role);
            cmd.Parameters.AddWithValue("@organization", user.Organization);
            cmd.Parameters.AddWithValue("@location", user.Location);
            cmd.Parameters.AddWithValue("@name", user.Name);
            cmd.Parameters.AddWithValue("@phone", user.Phone);
            cmd.Parameters.AddWithValue("@email", user.Email);
            cmd.Parameters.AddWithValue("@user_id", user.UserId);
            return cmd.ExecuteNonQuery() > 0;
        }

        private User GetUserFromReader(SqlDataReader reader)
        {
            User u = new User()
            {
                UserId = Convert.ToInt32(reader["user_id"]),
                Username = Convert.ToString(reader["username"]),
                PasswordHash = Convert.ToString(reader["password_hash"]),
                Salt = Convert.ToString(reader["salt"]),
                Role = Convert.ToString(reader["user_role"]),
                Organization = Convert.ToString(reader["organization"]),
                Location = Convert.ToString(reader["location"]),
                Name = Convert.ToString(reader["name"]),
                Phone = Convert.ToString(reader["phone"]),
                Email = Convert.ToString(reader["email"]),
            };

            return u;
        }
    }
}
