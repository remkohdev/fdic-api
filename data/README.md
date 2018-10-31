
Use an Index:
curl -X POST -H "Content-Type: application/json" http://localhost:5984/fdic_institutions2
with a selector
http://docs.couchdb.org/en/2.2.0/api/database/find.html#selector-syntax

{
   "selector": {
      "ASSET": {
         "$gt": "200,000,000"
      }
   }
}


Use a View:
curl -X GET -H "Content-Type: application/json" http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2/_design/asset/_view/asset-view?startkey=%22200%2C000%2C000%22
http://docs.couchdb.org/en/2.2.0/api/ddoc/views.html

curl -X GET -H "Content-Type: application/json" http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2/_design/name/_view/name-view?key=%22SunTrust%20Bank%22

curl -X GET -H "Content-Type: application/json" http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2/_design/asset/_view/asset-view?startkey=200000000

curl -X PUT http://localhost:5984/fdic_institutions2

curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "name-view": {
      "map": "function(doc){ if(doc.NAME){ emit(doc.NAME, doc); }}"
    }
  },
  "language": "javascript"
}' http://localhost:5984/fdic_institutions2/_design/name

curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "asset-view": {
      "map": "function(doc){ if(doc.ASSET){ emit(parseInt(doc.ASSET).replace(/,/g, ''), doc); }}"
    }
  },
  "language": "javascript"
}' http://localhost:5984/fdic_institutions2/_design/asset

curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "name-asset-view": {
      "map": "function(doc){ if(doc.NAME && doc.ASSET){ emit(doc.NAME, doc.ASSET); }}"
    }
  },
  "language": "javascript"
}' http://localhost:5984/fdic_institutions2/_design/name-asset

curl -X PUT -H "Content-Type: application/json" -d '{"views": {"fed-rssd-view": {"map": "function(doc){ if(doc.FED_RSSD){ emit(doc.FED_RSSD); }}"}},"language": "javascript"}' http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2/_design/fed-rssd

curl -X POST -H "Content-Type: application/json" "http://localhost:5984/fdic_institutions2/_bulk_docs" -d '{
    "docs":
