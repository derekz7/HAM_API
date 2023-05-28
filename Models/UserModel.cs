using Models.Framework;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class UserModel
    {
        private DBContext db = null;

        public UserModel()
        {
            db = new DBContext();
        }

        public bool Login(string email, string password)
        {
            object[] sqlParameters =
            {
                new SqlParameter("@email",email),
                new SqlParameter("@password",password)
            };
            var res = db.Database.SqlQuery<bool>("")
        }

    }
}
