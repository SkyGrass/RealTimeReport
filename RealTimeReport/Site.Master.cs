using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RealTimeReport
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public string SysTitle = System.Configuration.ConfigurationManager.AppSettings["sysTitle"].ToString() ?? "实时库存看板";
        protected void Page_Init(object sender, EventArgs e)
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            ZYSoft.DB.Common.Configuration.ConnectionString = connStr;

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {

        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}