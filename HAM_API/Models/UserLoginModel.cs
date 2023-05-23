using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace HAM_API.Models
{
    public class UserLoginModel
    {
        [DataType(DataType.EmailAddress)]
        public string email { get; set; }

        [DataType(DataType.Password)]
        public string password { get; set; }
    }
}