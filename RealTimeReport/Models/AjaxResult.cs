using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RealTimeReport
{
    public class AjaxResult
    {
        public string state { get; set; }
        public string msg { get; set; }
        public object data { get; set; }
    }
}