using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace HAM_API
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
            name: "SearchUser",
            url: "User/Search",
            defaults: new { controller = "User", action = "Search" }
            );

            routes.MapRoute(
            name: "SearchDoctor",
            url: "Doctor/Search",
            defaults: new { controller = "Doctor", action = "Search" }
            );
            routes.MapRoute(
            name: "SearchPatient",
            url: "Patient/Search",
            defaults: new { controller = "Patient", action = "Search" }
            );

        }
    }
}
