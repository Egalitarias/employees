using System;
using System.Runtime.Serialization;

namespace Employees.Resource
{
    [DataContract]
    public class PassportResource
    {
        [DataMember(Name = "PassportId")]
        public int? PassportId;

        [DataMember(Name = "PassportNumber")]
        public string PassportNumber;

        [DataMember(Name = "Nationality")]
        public string Nationality;

        [DataMember(Name = "VisaType")]
        public string VisaType;

        [DataMember(Name = "VisaNumber")]
        public string VisaNumber;

        [DataMember(Name = "VisasIssueDate")]
        public DateTime VisasIssueDate;

        [DataMember(Name = "VisasExpiryDate")]
        public DateTime VisasExpiryDate;

        [DataMember(Name = "EmployeeId")]
        public int EmployeeId;

    }
}
