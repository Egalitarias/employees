using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Employees.Resource;

namespace Employees.Controllers
{
    public class VersionController : BaseController
    {

        VersionController()
        {
        }

        // http://localhost:8080/api/version
        // http://localhost:8080/api/version
        public Object Get()
        {
            LogRequest();

            return GetAttribute("Version");
        }

    }
}
 