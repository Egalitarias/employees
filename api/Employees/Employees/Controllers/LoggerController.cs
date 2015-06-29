using Employees.Resource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;

namespace Employees.Controllers
{
    public class LoggerController : BaseController
    {
        // Content-Type: application/json
        // {"Name" : "Joe", "Address" : "1 First St", "PhoneNo" : "012345678", "MobileNo" : "041234567", "EmployeeId", 5}
        [HttpPost]
        public Object Post(LogResource logResource)
        {
            //LogRequest();
            Console.WriteLine(logResource.Message);

            return logResource;
        }
    }
}
