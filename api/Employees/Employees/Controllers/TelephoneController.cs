using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Employees.Resource;

namespace Employees.Controllers
{
    public class TelephoneController : BaseController
    {

        TelephoneController()
        {
        }

        // http://localhost:8080/api/telephone
        // http://localhost:8080/api/telephone?TelephoneId=2
        public List<Telephone> Get(int telephoneId = -1)
        {
            LogRequest();

            if (telephoneId == -1)
            {
                var list = _db.Telephones.ToList();
                return list;
            }
            else
            {
                var list = _db.Telephones.Where(x => x.TelephoneId == telephoneId).ToList();
                return list;
            }
        }

        // Content-Type: application/json
        // {"Number" : "96783456", "EmployeeId" : 5}
        [HttpPost]
        public Object Post(TelephoneResource telephoneResource)
        {
            LogRequest();

            if (telephoneResource == null) { return "Telephone is required"; }
            if (telephoneResource.Number == null) { return "Telephone.Number is required"; }
            if (telephoneResource.EmployeeId <= 0) { return "Telephone.EmployeeId is required"; }

            var telephone = new Telephone
            {
                Number = SafeTrim(telephoneResource.Number),
                EmployeeId = telephoneResource.EmployeeId
            };
            _db.Telephones.Add(telephone);
            _db.SaveChanges();

            return telephone;
        }

        public Object Delete(int telephoneId)
        {
            LogRequest();

            var list = _db.Telephones.Where(x => x.TelephoneId == telephoneId);
            if (list.Any())
            {
                Telephone deleted = list.First();
                _db.Telephones.Remove(deleted);
                _db.SaveChanges();
                return deleted;
            }

            return null;
        }

        // Content-Type: application/json
        // {"TelephoneId" : 24, "Number" : "95673456", "EmployeeId" : 5}
        [HttpPut]
        public Object Put(TelephoneResource telephoneResource)
        {
            LogRequest();

            if (telephoneResource == null) { return "Telephone is required"; }
            if (telephoneResource.TelephoneId == null) { return "Telephone.TelephoneId is required"; }

            int telephoneId = telephoneResource.TelephoneId.Value;
            var list = _db.Telephones.Where(x => x.TelephoneId == telephoneId);
            Telephone telephone = null;

            if (list.Any())
            {
                telephone = list.First();
                telephone.Number = SafeTrim(telephoneResource.Number);
                telephone.EmployeeId = telephoneResource.EmployeeId;
                _db.SaveChanges();
            }

            return telephone;
        }
    }
}
