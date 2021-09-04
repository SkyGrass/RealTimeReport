using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RealTimeReport
{
    public partial class Report : System.Web.UI.Page
    {
        public int Cols = int.Parse(System.Configuration.ConfigurationManager.AppSettings["cols"].ToString() ?? "2");
        public int Interval = int.Parse(System.Configuration.ConfigurationManager.AppSettings["interval"].ToString() ?? "120");
        public int FontSize = int.Parse(System.Configuration.ConfigurationManager.AppSettings["fontSize"].ToString() ?? "24");
        public string PageTitle = System.Configuration.ConfigurationManager.AppSettings["pageTitle"].ToString() ?? "实时库存看板";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {

            }
        }
    }
}