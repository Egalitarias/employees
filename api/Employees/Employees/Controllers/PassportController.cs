using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Employees.Resource;

namespace Employees.Controllers
{
    public class PassportController : BaseController
    {

        PassportController()
        {
        }

        // http://localhost:8080/api/passport
        // http://localhost:8080/api/passport?PassPortId=2
        public List<Passport> Get(int passportId = -1)
        {
            LogRequest();

            if (passportId == -1)
            {
                var list = _db.Passports.ToList();
                return list;
            }
            else
            {
                var list = _db.Passports.Where(x => x.PassportId == passportId).ToList();
                return list;
            }
        }

        // Content-Type: application/json
        // {"PassportNumber" : "4567345", "Nationality" : "Australian", "VisaType" : "Wok", "VisaNumber" : "457345", "EmployeeId", 5}
        [HttpPost]
        public Object Post(PassportResource passportResource)
        {
            LogRequest();

            if (passportResource == null) { return "Passport is required"; }
            if (passportResource.PassportNumber == null) { return "Passport.PassportNumber is required"; }
            if (passportResource.Nationality == null) { return "Passport.Nationality is required"; }
            if (passportResource.VisaType == null) { return "Passport.VisaType is required"; }
            if (passportResource.VisaNumber == null) { return "Passport.VisaNumber is required"; }
            if (passportResource.EmployeeId <= 0) { return "Passport.EmployeeId is required"; }

            var passport = new Passport
            {
                PassportNumber = SafeTrim(passportResource.PassportNumber),
                Nationality = SafeTrim(passportResource.Nationality),
                VisaType = SafeTrim(passportResource.VisaType),
                VisaNumber = SafeTrim(passportResource.VisaNumber),
                VisasIssueDate = passportResource.VisasIssueDate,
                VisasExpiryDate = passportResource.VisasExpiryDate,
                EmployeeId = passportResource.EmployeeId
            };
            _db.Passports.Add(passport);
            _db.SaveChanges();

            return passport;
        }

        public Object Delete(int passportId)
        {
            LogRequest();

            var list = _db.Passports.Where(x => x.PassportId == passportId).ToList();
            if (list.Any())
            {
                Passport deleted = list.First();
                _db.Passports.Remove(deleted);
                _db.SaveChanges();
                return deleted;
            }

            return null;
        }

        // Content-Type: application/json
        // {"PassportId" : 24, "PassportNumber" : "4567345", "Nationality" : "Australian", "VisaType" : "Wok", "VisaNumber" : "457345", "EmployeeId", 5}
        [HttpPut]
        public Object Put(PassportResource passportResource)
        {
            LogRequest();

            if (passportResource == null) { return "Passport is required"; }
            if (passportResource.PassportId == null) { return "Passport.PassportId is required"; }

            int passportId = passportResource.PassportId.Value;
            var list = _db.Passports.Where(x => x.PassportId == passportId).ToList();
            Passport passport = null;

            if (list.Any())
            {
                passport = list.First();
                passport.PassportNumber = SafeTrim(passportResource.PassportNumber);
                passport.Nationality = SafeTrim(passportResource.Nationality);
                passport.VisaType = SafeTrim(passportResource.VisaType);
                passport.VisaNumber = SafeTrim(passportResource.VisaNumber);
                passport.VisasIssueDate = passportResource.VisasIssueDate;
                passport.VisasExpiryDate = passportResource.VisasExpiryDate;
                passport.EmployeeId = passportResource.EmployeeId;
                _db.SaveChanges();
            }

            return passport;
        }
    }
}
