using System;
using System.IO;

namespace Employees
{
    class ApiProperties
    {
        const string FileName = "Properties.txt";

        public ApiProperties()
        {
        }

        public string ReadStringProperty(string name, string defaultValue)
        {
            if (File.Exists(FileName))
            {
                var property = ReadPropertyFromFile(name);
                if (property != null)
                {
                    return property;
                }
                else
                {
                    return defaultValue;
                }
            }
            else
            {
                string msg = "Properties file not found, " + FileName;
                Console.WriteLine(msg);
                return defaultValue;                
            }
        }

        public int ReadIntProperty(string name, int defaultValue)
        {
            if (!File.Exists(FileName))
            {
                var property = ReadPropertyFromFile(name);
                if (property != null)
                {
                    return Convert.ToInt32(property);
                }
                else
                {
                    return defaultValue;
                }
            }
            else
            {
                const string msg = "Properties file not found, " + FileName;
                Console.WriteLine(msg);
                return defaultValue;
            }
        }

        private string ReadPropertyFromFile(string name)
        {
            string property = null;

            try
            {
                using (var sr = new StreamReader(FileName))
                {
                    while (property == null)
                    {
                        string line = sr.ReadToEnd();
                        if (line.Length <= 0) continue;

                        int pos = line.IndexOf(":", StringComparison.OrdinalIgnoreCase);

                        if (pos <= 0) continue;

                        ++pos; // skip : character
                        property = line.Substring(pos, line.Length - pos);
                        property = StripEndOfLineChars(property);
                        Console.WriteLine("Property: " + name + " [" + property + "]");
                    }
                }
            }
            catch (Exception e)
            {
                // End of file was reached, property was not found, return null
                property = null;
            }

            return property;
        }

        private string StripEndOfLineChars(string str)
        {
            return str.Replace("\r", "").Replace("\n", "");
        }
    }

}
