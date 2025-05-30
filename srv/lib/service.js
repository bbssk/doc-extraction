const cds = require("@sap/cds");
const { getBody } = require("./body");
const { getHeaders } = require("./headers");
const { getMethod } = require("./method");
const { getPath } = require("./path");

/**
 * A generic service implementation for remote REST services.
 */
class RestRemoteService extends cds.RemoteService {
  async init() {
    this.before("*", "*", (req) => {
      const fullyQualifiedName = this.namespace + "." + req.event;
      const definition = this.model.definitions[fullyQualifiedName];

      req.method = getMethod(definition);
      req.path =  getPath(definition, req.data, this.customizeQueryParams);
      // Object.assign(
      //   req.headers,
      //   getHeaders(definition, req.data, this.customizeHeaders)
      // );
      Object.assign(
        req.headers,
        { "accept": "application/json", "content-type": "multipart/form-data" }
      );
      //req.data = getBody(definition, req.data);
      const formdata = new FormData();
      // for (const [key, value] of Object.entries(req.data)) {
      //   formdata.append(key, value);
      // }

      for (const [key, value] of Object.entries(req.data)) {
        formdata.append(key,new File([value], 'abcd.pdf', { type: 'application/pdf' }));
      }
      
     //       "options": { "schemaId": "09e6c9e4-d7b0-414f-bd85-cfee6fbb2add", "schemaVersion": "1", "clientId": "default", "documentType": "custom", "enrichment": {} }
      //formdata.append("options",JSON.stringify({ "schemaId": "09e6c9e4-d7b0-414f-bd85-cfee6fbb2add", "schemaVersion": "1", "clientId": "default", "documentType": "custom", "enrichment": {} }));
      formdata.append("options", JSON.stringify({"schemaId":"cf8cc8a9-1eee-42d9-9a3e-507a61baac23","schemaVersion":"1","clientId":"default","documentType":"invoice","enrichment":{}}))
      req.data =formdata;
      req.event = "";
    });

    await super.init();
  }

  /**
   * Add or overwrite request headers in the given object `headers`.
   * @param {object} headers
   */
  customizeHeaders(headers) {}

  /**
   * Use the given `URLSearchParams` object to add or overwrite query parameters.
   * @param {URLSearchParams} queryParams
   */
  customizeQueryParams(queryParams) {}
}

module.exports = { RestRemoteService };
