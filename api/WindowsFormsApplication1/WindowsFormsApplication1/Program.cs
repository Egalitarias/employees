using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.SelfHost;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    /*
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }
    }
     * */
    /*
    static class Program
    {
 var config = new HttpSelfHostConfiguration("http://localhost:8080");

config.Routes.MapHttpRoute(
    "API Default", "api/{controller}/{id}", 
    new { id = RouteParameter.Optional });

using (HttpSelfHostServer server = new HttpSelfHostServer(config))
{
    server.OpenAsync().Wait();
    Console.WriteLine("Press Enter to quit.");
    Console.ReadLine();
}       
    }
     * */

    internal class Program
    {
        private static void Main(string[] args)
        {
            var config = new HttpSelfHostConfiguration("http://localhost:8080");

            config.Routes.MapHttpRoute(
                "API Default", "api/{controller}/{id}",
                new {id = RouteParameter.Optional});

            using (HttpSelfHostServer server = new HttpSelfHostServer(config))
            {
                server.OpenAsync().Wait();
                Console.WriteLine("Press Enter to quit.");
                Console.ReadLine();
                while (1 == 1) ;
            }
        }
    }
}
