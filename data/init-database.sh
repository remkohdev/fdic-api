echo 'create database fdic_institutions2'
curl -X PUT http://couchdbadmin:couchdbadmin@couchdb-svc.remkohdev-ns:5984/fdic_institutions2
echo 'create database _users'
curl -X PUT http://couchdbadmin:couchdbadmin@couchdb-svc.remkohdev-ns:5984/_users
echo 'create database _replicator'
curl -X PUT http://couchdbadmin:couchdbadmin@couchdb-svc.remkohdev-ns:5984/_replicator
echo 'bulk load INSTITUTIONS data'
curl -X POST -H "Content-Type: application/json" "http://couchdbadmin:couchdbadmin@couchdb-svc.remkohdev-ns:5984/fdic_institutions2/_bulk_docs" -d '@data/INSTITUTIONS2.json'
echo 'create name-view'
curl -X PUT -H "Content-Type: application/json" -d '{ "views": { "name-view": { "map": "function(doc){ if(doc.NAME){ emit(doc.NAME, doc); }}" } }, "language": "javascript" }' http://couchdbadmin:couchdbadmin@couchdb-svc.remkohdev-ns:5984/fdic_institutions2/_design/name
echo 'create asset-view'
curl -X PUT -H "Content-Type: application/json" -d '{ "views": { "asset-view": { "map": "function(doc){ if(doc.ASSET){ emit(parseInt(doc.ASSET.replace(\/,\/g, \"\")), doc); }}" } }, "language": "javascript" }' http://couchdbadmin:couchdbadmin@couchdb-svc.remkohdev-ns:5984/fdic_institutions2/_design/asset
echo 'create name-asset-view'
curl -X PUT -H "Content-Type: application/json" -d '{ "views": {  "name-asset-view": { "map": "function(doc){ if(doc.NAME && doc.ASSET){ emit(doc.NAME, doc.ASSET); }}" } }, "language": "javascript" }' http://couchdbadmin:couchdbadmin@couchdb-svc.remkohdev-ns:5984/fdic_institutions2/_design/name-asset
echo 'create fed-rssd-view'
curl -X PUT -H "Content-Type: application/json" -d '{ "views": { "fed-rssd-view": { "map": "function(doc){ if(doc.FED_RSSD){ emit(doc.FED_RSSD); }}" } }, "language": "javascript" }' http://couchdbadmin:couchdbadmin@couchdb-svc.remkohdev-ns:5984/fdic_institutions2/_design/fed-rssd
echo 'database initialized'