using Custom_HTML_Helper.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Custom_HTML_Helper.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            Employee emp = new Employee()
            {
                emp_Id = 1,
                emp_Name = "Awais",
                emp_City = "Lahore",
                emp_Email = "awaisbaig17@gmail.com",
                emp_Image = "Photos/img.png",
                alternate_Text = "Hello World!"
            };
            return View(emp);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";
            Employee newEmp = new Employee()
            {
                emp_Id = 2,
                emp_Name = "Zaid",
                emp_City = "Lahore",
                emp_Email = "zbaig@gmail.com",
                emp_Image = "~/Photos/employee.jpg",
                alternate_Text = "Hello World!"
            };
            return View(newEmp);
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}