const cds = require("@sap/cds");
const { getBody } = require("../../lib/body");
const { getHeaders } = require("../../lib/headers");
const { getMethod } = require("../../lib/method");
const { getPath } = require("../../lib/path");

/**
 * A generic service implementation for remote REST services.
 */
class RestRemoteService extends cds.RemoteService {
  async init() {
    this.before("*", "*", (req) => {
      debugger;
      const fullyQualifiedName = this.namespace + "." + req.event;
      const definition = this.model.definitions[fullyQualifiedName];

      req.method = getMethod(definition);
      req.path = getPath(definition, req.data, this.customizeQueryParams);
      Object.assign(
        req.headers,
        getHeaders(definition, req.data, this.customizeHeaders)
      );
      req.data = getBody(definition, req.data);
      req.event = undefined;
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