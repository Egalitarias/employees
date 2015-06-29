using System.Runtime.Serialization;

namespace Employees.Resource
{

    [DataContract]
    public class ContactResource
    {
        [DataMember(Name = "ContactId")]
        public int? ContactId;

        [DataMember(Name = "Name")]
        public string Name;

        [DataMember(Name = "Address")]
        public string Address;

        [DataMember(Name = "PhoneNo")]
        public string PhoneNo;

        [DataMember(Name = "MobileNo")]
        public string MobileNo;

        [DataMember(Name = "EmployeeId")]
        public int EmployeeId;
    }
}
