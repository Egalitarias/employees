using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace Employees.Controllers
{
    public class BaseController : ApiController
    {
        protected readonly EmployeesEntities _db;
        private IQueryable<Attribute> _attributes; 

        public BaseController()
        {
            _db = new EmployeesEntities();
            _attributes = null;
        }

        protected void LogRequest()
        {
            Console.WriteLine(Request.ToString());
        }

        protected String SafeTrim(String str)
        {
            if (str == null)
            {
                return "";
            }

            return str.Trim();
        }

        public string GetAttribute(string name)
        {
            if (_attributes == null)
            {
                _attributes = _db.Attributes;
            }

            var list = _attributes.Where(x => x.Name == name);
            if (list.Any())
            {
                return list.First().Value;
            }
            else
            {
                return "";
            }
        }
    }
   

}
