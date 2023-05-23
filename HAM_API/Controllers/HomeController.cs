using HAM_API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Mvc;

namespace HAM_API.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        
        public ActionResult Login()
        {
            return View();
        }

        HttpClient client = new HttpClient();
        public ActionResult Autherize(UserLoginModel user)
        {
            client.BaseAddress = new Uri("https://localhost:44351/api/User/");
            var response = client.GetAsync(string.Format("Login?email={0}&password={1}", user.email, user.password));
            response.Wait();

            var test = response.Result;
            if (test.IsSuccessStatusCode)
            {
                var check = test.Content.ReadAsAsync<bool>();
                check.Wait();
                bool log = check.Result;
                if (log)
                {
                    return RedirectToAction("Index", "Home");
                }
            }
            return RedirectToAction("Login", "Home");
        }
    }
}