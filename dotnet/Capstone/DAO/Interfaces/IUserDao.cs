using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IUserDao
    {
        User GetUser(string username);
        List<User> GetUsers();
        User AddUser(RegisterUser user);
        bool UpdateUser(RegisterUser user);
    }
}
