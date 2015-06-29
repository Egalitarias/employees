using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Employees.Resource;

namespace Employees.Controllers
{
    public class EmployeeController : BaseController
    {

        EmployeeController()
        {
        }

        // http://localhost:8080/api/employee
        // http://localhost:8080/api/employee?EmployeeId=2
        public List<Employee> Get(int employeeId = -1)
        {
            LogRequest();

            if (employeeId == -1)
            {
                var list = _db.Employees.ToList();
                return list;
            }
            else
            {
                var list = _db.Employees.Where(x => x.EmployeeId == employeeId).ToList();
                return list;
            }
        }

        // Content-Type: application/json
        // {"Name" : "Joe", "Address" : "1 First St", "PhoneNo" : "012345678", "MobileNo" : "041234567", "EmployeeId", 5}
        [HttpPost]
        public Object Post(EmployeeResource employeeResource)
        {
            LogRequest();

            if (employeeResource == null) { return "Employee is required"; }
            if (employeeResource.Address == null) { return "Employee.Address is required"; }

            var employee = new Employee
            {
                FamilyName = SafeTrim(employeeResource.FamilyName),
                GivenName = SafeTrim(employeeResource.GivenName),
                DateOfBirth = employeeResource.DateOfBirth,
                Title = SafeTrim(employeeResource.Title),
                Address = SafeTrim(employeeResource.Address),
                Telephone = SafeTrim(employeeResource.Telephone),
                Mobile = SafeTrim(employeeResource.Mobile),
                Email = SafeTrim(employeeResource.Email),
                TaxFileNumber = SafeTrim(employeeResource.TaxFileNumber),
                CompanyName = SafeTrim(employeeResource.CompanyName),
                AustralianBusinessNumber = SafeTrim(employeeResource.AustralianBusinessNumber),
                BSBNumber = SafeTrim(employeeResource.BSBNumber),
                AccountNumber = SafeTrim(employeeResource.AccountNumber),
                BankName = SafeTrim(employeeResource.BankName),
                BankBranch = SafeTrim(employeeResource.BankBranch),
                AccountName = SafeTrim(employeeResource.AccountName),
                SuperFundName = SafeTrim(employeeResource.SuperFundName),
                MemberNumber = SafeTrim(employeeResource.MemberNumber),
                QantasFrequentFlyerNumber = SafeTrim(employeeResource.QantasFrequentFlyerNumber),
                VirginVelocityNumber = SafeTrim(employeeResource.VirginVelocityNumber),
                EmiratesSkywardsNumber = SafeTrim(employeeResource.EmiratesSkywardsNumber),
                OthersNumber = SafeTrim(employeeResource.OthersNumber)
            };
            _db.Employees.Add(employee);
            _db.SaveChanges();

            return employee;
        }

        public Object Delete(int employeeId)
        {
            LogRequest();

            var list = _db.Employees.Where(x => x.EmployeeId == employeeId).ToList();
            if (list.Any())
            {
                Employee deleted = list.First();
                _db.Employees.Remove(deleted);
                _db.SaveChanges();
                return deleted;
            }

            return null;
        }

        // Content-Type: application/json
        // {"EmployeeId":20,"FamilyName":"Jnes","GivenName":"Joe2","DateOfBirth":"1981-01-01T00:00:00","Title":"Mrs","Address":"2 First St","Telephone":"86784567","Mobile":"041234568","Email":"z@b.c","TaxFileNumber":"123456780","CompanyName":"CN2","AustralianBusinessNumber":"ABN1234552","BSBNumber":"066142","AccountNumber":"007862","BankName":"Commonwealth2","BankBranch":"Perth2","AccountName":"Account Name2","SuperFundName":"Super f2","MemberNumber":"00011112","QantasFrequentFlyerNumber":"FF0022","VirginVelocityNumber":"VVN7772","EmiratesSkywardsNumber":"ESN7872","OthersNumber":"ON6602"}
        [HttpPut]
        public Object Put(EmployeeResource employeeResource)
        {
            LogRequest();

            if (employeeResource == null) { return "Employee is required"; }
            if (employeeResource.EmployeeId == null) { return "Employee.EmployeeId is required"; }

            int employeeId = employeeResource.EmployeeId.Value;
            var list = _db.Employees.Where(x => x.EmployeeId == employeeId).ToList();
            Employee employee = null;

            if (list.Any())
            {
                employee = list.First();
                employee.FamilyName = SafeTrim(employeeResource.FamilyName);
                employee.GivenName = SafeTrim(employeeResource.GivenName);
                employee.DateOfBirth = employeeResource.DateOfBirth;
                employee.Title = SafeTrim(employeeResource.Title);
                employee.Address = SafeTrim(employeeResource.Address);
                employee.Telephone = SafeTrim(employeeResource.Telephone);
                employee.Mobile = SafeTrim(employeeResource.Mobile);
                employee.Email = SafeTrim(employeeResource.Email);
                employee.TaxFileNumber = SafeTrim(employeeResource.TaxFileNumber);
                employee.CompanyName = SafeTrim(employeeResource.CompanyName);
                employee.AustralianBusinessNumber = SafeTrim(employeeResource.AustralianBusinessNumber);
                employee.BSBNumber = SafeTrim(employeeResource.BSBNumber);
                employee.AccountNumber = SafeTrim(employeeResource.AccountNumber);
                employee.BankName = SafeTrim(employeeResource.BankName);
                employee.BankBranch = SafeTrim(employeeResource.BankBranch);
                employee.AccountName = SafeTrim(employeeResource.AccountName);
                employee.SuperFundName = SafeTrim(employeeResource.SuperFundName);
                employee.MemberNumber = SafeTrim(employeeResource.MemberNumber);
                employee.QantasFrequentFlyerNumber = SafeTrim(employeeResource.QantasFrequentFlyerNumber);
                employee.VirginVelocityNumber = SafeTrim(employeeResource.VirginVelocityNumber);
                employee.EmiratesSkywardsNumber = SafeTrim(employeeResource.EmiratesSkywardsNumber);
                employee.OthersNumber = SafeTrim(employeeResource.OthersNumber);
                _db.SaveChanges();
            }

            return employee;
        }
    }
}
