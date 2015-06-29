
using System.Runtime.Serialization;
namespace Employees.Resource
{
    [DataContract]
    public class LogResource
    {
        [DataMember(Name = "Message")]
        public string Message;
    }
}
