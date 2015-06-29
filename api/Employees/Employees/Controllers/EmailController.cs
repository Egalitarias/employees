using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;

namespace Employees.Controllers
{
    public class EmailController : BaseController
    {

        EmailController()
        {
        }

        // http://localhost:8080/api/email
        public Object Get(int employeeId = -1)
        {
            LogRequest();

            string response = "";
            var administrators = _db.Administrators.ToList();

            if (employeeId == -1)
            {
                return "EmployeeId required";
            }
            else
            {
                var list = _db.Employees.Where(x => x.EmployeeId == employeeId).ToList();
                if (list.Any())
                {
                    Employee employee = list.First();
                    string details = "";
                    details = details + "Family Name: " + SafeTrim(employee.FamilyName) + "\n";
                    details = details + "Given Name: " + SafeTrim(employee.GivenName) + "\n";
                    details = details + "Date Of Birth: " + employee.DateOfBirth + "\n";
                    details = details + "Title: " + SafeTrim(employee.Title) + "\n";
                    details = details + "Address: " + SafeTrim(employee.Address) + "\n";
                    details = details + "Telephone: " + SafeTrim(employee.Telephone) + "\n";
                    details = details + "Mobile: " + SafeTrim(employee.Mobile) + "\n";
                    details = details + "Email: " + SafeTrim(employee.Email) + "\n";
                    details = details + "Tax File Number: " + SafeTrim(employee.TaxFileNumber) + "\n";
                    details = details + "Company: " + SafeTrim(employee.CompanyName) + "\n";
                    details = details + "ABN: " + SafeTrim(employee.AustralianBusinessNumber) + "\n";

                    foreach (Passport passport in employee.Passports)
                    {
                        details = details + "Passport Number: " + SafeTrim(passport.PassportNumber) + "\n";
                        details = details + "Nationality: " + SafeTrim(passport.Nationality) + "\n";
                        details = details + "Visa Type: " + SafeTrim(passport.VisaType) + "\n";
                        details = details + "Visa Number: " + SafeTrim(passport.VisaNumber) + "\n";
                        details = details + "Visa's Issue Date: " + passport.VisasIssueDate + "\n";
                        details = details + "Visa's Expiry Date: " + passport.VisasExpiryDate + "\n";
                        
                    }

                    foreach (Contact contact in employee.Contacts)
                    {
                        details = details + "Contact Name: " + SafeTrim(contact.Name) + "\n";
                        details = details + "Address: " + SafeTrim(contact.Address) + "\n";
                        details = details + "Phone No: " + SafeTrim(contact.PhoneNo) + "\n";
                        details = details + "Mobile No: " + SafeTrim(contact.MobileNo) + "\n";
                    }

                    details = details + "BSB Number: " + SafeTrim(employee.BSBNumber) + "\n";
                    details = details + "Account Number: " + SafeTrim(employee.AccountNumber) + "\n";
                    details = details + "Bank Name: " + SafeTrim(employee.BankName) + "\n";
                    details = details + "Bank Branch: " + SafeTrim(employee.BankBranch) + "\n";
                    details = details + "Account Name: " + SafeTrim(employee.AccountName) + "\n";

                    details = details + "Super Fund Name: " + SafeTrim(employee.SuperFundName) + "\n";
                    details = details + "Member Number: " + SafeTrim(employee.MemberNumber) + "\n";

                    details = details + "Quantas FF No: " + SafeTrim(employee.QantasFrequentFlyerNumber) + "\n";
                    details = details + "Virgin V No: " + SafeTrim(employee.VirginVelocityNumber) + "\n";
                    details = details + "Emirates S No: " + SafeTrim(employee.EmiratesSkywardsNumber) + "\n";
                    details = details + "Other No: " + SafeTrim(employee.OthersNumber) + "\n";

                    foreach (Contact contact in employee.Contacts)
                    {
                        details = details + "Contact Name: " + SafeTrim(contact.Name) + "\n";
                        details = details + "Address: " + SafeTrim(contact.Address) + "\n";
                        details = details + "Phone No: " + SafeTrim(contact.PhoneNo) + "\n";
                        details = details + "Mobile No: " + SafeTrim(contact.MobileNo) + "\n";
                    }

                    foreach (Administrator administrator in administrators)
                    {
                        response += SendEmailToAdministrator(employeeId, administrator, details);
                    }
                }
            }
            return response;

        }

        protected string SendEmailToAdministrator(int employeeId, Administrator administrator, string employee)
        {
            string response;

            try
            {
                var fromAddress = GetAttribute("SMTPEmail");
                var toAddress = administrator.Email;
                string fromPassword = GetAttribute("SMTPPassword");
                string subject = GetAttribute("SMTPSubject");
                //string body = "Hello" + port + "\n";
                string body = employee;

                int port;
                int.TryParse(GetAttribute("SMTPPort"), out port);

                Console.WriteLine("fromAddress [" + fromAddress + "]");
                Console.WriteLine("toAddress [" + toAddress + "]");
                Console.WriteLine("fromPassword [" + fromPassword + "]");
                Console.WriteLine("subject [" + subject + "]");
                Console.WriteLine("body [" + body + "]");
                Console.WriteLine("emailAddress.SmtpHost [" + GetAttribute("SMTPHost") + "]");
                Console.WriteLine("emailAddress.SmtpPort [" + port + "]");


                Console.WriteLine(toAddress + " " + subject + " " + port);

                var smtp = new SmtpClient();
                {
                    smtp.Host = GetAttribute("SMTPHost");

                    smtp.Port = port;
                    smtp.EnableSsl = true;
                    smtp.Credentials = new NetworkCredential(fromAddress, fromPassword);
                }

                var photos = _db.Photos.Where(x => x.EmployeeId == employeeId).ToList();
                var message = new MailMessage(fromAddress, toAddress);

                foreach (var photo in photos)
                {
                    var stream = new MemoryStream(photo.Image);
                    var attachment = new Attachment(stream, photo.FileName.Trim());
                    message.Attachments.Add(attachment);                    
                }

                message.Subject = subject;
                message.Body = body;
                smtp.Send(message);
                Console.WriteLine("Email Success " + toAddress + " " + port);
                response = administrator.AdministratorId + " Success";
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                response = administrator.AdministratorId + " Failure";
            }

            return response;
        }

    }
}
