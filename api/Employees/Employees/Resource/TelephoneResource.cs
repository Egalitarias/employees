using System.Runtime.Serialization;

namespace Employees.Resource
{
    [DataContract]
    public class TelephoneResource
    {
        [DataMember(Name = "TelephoneId")]
        public int? TelephoneId;

        [DataMember(Name = "Number")]
        public string Number;

        [DataMember(Name = "EmployeeId")]
        public int EmployeeId;
    }
}
