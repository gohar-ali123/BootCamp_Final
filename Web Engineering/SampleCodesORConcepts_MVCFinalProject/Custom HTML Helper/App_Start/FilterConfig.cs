﻿using System.Web;
using System.Web.Mvc;

namespace Custom_HTML_Helper
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
