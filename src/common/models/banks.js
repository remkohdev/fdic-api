
let util = require('util');
let DataSource = require ('loopback-datasource-juggler').DataSource,
     Couchdb = require ('loopback-connector-couchdb2'); 
let _ = require('lodash');

module.exports = function(Banks) {

  var app = require('../../server/server');
  var ds = app.datasources.couchdb;

    /**
     * Returns a list of banks
     * @param {string} name The name of the bank
     * @param {string} assets Minimal assets of the bank
     * @callback {Function} callback Callback function
     * @param {Error|string} err Error object
     * @param {Bank} result Result object
     */
    Banks.getBanks = function(name, assets, callback) {
      
      if(!_.isEmpty(name) && !_.isEmpty(assets)){
        ds.connector.viewDocs('name-asset', 'name-asset-view', { keys: [name, assets], include_docs: true }, function(err, results){
          callback(err, results);
        });
      }else
      if(!_.isEmpty(name)){
        ds.connector.viewDocs('name', 'name-view', { key: name, include_docs: true }, function(err, results){
          callback(err, results);
        });
      }else
      if(!_.isEmpty(assets)){
        ds.connector.viewDocs('asset', 'asset-view', { startkey: parseInt(assets.replace(/,/g, '')), include_docs: true }, function(err, results){
          callback(err, results);
        });
      }else{
        ds.connector.viewDocs('name', 'name-view', function(err, results){
          callback(err, results);
        });
      }
    }

    /**
     * Returns a single bank
     * @param {number} bankId ID of bank to return
     * @callback {Function} callback Callback function
     * @param {Error|string} err Error object
     * @param {Bank} result Result object
     */
    Banks.getBankById = function(bankId, callback) {

      if(_.isNumber(bankId)){
        ds.connector.viewDocs('fed-rssd', 'fed-rssd-view', { key: bankId, include_docs: true }, function(err, results){
          callback(err, results);
        });
      }
      
    }

    Banks.remoteMethod('getBanks',
      { isStatic: true,
      produces: [ 'application/json' ],
      accepts: 
      [ { arg: 'name',
          type: 'string',
          description: 'The name of the bank',
          required: false,
          http: { source: 'query' } },
        { arg: 'assets',
          type: 'string',
          description: 'Minimal assets of the bank',
          required: false,
          http: { source: 'query' } } ],
      returns: 
      [ { description: 'successful operation',
          type: [ 'Bank' ],
          arg: 'data',
          root: true } ],
      http: { verb: 'get', path: '' },
      description: 'Returns a list of banks' }
    );

    Banks.remoteMethod('getBankById',
    { isStatic: true,
    produces: [ 'application/json' ],
    accepts: 
    [ { arg: 'bankId',
        type: 'number',
        description: 'ID of bank to return',
        required: true,
        http: { source: 'path' } } ],
    returns: 
    [ { description: 'successful operation',
        type: 'Bank',
        arg: 'data',
        root: true } ],
    http: { verb: 'get', path: '/:bankId' },
    description: 'Returns a single bank' }
    );

}