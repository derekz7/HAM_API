using Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.DAO
{
    public class UserDAO
    {
        DBContext db = null;

        public UserDAO() { db = new DBContext(); }
        public String Insert(tbl_user user)
        {
            db.tbl_user.Add(user);
            db.SaveChanges();
            return user.id;

        }

        public bool Login(String username, String password)
        {
            var result = db.tbl_user.Count(x => x.username == username && x.pw == password);
            if (result > 0)
            {
                return true;
            }
            else { return false; }
        }
    }
}
