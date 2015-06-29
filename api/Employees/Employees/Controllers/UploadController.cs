

using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace Employees.Controllers
{
    public class UploadController : BaseController
    {

        UploadController()
        {
            
        }

        public Object Get()
        {
            return "upload";
        }

        [HttpPost]
        public async Task<IHttpActionResult> Upload()
        {
            Console.WriteLine("Upload");

            var response = "";
            //LogRequest();

            if (!Request.Content.IsMimeMultipartContent())
            {
                Console.WriteLine("No multipart");
                throw new Exception(); // divided by zero
            }

            var provider = new MultipartMemoryStreamProvider();
            await Request.Content.ReadAsMultipartAsync(provider);
            foreach (var file in provider.Contents)
            {
                if ((file != null) && (file.Headers != null) && (file.Headers.ContentDisposition != null) && (file.Headers.ContentDisposition.FileName != null))
                {
                    var filename = file.Headers.ContentDisposition.FileName.Trim('\"');
                    Console.WriteLine("filename: [" + filename + "]");
                    var buffer = await file.ReadAsByteArrayAsync();
                    Console.WriteLine("Length: [" + buffer.Length + "]");

                    response = response + "File size: " + buffer.Length;
                    //Do whatever you want with filename and its binaray data.

                    ByteArrayToFile(filename, buffer);

                    var parts = filename.Split('.');
                    if (parts.Length >= 2)
                    {
                        var subParts = parts[parts.Length - 2].Split('_');
                        if (subParts.Length >= 2)
                        {
                            var employeeIdStr = subParts[subParts.Length - 1];
                            if (employeeIdStr.Length > 0)
                            {
                                int photoEmployeeId;
                                int.TryParse(employeeIdStr, out photoEmployeeId);
                                if (photoEmployeeId > 0)
                                {
                                    Console.WriteLine("Photo EmployeeId: [" + photoEmployeeId + "]");

                                    var photo = new Photo()
                                    {
                                        FileName = filename,
                                        Image = buffer,
                                        EmployeeId = photoEmployeeId
                                    };
                                    _db.Photos.Add(photo);
                                    _db.SaveChanges();
                                    Console.WriteLine("Photo saved to DB");
                                }
                            }
                        }
                    }
                }
            }

            return Ok(response);
        }

        public bool ByteArrayToFile(string _FileName, byte[] _ByteArray)
        {
            try
            {
                // Open file for reading
                System.IO.FileStream _FileStream =
                   new System.IO.FileStream(_FileName, System.IO.FileMode.Create,
                                            System.IO.FileAccess.Write);
                // Writes a block of bytes to this stream using data from
                // a byte array.
                _FileStream.Write(_ByteArray, 0, _ByteArray.Length);

                // close file stream
                _FileStream.Close();

                return true;
            }
            catch (Exception _Exception)
            {
                // Error
                Console.WriteLine("Exception caught in process: {0}",
                                  _Exception.ToString());
            }

            // error occured, return false
            return false;
        }
    }
}
