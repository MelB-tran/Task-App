using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using WebApplication1.AppCode;

namespace WebApplication1.services
{
    /// <summary>
    /// Summary description for TaskService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class TaskService : System.Web.Services.WebService
    {
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GetAllTasks()
        {
            var allTasks = this.GenerateTasks();
            
            this.Context.Response.ContentType = "application/json; charset=utf-8";
            this.Context.Response.Write(new JavaScriptSerializer().Serialize(allTasks));
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void AddTask()
        {

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void UpdateTask()
        {
           
        }

        public List<Task> GenerateTasks()
        {
            var task1 = new Task
            {
                TaskId = 1,
                Title = "Buy a boat",
                Description = "Boats are cool, get a boat!",
                IsDone = false,
                StartDate = new DateTime(2016, 10, 2),
                DueDate = new DateTime(2016, 11, 12)
            };
            var task2 = new Task
            {
                TaskId = 2,
                Title = "Dye my hair",
                Description = "Dye my hair blue, need to get some hair bleacher",
                IsDone = false,
                StartDate = new DateTime(2016, 10, 1),
                DueDate = new DateTime(2016, 10, 31)
            };
            var task3 = new Task
            {
                TaskId = 3,
                Title = "Make doctors appointment",
                Description = "Call 501-450-3029 to make appt",
                IsDone = false,
                StartDate = new DateTime(2016, 4, 1),
                DueDate = new DateTime(2016, 4, 30)
            };
            return new List<Task> { task1, task2, task3 };
        }
    }
}
