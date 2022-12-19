using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication1.Controllers
{
    [Route("Home")]
    public class HomeController : Controller
    {
        [Route("")]
        public ActionResult Index()
        {
            ViewBag.Message = "Welcome to ASP.NET Index Page.";
            return View();
        }

        [Route("MVCRoute-About/{customerName?}")]
        public ActionResult About(string customerName)
        {
            ViewBag.Message = "Welcome to ASP.NET About Page. " + customerName;
            return View();
        }

        [Route("~/MVCRoute-Contact")] //When we use a tide (~) sign with the Route attribute, it will override the route prefix.
        public ActionResult Contact()
        {
            ViewBag.Message = "Welcome to ASP.NET Contact Page.";
            return View();
        }
    }
}