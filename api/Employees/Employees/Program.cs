using System;
using System.Web.Http;
using System.Web.Http.SelfHost;

// http://www.asp.net/web-api/overview/hosting-aspnet-web-api/self-host-a-web-api

namespace Employees
{
    class Program
    {
        static void Main(string[] args)
        {
            const string defaultPort = "8080";

            var properties = new ApiProperties();
            string port = properties.ReadStringProperty("Port", defaultPort);

            var config = new HttpSelfHostConfiguration("http://localhost:" + port);

            config.Routes.MapHttpRoute(
                "API Default", "api/{controller}/{id}",
                new { id = RouteParameter.Optional });

            config.MaxReceivedMessageSize = 1024 * 1024;

            using (HttpSelfHostServer server = new HttpSelfHostServer(config))
            {
                server.OpenAsync().Wait();
                Console.WriteLine("http://54.206.53.203:" + port + "/api");
                Console.WriteLine("Press Enter to quit.");
                Console.ReadLine();
            }
        }
    }
}
