using System.Runtime.Serialization;

namespace Employees.Resource
{
    [DataContract]
    public class VersionResource
    {
        [DataMember(Name = "VersionId")]
        public int? VersonId;

        [DataMember(Name = "Name")]
        public string Name;

        [DataMember(Name = "Value")]
        public string Value;
    }
}
