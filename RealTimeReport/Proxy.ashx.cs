using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace RealTimeReport
{
    /// <summary>
    /// Proxy 的摘要说明
    /// </summary>
    public class Proxy : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            var action = context.Request["action"] ?? "query";
            var result = new AjaxResult();
            try
            {
                result.state = "success";
                result.msg = "查询成功!";
                switch (action)
                {
                    case "query":
                        string cmdText = string.Format(@"EXEC P_ZYSoft_GetCurrentStock");
                        DataTable dtInfo = ZYSoft.DB.BLL.Common.ExecuteDataTable(cmdText);
                        result.data = DataTable2Dic(dtInfo);
                        break;
                }

            }
            catch (Exception e)
            {
                result.state = "error";
                result.msg = e.Message;
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            context.Response.Write(serializer.Serialize(result));
        }

        public List<Dictionary<string, string>> DataTable2Dic(DataTable dt)
        {
            List<Dictionary<string, string>> list = new List<Dictionary<string, string>>();
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                foreach (DataColumn column in dt.Columns)
                {
                    dic[column.ColumnName] =
                        dr[column.ColumnName] == DBNull.Value ? "" : dr[column.ColumnName].ToString();
                }
                list.Add(dic);
            }
            return list;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}