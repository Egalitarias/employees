using System;
using System.Runtime.Serialization;

namespace Employees.Resource
{
    [DataContract]
    public class EmployeeResource
    {
        [DataMember(Name = "EmployeeId")]
        public int? EmployeeId;

        [DataMember(Name = "FamilyName")]
        public string FamilyName;

        [DataMember(Name = "GivenName")]
        public string GivenName;

        [DataMember(Name = "DateOfBirth")]
        public DateTime? DateOfBirth;

        [DataMember(Name = "Title")]
        public string Title;

        [DataMember(Name = "Address")]
        public string Address;

        [DataMember(Name = "Telephone")]
        public string Telephone;

        [DataMember(Name = "Mobile")]
        public string Mobile;

        [DataMember(Name = "Email")]
        public string Email;

        [DataMember(Name = "TaxFileNumber")]
        public string TaxFileNumber;

        [DataMember(Name = "CompanyName")]
        public string CompanyName;

        [DataMember(Name = "AustralianBusinessNumber")]
        public string AustralianBusinessNumber;

        [DataMember(Name = "BSBNumber")]
        public string BSBNumber;

        [DataMember(Name = "AccountNumber")]
        public string AccountNumber;

        [DataMember(Name = "BankName")]
        public string BankName;

        [DataMember(Name = "BankBranch")]
        public string BankBranch;

        [DataMember(Name = "AccountName")]
        public string AccountName;

        [DataMember(Name = "SuperFundName")]
        public string SuperFundName;

        [DataMember(Name = "MemberNumber")]
        public string MemberNumber;

        [DataMember(Name = "QantasFrequentFlyerNumber")]
        public string QantasFrequentFlyerNumber;

        [DataMember(Name = "VirginVelocityNumber")]
        public string VirginVelocityNumber;

        [DataMember(Name = "EmiratesSkywardsNumber")]
        public string EmiratesSkywardsNumber;

        [DataMember(Name = "OthersNumber")]
        public string OthersNumber;
    }
}