[
  {
    "STNAME": "Ohio",
    "ACTIVE": 1,
    "ADDRESS": "1111 Polaris Parkway",
    "ASSET": "2,167,700,000",
    "CITY": "Columbus",
    "COUNTY": "Delaware",
    "NAME": "JPMorgan Chase Bank, National Association",
    "ZIP": 43240,
    "WEBADDR": "www.jpmorganchase.com",
    "OFFICES": 5169,
    "CITYHCR": "New York"
  },
  {
    "STNAME": "North Carolina",
    "ACTIVE": 1,
    "ADDRESS": "100 North Tryon St",
    "ASSET": "1,759,530,000",
    "CITY": "Charlotte",
    "COUNTY": "Mecklenburg",
    "NAME": "Bank of America, National Association",
    "ZIP": 28202,
    "WEBADDR": "www.bankofamerica.com",
    "OFFICES": 4446,
    "CITYHCR": "Charlotte"
  },
  {
    "STNAME": "South Dakota",
    "ACTIVE": 1,
    "ADDRESS": "101 N. Phillips Avenue",
    "ASSET": "1,675,077,000",
    "CITY": "Sioux Falls",
    "COUNTY": "Minnehaha",
    "NAME": "Wells Fargo Bank, National Association",
    "ZIP": 57104,
    "WEBADDR": "http://www.wellsfargo.com",
    "OFFICES": 5816,
    "CITYHCR": "San Francisco"
  },
  {
    "STNAME": "South Dakota",
    "ACTIVE": 1,
    "ADDRESS": "701 East 60th Street North",
    "ASSET": "1,397,794,000",
    "CITY": "Sioux Falls",
    "COUNTY": "Minnehaha",
    "NAME": "Citibank, National Association",
    "ZIP": 57104,
    "WEBADDR": "www.citibank.com",
    "OFFICES": 716,
    "CITYHCR": "New York"
  },
  {
    "STNAME": "Ohio",
    "ACTIVE": 1,
    "ADDRESS": "425 Walnut Street",
    "ASSET": "453,023,045",
    "CITY": "Cincinnati",
    "COUNTY": "Hamilton",
    "NAME": "U.S. Bank National Association",
    "ZIP": 45202,
    "WEBADDR": "www.usbank.com",
    "OFFICES": 3124,
    "CITYHCR": "Minneapolis"
  },
  {
    "STNAME": "Delaware",
    "ACTIVE": 1,
    "ADDRESS": "222 Delaware Avenue",
    "ASSET": "368,950,936",
    "CITY": "Wilmington",
    "COUNTY": "New Castle",
    "NAME": "PNC Bank, National Association",
    "ZIP": 19899,
    "WEBADDR": "www.pnc.com",
    "OFFICES": 2495,
    "CITYHCR": "Pittsburgh"
  },
  {
    "STNAME": "Delaware",
    "ACTIVE": 1,
    "ADDRESS": "2035 Limestone Road",
    "ASSET": "291,742,134",
    "CITY": "Wilmington",
    "COUNTY": "New Castle",
    "NAME": "TD Bank, National Association",
    "ZIP": 19808,
    "WEBADDR": "www.tdbank.com",
    "OFFICES": 1262,
    "CITYHCR": "Toronto"
  },
  {
    "STNAME": "Virginia",
    "ACTIVE": 1,
    "ADDRESS": "1680 Capital One Drive",
    "ASSET": "289,992,852",
    "CITY": "Mclean",
    "COUNTY": "Fairfax",
    "NAME": "Capital One, National Association",
    "ZIP": 22102,
    "WEBADDR": "www.capitalone.com",
    "OFFICES": 549,
    "CITYHCR": "Mclean"
  },
  {
    "STNAME": "New York",
    "ACTIVE": 1,
    "ADDRESS": "240 Greenwich Street",
    "ASSET": "276,822,000",
    "CITY": "New York",
    "COUNTY": "New York",
    "NAME": "The Bank of New York Mellon",
    "ZIP": 10007,
    "WEBADDR": "www.bnymellon.com",
    "OFFICES": 9,
    "CITYHCR": "New York"
  },
  {
    "STNAME": "Massachusetts",
    "ACTIVE": 1,
    "ADDRESS": "1 Lincoln St. Fl 1",
    "ASSET": "245,244,124",
    "CITY": "Boston",
    "COUNTY": "Suffolk",
    "NAME": "State Street Bank and Trust Company",
    "ZIP": 2111,
    "WEBADDR": "http://www.statestreet.com",
    "OFFICES": 1,
    "CITYHCR": "Boston"
  },
  {
    "STNAME": "North Carolina",
    "ACTIVE": 1,
    "ADDRESS": "200 W 2nd St",
    "ASSET": "216,499,000",
    "CITY": "Winston Salem",
    "COUNTY": "Forsyth",
    "NAME": "Branch Banking and Trust Company",
    "ZIP": 27101,
    "WEBADDR": "www.BBT.com",
    "OFFICES": 1977,
    "CITYHCR": "Winston-Salem"
  },
  {
    "STNAME": "Nevada",
    "ACTIVE": 1,
    "ADDRESS": "2360 Corporate Circle Suite 400",
    "ASSET": "207,848,000",
    "CITY": "Henderson",
    "COUNTY": "Clark",
    "NAME": "Charles Schwab Bank",
    "ZIP": 89074,
    "WEBADDR": "www.schwabbank.com",
    "OFFICES": 1,
    "CITYHCR": ""
  },
  {
    "STNAME": "Georgia",
    "ACTIVE": 1,
    "ADDRESS": "303 Peachtreet Street, Northeast",
    "ASSET": "202,064,278",
    "CITY": "Atlanta",
    "COUNTY": "Fulton",
    "NAME": "SunTrust Bank",
    "ZIP": 30308,
    "WEBADDR": "http://WWW.SUNTRUST.COM",
    "OFFICES": 1252,
    "CITYHCR": "Atlanta"
  },
  {
    "STNAME": "Virginia",
    "ACTIVE": 1,
    "ADDRESS": "1800 Tysons Blvd",
    "ASSET": "178,623,995",
    "CITY": "Tysons",
    "COUNTY": "Fairfax",
    "NAME": "HSBC Bank USA, National Association",
    "ZIP": 22102,
    "WEBADDR": "www.banking.us.hsbc.com",
    "OFFICES": 230,
    "CITYHCR": "London"
  },
  {
    "STNAME": "New York",
    "ACTIVE": 1,
    "ADDRESS": "200 West Street",
    "ASSET": "177,468,000",
    "CITY": "New York",
    "COUNTY": "New York",
    "NAME": "Goldman Sachs Bank USA",
    "ZIP": 10282,
    "WEBADDR": "www.marcus.com",
    "OFFICES": 5,
    "CITYHCR": "New York"
  },
  {
    "STNAME": "Utah",
    "ACTIVE": 1,
    "ADDRESS": "200 West Civic Centre Drive",
    "ASSET": "146,896,000",
    "CITY": "Sandy",
    "COUNTY": "Salt Lake",
    "NAME": "Ally Bank",
    "ZIP": 84070,
    "WEBADDR": "http://www.ally.com",
    "OFFICES": 1,
    "CITYHCR": "Detroit"
  },
  {
    "STNAME": "Ohio",
    "ACTIVE": 1,
    "ADDRESS": "38 Fountain Square Plaza",
    "ASSET": "138,847,391",
    "CITY": "Cincinnati",
    "COUNTY": "Hamilton",
    "NAME": "Fifth Third Bank",
    "ZIP": 45263,
    "WEBADDR": "https://www.53.com",
    "OFFICES": 1176,
    "CITYHCR": "Cincinnati"
  },
  {
    "STNAME": "Utah",
    "ACTIVE": 1,
    "ADDRESS": "201 S Main St, 5th Floor",
    "ASSET": "138,844,000",
    "CITY": "Salt Lake City",
    "COUNTY": "Salt Lake",
    "NAME": "Morgan Stanley Bank, National Association",
    "ZIP": 84111,
    "WEBADDR": "",
    "OFFICES": 1,
    "CITYHCR": "New York"
  },
  {
    "STNAME": "Ohio",
    "ACTIVE": 1,
    "ADDRESS": "127 Public Square",
    "ASSET": "135,862,871",
    "CITY": "Cleveland",
    "COUNTY": "Cuyahoga",
    "NAME": "KeyBank National Association",
    "ZIP": 44114,
    "WEBADDR": "www.key.com",
    "OFFICES": 1199,
    "CITYHCR": "Cleveland"
  },
  {
    "STNAME": "Illinois",
    "ACTIVE": 1,
    "ADDRESS": "50 South Lasalle Street",
    "ASSET": "134,656,952",
    "CITY": "Chicago",
    "COUNTY": "Cook",
    "NAME": "The Northern Trust Company",
    "ZIP": 60603,
    "WEBADDR": "www.northerntrust.com",
    "OFFICES": 65,
    "CITYHCR": "Chicago"
  },
  {
    "STNAME": "Delaware",
    "ACTIVE": 1,
    "ADDRESS": "201 North Walnut Street",
    "ASSET": "129,380,501",
    "CITY": "Wilmington",
    "COUNTY": "New Castle",
    "NAME": "Chase Bank USA, National Association",
    "ZIP": 19801,
    "WEBADDR": "https://www.chase.com",
    "OFFICES": 3,
    "CITYHCR": "New York"
  },
  {
    "STNAME": "Rhode Island",
    "ACTIVE": 1,
    "ADDRESS": "One Citizens Plaza",
    "ASSET": "123,921,051",
    "CITY": "Providence",
    "COUNTY": "Providence",
    "NAME": "Citizens Bank, National Association",
    "ZIP": 2903,
    "WEBADDR": "www.citizensbank.com",
    "OFFICES": 804,
    "CITYHCR": "Providence"
  },
  {
    "STNAME": "California",
    "ACTIVE": 1,
    "ADDRESS": "400 California Street",
    "ASSET": "123,787,395",
    "CITY": "San Francisco",
    "COUNTY": "San Francisco",
    "NAME": "MUFG Union Bank, National Association",
    "ZIP": 94104,
    "WEBADDR": "WWW.UNIONBANK.COM",
    "OFFICES": 356,
    "CITYHCR": "Tokyo"
  },
  {
    "STNAME": "Alabama",
    "ACTIVE": 1,
    "ADDRESS": "1900 Fifth Avenue North",
    "ASSET": "123,635,085",
    "CITY": "Birmingham",
    "COUNTY": "Jefferson",
    "NAME": "Regions Bank",
    "ZIP": 35203,
    "WEBADDR": "http://www.regions.com",
    "OFFICES": 1469,
    "CITYHCR": "Birmingham"
  },
  {
    "STNAME": "New York",
    "ACTIVE": 1,
    "ADDRESS": "One M And T Plaza",
    "ASSET": "117,913,671",
    "CITY": "Buffalo",
    "COUNTY": "Erie",
    "NAME": "Manufacturers and Traders Trust Company",
    "ZIP": 14203,
    "WEBADDR": "http://www.mtb.com",
    "OFFICES": 834,
    "CITYHCR": "Buffalo"
  },
  {
    "STNAME": "Virginia",
    "ACTIVE": 1,
    "ADDRESS": "4851 Cox Road",
    "ASSET": "117,379,879",
    "CITY": "Glen Allen",
    "COUNTY": "Henrico",
    "NAME": "Capital One Bank (USA), National Association",
    "ZIP": 23060,
    "WEBADDR": "www.capitalone.com",
    "OFFICES": 1,
    "CITYHCR": "Mclean"
  },
  {
    "STNAME": "Utah",
    "ACTIVE": 1,
    "ADDRESS": "4315 South 2700 West, Mail Code: 02-01-47",
    "ASSET": "114,176,192",
    "CITY": "Salt Lake City",
    "COUNTY": "Salt Lake",
    "NAME": "American Express National  Bank",
    "ZIP": 84184,
    "WEBADDR": "http://www.americanexpress.com",
    "OFFICES": 1,
    "CITYHCR": "New York"
  },
  {
    "STNAME": "Illinois",
    "ACTIVE": 1,
    "ADDRESS": "111 West Monroe Street",
    "ASSET": "113,232,773",
    "CITY": "Chicago",
    "COUNTY": "Cook",
    "NAME": "BMO Harris Bank National Association",
    "ZIP": 60603,
    "WEBADDR": "http://www.bmoharris.com",
    "OFFICES": 599,
    "CITYHCR": "Montreal"
  },
  {
    "STNAME": "Ohio",
    "ACTIVE": 1,
    "ADDRESS": "17 South High Street",
    "ASSET": "105,292,183",
    "CITY": "Columbus",
    "COUNTY": "Franklin",
    "NAME": "The Huntington National Bank",
    "ZIP": 43216,
    "WEBADDR": "www.Huntington.com",
    "OFFICES": 1175,
    "CITYHCR": "Columbus"
  },
  {
    "STNAME": "Delaware",
    "ACTIVE": 1,
    "ADDRESS": "502 E. Market Street",
    "ASSET": "101,260,510",
    "CITY": "Greenwood",
    "COUNTY": "Sussex",
    "NAME": "Discover Bank",
    "ZIP": 19950,
    "WEBADDR": "www.discover.com",
    "OFFICES": 2,
    "CITYHCR": "Riverwoods"
  },
  {
    "STNAME": "California",
    "ACTIVE": 1,
    "ADDRESS": "111 Pine Street",
    "ASSET": "93,851,460",
    "CITY": "San Francisco",
    "COUNTY": "San Francisco",
    "NAME": "First Republic Bank",
    "ZIP": 94111,
    "WEBADDR": "www.firstrepublic.com",
    "OFFICES": 77,
    "CITYHCR": ""
  },
  {
    "STNAME": "California",
    "ACTIVE": 1,
    "ADDRESS": "180 Montgomery Street",
    "ASSET": "89,557,184",
    "CITY": "San Francisco",
    "COUNTY": "San Francisco",
    "NAME": "Bank of the West",
    "ZIP": 94104,
    "WEBADDR": "www.bankofthewest.com",
    "OFFICES": 557,
    "CITYHCR": "Paris"
  },
  {
    "STNAME": "Alabama",
    "ACTIVE": 1,
    "ADDRESS": "15 20th Street South",
    "ASSET": "87,739,409",
    "CITY": "Birmingham",
    "COUNTY": "Jefferson",
    "NAME": "Compass Bank",
    "ZIP": 35233,
    "WEBADDR": "www.bbvacompass.com",
    "OFFICES": 646,
    "CITYHCR": "Bilbao"
  },
  {
    "STNAME": "Utah",
    "ACTIVE": 1,
    "ADDRESS": "170 West Election Road, Suite 125",
    "ASSET": "84,487,088",
    "CITY": "Draper",
    "COUNTY": "Salt Lake",
    "NAME": "Synchrony Bank",
    "ZIP": 84020,
    "WEBADDR": "www.synchrony.com",
    "OFFICES": 4,
    "CITYHCR": ""
  }
]
}'


JOIN
function(doc) {
    if (doc.NAME) {
        emit([doc.NAME, 0], null);
        if (doc.ASSET) {
            for (var i in doc.ASSET) {
                emit([doc.NAME, Number(i)+1], {_id: doc.ASSET[i]});
            }
        }
    }
}