using System;
using System.Linq;
using System.Web.Http;
using Employees.Resource;

namespace Employees.Controllers
{
    public class BankingController : BaseController
    {

        BankingController()
        {
        }

        // Content-Type: application/json
        // {"EmployeeId":20,"FamilyName":"Jnes","GivenName":"Joe2","DateOfBirth":"1981-01-01T00:00:00","Title":"Mrs","Address":"2 First St","Telephone":"86784567","Mobile":"041234568","Email":"z@b.c","TaxFileNumber":"123456780","CompanyName":"CN2","AustralianBusinessNumber":"ABN1234552","BSBNumber":"066142","AccountNumber":"007862","BankName":"Commonwealth2","BankBranch":"Perth2","AccountName":"Account Name2","SuperFundName":"Super f2","MemberNumber":"00011112","QantasFrequentFlyerNumber":"FF0022","VirginVelocityNumber":"VVN7772","EmiratesSkywardsNumber":"ESN7872","OthersNumber":"ON6602"}
        [HttpPut]
        public Object Put(BankingResource bankingResource)
        {
            LogRequest();

            if (bankingResource == null) { return "Employee is required"; }
            if (bankingResource.EmployeeId <= 0) { return "Employee.EmployeeId is required"; }

            int employeeId = bankingResource.EmployeeId;
            var list = _db.Employees.Where(x => x.EmployeeId == employeeId).ToList();
            Employee employee = null;

            if (list.Any())
            {
                employee = list.First();
                Console.WriteLine("Found employeeId: " + employee.EmployeeId);

                employee.BSBNumber = SafeTrim(bankingResource.BSBNumber);
                Console.WriteLine("BSBNumber: " + employee.BSBNumber);

                employee.AccountNumber = SafeTrim(bankingResource.AccountNumber);
                Console.WriteLine("AccountNumber: " + employee.AccountNumber);

                employee.BankName = SafeTrim(bankingResource.BankName);
                Console.WriteLine("BankName: " + employee.BankName);

                employee.BankBranch = SafeTrim(bankingResource.BankBranch);
                Console.WriteLine("BankBranch: " + employee.BankBranch);

                employee.AccountName = SafeTrim(bankingResource.AccountName);
                Console.WriteLine("AccountName: " + employee.AccountName);

                employee.SuperFundName = SafeTrim(bankingResource.SuperFundName);
                Console.WriteLine("SuperFundName: " + employee.SuperFundName);

                employee.MemberNumber = SafeTrim(bankingResource.MemberNumber);
                Console.WriteLine("MemberNumber: " + employee.MemberNumber);

                employee.QantasFrequentFlyerNumber = SafeTrim(bankingResource.QantasFrequentFlyerNumber);
                Console.WriteLine("QantasFrequentFlyerNumber: " + employee.QantasFrequentFlyerNumber);

                employee.VirginVelocityNumber = SafeTrim(bankingResource.VirginVelocityNumber);
                Console.WriteLine("VirginVelocityNumber: " + employee.VirginVelocityNumber);

                employee.EmiratesSkywardsNumber = SafeTrim(bankingResource.EmiratesSkywardsNumber);
                Console.WriteLine("EmiratesSkywardsNumber: " + employee.EmiratesSkywardsNumber);

                employee.OthersNumber = SafeTrim(bankingResource.OthersNumber);
                Console.WriteLine("OthersNumber: " + employee.OthersNumber);

                _db.SaveChanges();
                Console.WriteLine("Banking details added");
            }

            return new Employee
                {
                    EmployeeId = employee.EmployeeId,
                    FamilyName = employee.FamilyName,
                    GivenName = employee.GivenName,
                    DateOfBirth = employee.DateOfBirth,
                    Title = employee.Title,
                    Address = employee.Address,
                    Telephone = employee.Telephone,
                    Mobile = employee.Mobile,
                    Email = employee.Email,
                    TaxFileNumber = employee.TaxFileNumber,
                    AustralianBusinessNumber = employee.AustralianBusinessNumber,
                    BSBNumber = employee.BSBNumber,
                    AccountNumber = employee.AccountNumber,
                    BankName = employee.BankName,
                    BankBranch = employee.BankBranch,
                    AccountName = employee.AccountName,
                    SuperFundName = employee.SuperFundName,
                    MemberNumber = employee.MemberNumber,
                    CompanyName = employee.CompanyName,
                    QantasFrequentFlyerNumber = employee.QantasFrequentFlyerNumber,
                    VirginVelocityNumber = employee.VirginVelocityNumber,
                    EmiratesSkywardsNumber = employee.EmiratesSkywardsNumber,
                    OthersNumber = employee.OthersNumber
                };
        }

    }
}
