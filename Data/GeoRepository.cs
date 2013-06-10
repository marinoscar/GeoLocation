using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using Common.Helpers;

namespace Data
{
    public class GeoRepository
    {

        private readonly Database _db;

        public GeoRepository()
        {
            _db = new Database(ConfigurationManager.ConnectionStrings["ApplicationStore"].ConnectionString, DatabaseProviderType.MySql);
        }

        private static string GetSql(Int64 ip)
        {
            return @"
                        SELECT
	                        Location.Region, Location.City, Country.CountryName As Country,
	                        Location.Latitude, Location.Longitude
                        FROM
	                        IpBlocks
	                        INNER JOIN Location ON Ipblocks.LocationId = Location.LocationId
	                        INNER JOIN Country ON Location.CountryCode = Country.CountryCode
                        WHERE
	                        IpBlocks.StartIpNumber < {0} And IpBlocks.EndIpNumber > {0};
                    ".FormatSql(ip);
        }


        public IpLocation GetLocation(string ipAddress)
        {
            return GetLocation(IPAddress.Parse(ipAddress));
        }

        public IpLocation GetLocation(IPAddress ipAddress)
        {
            var ip = BitConverter.ToInt64(ipAddress.GetAddressBytes(), 0);
            return GetLocation(ip);
        }
        
        public IpLocation GetLocation(Int64 ip)
        {
            var result = _db.ExecuteToEntityList<IpLocation>(GetSql(ip)).Single();
            result.Ip = new IPAddress(ip);
            return result;
        }
    }
}
