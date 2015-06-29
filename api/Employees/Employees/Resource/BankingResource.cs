using System.Runtime.Serialization;

namespace Employees.Resource
{
    [DataContract]
    public class BankingResource
    {
        [DataMember(Name = "EmployeeId")]
        public int EmployeeId;

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
