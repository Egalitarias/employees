using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Employees.Resource;

namespace Employees.Controllers
{
    public class ContactController : BaseController
    {

        ContactController()
        {
        }

        // http://localhost:8080/api/version
        // http://localhost:8080/api/version?VersionId=2
        public List<Contact> Get(int contactId = -1)
        {

            if (contactId == -1)
            {
                var list = _db.Contacts.ToList();
                return list;
            }
            else
            {
                var list = _db.Contacts.Where(x => x.ContactId == contactId).ToList();
                return list;
            }
        }

        // Content-Type: application/json
        // {"Name" : "Joe", "Address" : "1 First St", "PhoneNo" : "012345678", "MobileNo" : "041234567", "EmployeeId", 5}
        [HttpPost]
        public Object Post(ContactResource contactResource)
        {
            LogRequest();

            if (contactResource == null) { return "Contact is required"; }
            if (contactResource.Name == null) { return "Contact.Name is required"; }
            if (contactResource.Address == null) { return "Contact.Address is required"; }
            if (contactResource.PhoneNo == null) { return "Contact.PhoneNo is required"; }
            if (contactResource.MobileNo == null) { return "Contact.MobileNo is required"; }
            if (contactResource.EmployeeId <= 0) { return "Contact.EmployeeId is required"; }

            var contact = new Contact
            {
                Name = SafeTrim(contactResource.Name),
                Address = SafeTrim(contactResource.Address),
                PhoneNo = SafeTrim(contactResource.PhoneNo),
                MobileNo = SafeTrim(contactResource.MobileNo),
                EmployeeId = contactResource.EmployeeId
            };
            _db.Contacts.Add(contact);
            _db.SaveChanges();

            return contact;
        }

        public Object Delete(int contactId)
        {
            LogRequest();

            var list = _db.Contacts.Where(x => x.ContactId == contactId);
            if (list.Any())
            {
                Contact deleted = list.First();
                _db.Contacts.Remove(deleted);
                _db.SaveChanges();
                return deleted;
            }

            return null;
        }

        // Content-Type: application/json
        // {"ContactId" : 24, "Name" : "Joe", "Address" : "1 First St", "PhoneNo" : "012345678", "MobileNo" : "041234567", "EmployeeId", 5}
        [HttpPut]
        public Object Put(ContactResource contactResource)
        {
            LogRequest();

            if (contactResource == null) { return "Contact is required"; }
            if (contactResource.ContactId == null) { return "Contact.ContactId is required"; }

            int contactId = contactResource.ContactId.Value;
            var list = _db.Contacts.Where(x => x.ContactId == contactId).ToList();
            Contact contact = null;

            if (list.Any())
            {
                contact = list.First();
                contact.Name = SafeTrim(contactResource.Name);
                contact.Address = SafeTrim(contactResource.Address);
                contact.PhoneNo = SafeTrim(contactResource.PhoneNo);
                contact.EmployeeId = contactResource.EmployeeId;
                _db.SaveChanges();
            }

            return contact;
        }
    }
}
