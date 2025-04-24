/* checksum : 66f7a22395d3095e2a1baf858754bf80 */
@Capabilities.BatchSupported : false
@Capabilities.KeyAsSegmentSupported : true
@Core.Description : 'Document Information Extraction'
@Core.SchemaVersion : '1.92'
@Core.LongDescription : 'Document Information Extraction helps you to process large amounts of business documents that have content in headers and tables. You can use the extracted information, for example, to automatically process payables, invoices, or payment notes while making sure that invoices and payables match. After you upload a document file to the service, it returns the extraction results from header fields and line items.'
service Document.Information.Extraction {};

@Common.Label : 'Capabilities'
@Core.Description : 'Get the service capabilities'
@Core.LongDescription : 'Returns the JSON consisting of lists of extractable fields, enrichment and document types that the service is         capable of processing.'
@openapi.path : '/capabilities'
function Document.Information.Extraction.capabilities() returns Document.Information.Extraction_types.Capabilities;

@Common.Label : 'Client'
@Core.Description : 'Retrieve all client names and IDs that are accessible by the caller'
@Core.LongDescription : 'Returns all the client details as a list in the **`payload`** key in the returned JSON.'
@openapi.path : '/clients'
function Document.Information.Extraction.clients(
  @description : 'Filters the list of clients by the characters the id starts with.'
  @openapi.in : 'query'
  clientIdStartsWith : String,
  @description : 'Index of the first client to be retrieved. Example: 10'
  @openapi.in : 'query'
  offset : Integer,
  @description : 'Number of clients to retrieve (maximum allowed value: 50000). Example: 10'
  @openapi.in : 'query'
  @openapi.required : true
  limit : Integer
) returns Document.Information.Extraction_types.ClientPayload;

@Common.Label : 'Client'
@Core.Description : 'Delete one or more clients'
@Core.LongDescription : 'Returns an error if any of the specified client IDs does not exist.'
@openapi.method : 'DELETE'
@openapi.path : '/clients'
action Document.Information.Extraction.clients_delete(
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.DeleteClientPayload
) returns Document.Information.Extraction_types.DeleteClient;

@Common.Label : 'Client'
@Core.Description : 'Create one or more clients'
@Core.LongDescription : ```
To create a client, two parameters must be specified: **\`clientId\`** and **\`clientName\`**. The list of clients         to be created must be sent as a JSON payload in the request.

### Examples for payload parameter:
Single client: \`{"value":[{"clientId":"c_00","clientName":"client 00"}]}\`
Multiple clients: \`{"value":[{"clientId":"c_00","clientName":"client 00"},         {"clientId":"c_01","clientName":"client 01"}]}\`

### Field values:
- The spaces at the beginning and the end of the value strings are removed.
```
@openapi.path : '/clients'
action Document.Information.Extraction.clients_post(
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.PostClientPayload
) returns Document.Information.Extraction_types.PostClient;

@Common.Label : 'Configuration'
@Core.Description : 'Get all configurations for the requested scope'
@openapi.path : '/configuration'
function Document.Information.Extraction.configuration(
  @description : 'Scope of the configuration. If left empty, default scope is ''active''.'
  @assert.range : true
  @openapi.in : 'query'
  scope : String enum {
    client;
    instance;
    active;
    tenant;
  },
  @description : 'The client to set the configuration for. Only used for client scope configuration.'
  @openapi.in : 'query'
  clientId : String,
  @description : 'Tenant to get configurations for. Defaults to the tenant sending the request.'
  @openapi.in : 'query'
  tenantId : String
) returns Document.Information.Extraction_types.GetConfigurationsResponse;

@Common.Label : 'Configuration'
@Core.Description : 'Delete configurations on the given scope according to the given payload'
@Core.LongDescription : `Accepts an array of keys in the payload for configurations to be deleted.
If an empty array is given, all configurations will be deleted.`
@openapi.method : 'DELETE'
@openapi.path : '/configuration'
action Document.Information.Extraction.configuration_delete(
  @description : 'Scope of the configuration. If left empty, default scope is ''tenant''.'
  @assert.range : true
  @openapi.in : 'query'
  scope : String enum {
    client;
    instance;
    tenant;
  },
  @description : 'The client to set the configuration for. Only used for client scope configuration.'
  @openapi.in : 'query'
  clientId : String,
  @description : 'Tenant to which the configuration change is applied. Defaults to the tenant sending the request.'
  @openapi.in : 'query'
  tenantId : String,
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.DeleteConfigurationsRequest
) returns Document.Information.Extraction_types.DeleteConfigurationsResponse;

@Common.Label : 'Configuration'
@Core.Description : 'Create or update configurations based on the given payload'
@Core.LongDescription : `Configurations can be set on tenant, instance
or client level.`
@openapi.path : '/configuration'
action Document.Information.Extraction.configuration_post(
  @description : 'Scope of the configuration. If left empty, default scope is ''tenant''.'
  @assert.range : true
  @openapi.in : 'query'
  scope : String enum {
    client;
    instance;
    tenant;
  },
  @description : 'The client to set the configuration for. Only used for client scope configuration.'
  @openapi.in : 'query'
  clientId : String,
  @description : 'Tenant to which the configuration change is applied. Defaults to the tenant sending the request.'
  @openapi.in : 'query'
  tenantId : String,
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.CreateConfigurationsRequest
) returns Document.Information.Extraction_types.CreateConfigurationsResponse;

@Common.Label : 'Configuration'
@Core.Description : 'Get configurations for the requested key and the requested scope'
@openapi.path : '/configuration/{key}'
function Document.Information.Extraction.configuration_(
  @description : 'Scope of the configuration. If left empty, default scope is ''active''.'
  @assert.range : true
  @openapi.in : 'query'
  scope : String enum {
    client;
    instance;
    active;
    tenant;
  },
  @description : 'The client to set the configuration for. Only used for client scope configuration.'
  @openapi.in : 'query'
  clientId : String,
  @description : 'Tenant to get configurations for. Defaults to the tenant sending the request.'
  @openapi.in : 'query'
  tenantId : String,
  @description : ```
  Key must be one of the following predefined keys: ['performPIICheck',
   'clientSegregation',
   'manualDataActivation',
   'coordinateFormat',
   'activateDocumentNotifications',
   'dataFeedbackCollection',
   'documentRetentionTimeDays',
   'enrichmentConfidenceThreshold']
  ```
  @openapi.in : 'path'
  ![key] : String
) returns Document.Information.Extraction_types.GetConfigurationsResponse;

@Common.Label : 'Data'
@Core.Description : 'Retrieve one or more data entities that match the provided query'
@Core.LongDescription : 'Returns a JSON response with previously uploaded data entities, which match the provided query. If a single         entity matches the query, the response will contain only one entity, otherwise the response will be a list of         entities.'
@openapi.path : '/data'
function Document.Information.Extraction.data(
  @description : 'Type of data which is handled(employee, businessEntity, product)'
  @assert.range : true
  @openapi.in : 'query'
  @openapi.required : true
  type : String enum {
    employee;
    businessEntity;
    product;
  },
  @description : 'The ID of the client. Example: clientId = c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String,
  @description : 'The data ID of a single entry'
  @openapi.in : 'query'
  id : String,
  @description : 'Offset of the first item to be returned. Example: 10'
  @openapi.in : 'query'
  offset : Integer,
  @description : 'Items per page. Defines a maximum. Example: 10'
  @openapi.in : 'query'
  limit : Integer,
  @description : 'The subtype of data either supplier, customer, companyCode for business entity.'
  @assert.range : true
  @openapi.in : 'query'
  subtype : String enum {
    supplier;
    customer;
    companyCode;
  },
  @description : 'The system of the a single entry.'
  @openapi.in : 'query'
  system : String,
  @description : 'The company code of the a single entry.'
  @openapi.in : 'query'
  companyCode : String
) returns Document.Information.Extraction_types.GetData;

@Common.Label : 'Data'
@Core.Description : 'Create a data activation job record'
@openapi.path : '/data/activation'
action Document.Information.Extraction.data_activation_post(
  @description : 'Type of data which is handled(employee, businessEntity, product)'
  @assert.range : true
  @openapi.in : 'query'
  type : String enum {
    employee;
    businessEntity;
    product;
  },
  @description : 'The subtype of data either supplier, customer, companyCode for business entity.'
  @assert.range : true
  @openapi.in : 'query'
  subtype : String enum {
    supplier;
    customer;
    companyCode;
  }
) returns Document.Information.Extraction_types.PostDataActivationResult;

@Common.Label : 'Data'
@Core.Description : 'Give a data persistence job ID to check the database and receive information on this data activation job'
@Core.LongDescription : `This endpoint will return a JSON with the status and processed time of the data activation job specified by
the given ID`
@openapi.path : '/data/activation/{id}'
function Document.Information.Extraction.data_activation_(
  @description : 'The ID returned by `[POST]/data/activation` endpoint. Example: 29812f26-464e-4ee6-be63-731859cf99f3'
  @openapi.in : 'path'
  id : String
) returns Document.Information.Extraction_types.GetActivationJob;

@Common.Label : 'Data'
@Core.Description : 'Retrieve a list of all data-persistence jobs for this tenant'
@Core.LongDescription : 'Supports additional filtering by client & job status and sorting by creation date, client & job status.'
@openapi.path : '/data/jobs'
function Document.Information.Extraction.data_jobs(
  @description : 'The status of this data-persistence job. Possible values: [''PENDING'', ''SUCCESS'', ''FAILED'']'
  @openapi.in : 'query'
  status : String,
  @description : 'The ID of the client. Example: clientId = c_00'
  @openapi.in : 'query'
  clientId : String,
  @description : 'Offset of the first item to be returned. Example: 10'
  @openapi.in : 'query'
  offset : Integer,
  @description : 'Items per page. Defines a maximum. Example: 10'
  @openapi.in : 'query'
  limit : Integer,
  @description : 'Ordering criterion for the retrieved data-persistence jobs (possible values: status, client, created). Example: created asc'
  @openapi.in : 'query'
  order : String
) returns Document.Information.Extraction_types.GetPendingDataPersistenceJobs;

@Common.Label : 'Data'
@Core.Description : 'Perform the asynchronous deletion of existing data entities for the specified fields'
@Core.LongDescription : 'Performs the deletion of existing data entities for the specified fields. It accepts an array of IDs in the         payload that should be deleted. If no array is given, all entries will be deleted. It is required to use this         asynchronous endpoint for larger amounts of records, but it is recommended to use it for small amounts as well.'
@openapi.method : 'DELETE'
@openapi.path : '/data/jobs'
action Document.Information.Extraction.data_jobs_delete(
  @description : 'Type of data which is handled(employee, businessEntity, product)'
  @assert.range : true
  @openapi.in : 'query'
  type : String enum {
    employee;
    businessEntity;
    product;
  },
  @description : 'The ID of the client. Example: clientId = c_00'
  @openapi.in : 'query'
  clientId : String,
  @description : 'The subtype of data either supplier, customer, companyCode for business entity.'
  @assert.range : true
  @openapi.in : 'query'
  subtype : String enum {
    supplier;
    customer;
    companyCode;
  },
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.DeleteDataPayload
) returns Document.Information.Extraction_types.DeleteDataResult;

@Common.Label : 'Data'
@Core.Description : 'Create or update one or more data entities'
@Core.LongDescription : ```
Allows the asynchronous creation and update of data entities for a specified client ID. A request must contain         a valid JSON string as the payload parameter, which typically contains a list of multiple records of the same         data type. The result returned by this endpoint is the ID of the data persistence job responsible for         uploading/updating the data. This ID can be used in the GET /data endpoint to retrieve the current status of         the data persistence job.
The two data types that can be submitted are:
- businessEntity - Has subtype of supplier, customer, companyCode or unspecified.
- employee - Has no specified subtype.

In the payload JSON string, a mandatory field of ID must be provided for each data record for businessEntity         and employee.

### Examples for payload parameter:
**businessEntity**: \`{"value": [{"id":"BE0001", "name":"","accountNumber":"", "address1":"", "address2": "",         "city":"", "countryCode":"", "postalCode":"","state":"", "email":"", "phone":"",         "bankAccount":"", "taxId":""}]}\`

**employee**: \`{"value": [{"id":"E0001", "email":"", "firstName":"", "middleName": "", "lastName":""}]}\`
```
@openapi.path : '/data/jobs'
action Document.Information.Extraction.data_jobs_post(
  @description : 'Type of data which is handled(employee, businessEntity, product)'
  @assert.range : true
  @openapi.in : 'query'
  @openapi.required : true
  type : String enum {
    employee;
    businessEntity;
    product;
  },
  @description : 'The ID of the client. Example: clientId = c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String,
  @description : 'The subtype of data either supplier, customer, companyCode for business entity.'
  @assert.range : true
  @openapi.in : 'query'
  subtype : String enum {
    supplier;
    customer;
    companyCode;
  },
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.DataPayload
) returns Document.Information.Extraction_types.PostDataResult;

@Common.Label : 'Data'
@Core.Description : 'Return information about a data persistence job'
@Core.LongDescription : 'Takes a data persistence job ID as input and returns a JSON with the status and processing time of the         corresponding data persistence job.'
@openapi.path : '/data/jobs/{id}'
function Document.Information.Extraction.data_jobs_(
  @description : 'The ID returned by `[POST/DELETE]/data/jobs` endpoint. Example: 29812f26-464e-4ee6-be63-731859cf99f3'
  @openapi.in : 'path'
  id : String
) returns Document.Information.Extraction_types.GetDataJob;

@Common.Label : 'Document'
@Core.Description : 'Post a search/filter request to get the current status of document processing jobs'
@Core.LongDescription : ```
Returns a list with all document processing jobs as JSON.
Optionally, the jobs can be filtered based on the client ID and a filter query.
Catalog options:
- pagination using limit and offset
- ordering using order
- filtering using filters
```
@openapi.path : '/document/catalog'
action Document.Information.Extraction.document_catalog_post(
  @description : ```
  
  Catalog options used when searching for documents.
  - \`clientId\`: The ID of the client used while submitting the document. Example: c_00
  - \`limit\`: Number of documents to retrieve (maximum allowed value: 200). Example: 10
  - \`offset\`: Index of the first document to be retrieved. Example: 20
  - \`order\`: Ordering criterion for the retrieved documents (possible values: created, fileName, documentType, status). Example: created asc
  - \`likeFilter\`: Filter query for retrieving documents that uses the LIKE operator. The expression should follow the format "fieldName like value". Supported fields are: fileName. Example: "fileName like "test receipt""
  - \`filter\`: Filter query for retrieving documents. The filter query needs to be an expression. The expression should follow the format "fieldName op value <AND/OR> fieldName op value". Supported fields are: documentType, created, status, customLabel, reviewStatus, tenantId, jobId. Possible operators (op) depend on the field. Example: "status eq done"
  
  ```
  @openapi.in : 'formData'
  options : String default ```
  {
    "clientId": "c_00",
    "limit": 10,
    "offset": 2,
    "order": "created desc",
    "likeFilter": "fileName like \\"test receipt\\"",
    "filter": "status eq failed or documentType eq invoice"
  }
  ```
) returns Document.Information.Extraction_types.PostDocumentsCatalogResult;

@Common.Label : 'Document'
@Core.Description : 'Get the current status of document processing jobs'
@Core.LongDescription : 'Returns a list with all document processing jobs as JSON. Optionally, the jobs can be filtered based on the         client ID.'
@openapi.path : '/document/jobs'
function Document.Information.Extraction.document_jobs(
  @description : 'The ID of the client used while submitting the document. Example: c_00'
  @openapi.in : 'query'
  clientId : String
) returns Document.Information.Extraction_types.GetDocumentsResult;

@Common.Label : 'Document'
@Core.Description : 'Delete one or more documents and all related data'
@Core.LongDescription : 'Performs the deletion of a list of documents and all related data like extracted field values and ground         truth. The payload is an optional array of IDs that will be deleted. If this parameter is not present, all         documents will be deleted.'
@openapi.method : 'DELETE'
@openapi.path : '/document/jobs'
action Document.Information.Extraction.document_jobs_delete(
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.DeleteDocuments
) returns Document.Information.Extraction_types.DeleteAllDocumentsStatusMessage;

@Common.Label : 'Document'
@Core.Description : 'Submit a document for processing'
@Core.LongDescription : 'Performs a document submission (e.g a **pdf**, **png** or **jpeg** file) for asynchronous processing. Returns         a document job ID if the document is submitted successfully. This ID can be used with other endpoints like         GET /document/jobs/{id} and DELETE /document/jobs/{id}.'
@openapi.path : '/document/jobs'
action Document.Information.Extraction.document_jobs_post(
  @description : 'The document you wish to submit for processing'
  @openapi.in : 'formData'
  @openapi.required : true
  file : String,
  @description : ```
  
  Options for processing the document.
  - \`headerFields\`: List of header fields to be extracted from the submitted invoice.
  - \`lineItemFields\`: List of line item fields to be extracted from the submitted invoice.
  - \`clientId\`: The ID of the client. Example: 'c_00'
  - \`documentType\`: The type of document being uploaded. Choices: 'invoice', 'paymentAdvice', 'purchaseOrder', 'businessCard', 'deliveryNote', 'resume', 'birthCertificate'
  - \`schemaName\`/\`schemaId\`: The  name or ID of the schema to be used for this document. Either one of _schemaName_, _schemaId_ or _extraction_ field  must be provided but not multiple.
  - \`schemaVersion\`: The version number of the schema to be used for this document. In  the payload, _schemaId_ or _schemaName_ must be provided. If _schemaVersion_ is not provided default version 1 will  be used.
  - \`receivedDate\`: The date at which the document was received. Example: '2020-02-17'
  - \`customLabel\`: The label customer wants to use for the document. This is optional. If used, we can  query the corresponding document ID using the _POST /document/catalog_ endpoint.
  - \`templateId\`: The ID of the template to be used for this document. If _templateId_ is set, also  _schemaId_ or _schemaName_ must be provided. To detect templateId automatically, use the value  'detect' instead of the ID string.
  - \`candidateTemplateIds\`: IDs of templates from which the service automatically detects the  appropriate templateId.
  - \`enrichment\`: Activate matching and define number of results and types.
  
  ```
  @openapi.in : 'formData'
  options : String default ```
  {
    "schemaName": "SAP_invoice_schema",
    "clientId": "c_00",
    "documentType": "invoice",
    "receivedDate": "2020-02-17",
    "enrichment": {
      "sender": {
        "top": 5,
        "type": "businessEntity",
        "subtype": "supplier"
      },
      "employee": {
        "type": "employee"
      }
    }
  }
  ```
) returns Document.Information.Extraction_types.DocumentStatus;

@Common.Label : 'Document'
@Core.Description : 'Retrieve the results of a document previously submitted for all requested fields'
@Core.LongDescription : 'Takes the job ID of a previously submitted document and returns the corresponding processing results, or an         error, if the given ID was not found.'
@openapi.path : '/document/jobs/{id}'
function Document.Information.Extraction.document_jobs_(
  @description : 'The ID returned when a document is submitted via **`[POST]/document/jobs`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  id : String,
  @description : 'Set to true to return all fields and line items, even if no value could be found. The default behavior is to not return these null value fields.'
  @openapi.in : 'query'
  returnNullValues : Boolean,
  @description : 'Set to true to fetch the extracted values. Set to false to fetch the ground truth values if available; if ground truth values are not available, extracted values will be returned in any case. The default value is false. I.e. By default the system returns the ground truth with higher priority.'
  @openapi.in : 'query'
  extractedValues : Boolean
) returns Document.Information.Extraction_types.GetDocumentResult;

@Common.Label : 'Document'
@Core.Description : 'Save the ground truth (correct values for document fields) for the specified document job ID'
@Core.LongDescription : ```
Takes the job ID of a document submitted previously and returns the corresponding processing results, or an         error, if the given ID was not found.
Only the fields of a document (header fields and line item fields) and the enrichment data should be part of
the payload aside from the document ID since they are the only fields relevant for the ground truth.
For the fields, the following attributes are part of the ground truth:
    - name (required)
    - value (required)
    - rawValue (optional)
    - page (optional)
    - coordinates (optional)
For enrichment data, the following attributes are relevant for the ground truth:
    - id (required)
```
@openapi.path : '/document/jobs/{id}'
action Document.Information.Extraction.document_jobs__post(
  @description : 'The ID returned when a document is submitted via **`[POST]/document/jobs`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  id : String,
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.PostDocumentGroundTruth
) returns Document.Information.Extraction_types.DocumentCreatedId;

@Common.Label : 'Document'
@Core.Description : 'Set document status to confirmed'
@Core.LongDescription : `Takes the job ID of a document and sets the document status to confirmed. Once a document is confirmed, it
cannot be changed anymore (e.g. no more upload of ground truth will be possible).`
@openapi.path : '/document/jobs/{id}/confirm'
action Document.Information.Extraction.document_jobs__confirm_post(
  @description : 'ID to identify the document'
  @openapi.in : 'path'
  id : String,
  @description : 'Set to true to allow the document to be used for retraining'
  @openapi.in : 'query'
  dataForRetraining : Boolean
) returns Document.Information.Extraction_types.DocumentConfirmedId;

@Common.Label : 'Document'
@Core.Description : 'GET the original uploaded document'
@openapi.path : '/document/jobs/{id}/file'
function Document.Information.Extraction.document_jobs__file(
  @description : 'ID to identify the document'
  @openapi.in : 'path'
  id : String
) returns Boolean;

@Common.Label : 'Document'
@Core.Description : 'Retrieve the OCR output for all pages of a document'
@Core.LongDescription : 'Takes the job ID of a document and returns the OCR output for all pages of a document.'
@openapi.path : '/document/jobs/{id}/pages/text'
function Document.Information.Extraction.document_jobs__pages_text(
  @description : 'ID to identify the document'
  @openapi.in : 'path'
  id : String
) returns Document.Information.Extraction_types.PagesText;

@Common.Label : 'Document'
@Core.Description : 'Retrieve the OCR output for the specified page of a document'
@Core.LongDescription : 'Takes the job ID and a single page number of a document and returns the OCR output for the respective page.'
@openapi.path : '/document/jobs/{id}/pages/{no}/text'
function Document.Information.Extraction.document_jobs__pages__text(
  @description : 'ID to identify the document'
  @openapi.in : 'path'
  id : String,
  @description : 'The page number of the document (int)'
  @openapi.in : 'path'
  no : String
) returns Document.Information.Extraction_types.PageText;

@Common.Label : 'Document'
@Core.Description : 'Retrieve the request payload of a previously submitted document'
@Core.LongDescription : 'Takes the job ID of a document and returns the request payload specified during initial upload of the document.'
@openapi.path : '/document/jobs/{id}/request'
function Document.Information.Extraction.document_jobs__request(
  @description : 'ID to identify the document'
  @openapi.in : 'path'
  id : String
) returns Document.Information.Extraction_types.DocumentOptions;

@Common.Label : 'Document'
@Core.Description : 'Retrieve all the templates associated with the document id'
@openapi.path : '/document/jobs/{id}/template'
function Document.Information.Extraction.document_jobs__template(
  @description : 'The ID returned when a document is submitted via **`[POST]/document/jobs`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  id : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.DocumentTemplateAssociations;

@Common.Label : 'Schema'
@Core.Description : 'Retrieve all schemas for a client'
@openapi.path : '/schemas'
function Document.Information.Extraction.schemas(
  @description : 'The offset of the query result start index to be returned'
  @openapi.in : 'query'
  offset : Integer,
  @description : 'Max. number of records to be returned. If limit=0 (maximum allowed value: 1000), all records are returned.'
  @openapi.in : 'query'
  limit : Integer,
  @description : 'Order the results'
  @openapi.in : 'query'
  order : String,
  @description : 'Set to true for standard documents or false for custom documents'
  @openapi.in : 'query'
  predefined : Boolean,
  @description : 'The type of the document used when creating the schema. Example: invoice, custom, paymentAdvice'
  @openapi.in : 'query'
  documentType : String,
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String,
  @description : 'Set this to true to fetch all schema versions. The default is false, which only fetches details about version 1 or the first version of the schema'
  @openapi.in : 'query'
  fetchVersions : Boolean
) returns Document.Information.Extraction_types.SchemaListed;

@Common.Label : 'Schema'
@Core.Description : 'Delete one or more schemas for a client'
@openapi.method : 'DELETE'
@openapi.path : '/schemas'
action Document.Information.Extraction.schemas_delete(
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String,
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.DeleteSchemas
) returns Document.Information.Extraction_types.DeleteSchema;

@Common.Label : 'Schema'
@Core.Description : 'Create one or more schemas for a client'
@openapi.path : '/schemas'
action Document.Information.Extraction.schemas_post(
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.SchemaCreation
) returns Document.Information.Extraction_types.SchemaCreated;

@Common.Label : 'Schema'
@Core.Description : 'Retrieve all schema capabilities'
@openapi.path : '/schemas/capabilities'
function Document.Information.Extraction.schemas_capabilities() returns Document.Information.Extraction_types.SchemaCapabilities;

@Common.Label : 'Schema'
@Core.Description : 'Retrieve schema details for a client'
@openapi.path : '/schemas/{schemaId}'
function Document.Information.Extraction.schemas_(
  @description : 'The ID returned when a schema is created via **`[POST]/schemas`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  schemaId : String,
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.SchemaDetail;

@Common.Label : 'Schema'
@Core.Description : 'Update existing schemas for a client'
@openapi.method : 'PUT'
@openapi.path : '/schemas/{schemaId}'
action Document.Information.Extraction.schemas__put(
  @description : 'The ID returned when a schema is created via **`[POST]/schemas`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  schemaId : String,
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String,
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.Schemamodel
) returns Document.Information.Extraction_types.UpdateSchema;

@Common.Label : 'Schema'
@Core.Description : 'Create a new version for schema'
@openapi.path : '/schemas/{schemaId}'
action Document.Information.Extraction.schemas__post(
  @description : 'The ID returned when a schema is created via **`[POST]/schemas`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  schemaId : String,
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.SchemaVersionCreated;

@Common.Label : 'Schema'
@Core.Description : 'Retrieve all versions for schema'
@openapi.path : '/schemas/{schemaId}/versions'
function Document.Information.Extraction.schemas__versions(
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String,
  @description : 'The ID returned when a schema is created via **`[POST]/schemas`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  schemaId : String
) returns Document.Information.Extraction_types.SchemaVersionListed;

@Common.Label : 'Schema'
@Core.Description : 'Delete versions associated with schema'
@openapi.method : 'DELETE'
@openapi.path : '/schemas/{schemaId}/versions'
action Document.Information.Extraction.schemas__versions_delete(
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String,
  @description : 'The ID returned when a schema is created via **`[POST]/schemas`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  schemaId : String,
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.DeleteVersion
) returns Document.Information.Extraction_types.DeleteSchemaVersion;

@Common.Label : 'Schema'
@Core.Description : 'Retrieve version details of schema for a client'
@openapi.path : '/schemas/{schemaId}/versions/{version}'
function Document.Information.Extraction.schemas__versions_(
  @description : 'The ID returned when a schema is created via **`[POST]/schemas`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  schemaId : String,
  @description : 'The version number returned when a new version is created via **`[POST]/schemas/<schema_id>`** endpoint. Example: 1'
  @openapi.in : 'path'
  version : String,
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.SchemaVersionDetail;

@Common.Label : 'Schema'
@Core.Description : 'Activate the particular schema version of a schema'
@openapi.path : '/schemas/{schemaId}/versions/{version}/activate'
action Document.Information.Extraction.schemas__versions__activate_post(
  @description : 'The ID returned when a schema is created via **`[POST]/schemas`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  schemaId : String,
  @description : 'The version number returned when a new version is created via **`[POST]/schemas/<schema_id>`** endpoint. Example: 1'
  @openapi.in : 'path'
  version : String,
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.ActivateSchemaVersion;

@Common.Label : 'Schema'
@Core.Description : 'Deactivate the particular schema version of a schema'
@openapi.path : '/schemas/{schemaId}/versions/{version}/deactivate'
action Document.Information.Extraction.schemas__versions__deactivate_post(
  @description : 'The ID returned when a schema is created via **`[POST]/schemas`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  schemaId : String,
  @description : 'The version number returned when a new version is created via **`[POST]/schemas/<schema_id>`** endpoint. Example: 1'
  @openapi.in : 'path'
  version : String,
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.DeactivateSchemaVersion;

@Common.Label : 'Schema'
@Core.Description : 'Add fields to schema version'
@openapi.path : '/schemas/{schemaId}/versions/{version}/fields'
action Document.Information.Extraction.schemas__versions__fields_post(
  @description : 'The ID returned when a schema is created via **`[POST]/schemas`** endpoint. Example: 4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  @openapi.in : 'path'
  schemaId : String,
  @description : 'The version number returned when a new version is created via **`[POST]/schemas/<schema_id>`** endpoint. Example: 1'
  @openapi.in : 'path'
  version : String,
  @description : 'The ID of the client used when creating the schema. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String,
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.SchemaFields
) returns Document.Information.Extraction_types.FieldsSchemaVersion;

@Common.Label : 'Template'
@Core.Description : 'Get templates for a client ID'
@openapi.path : '/templates'
function Document.Information.Extraction.templates(
  @description : 'The offset of the query result start index to be returned. Example: 0'
  @openapi.in : 'query'
  offset : Integer,
  @description : 'Max number of records to be returned. All records are returned if limit=0. Example: 10'
  @openapi.in : 'query'
  limit : Integer,
  @description : 'Order the results. Example: name asc'
  @openapi.in : 'query'
  order : String(128),
  @description : 'Client ID. Example: c_00'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String(64),
  @description : 'Schema ID. Example: 484b6e1c-501c-4a07-85cb-84554656a175'
  @openapi.in : 'query'
  schemaId : String(64),
  @description : 'Result should include header fields'
  @openapi.in : 'query'
  includeHeader : Boolean,
  @description : 'Result should include line item fields'
  @openapi.in : 'query'
  includeLineItems : Boolean
) returns Document.Information.Extraction_types.GetTemplateV2;

@Common.Label : 'Template'
@Core.Description : 'Create or update a template'
@Core.LongDescription : ```
If an ID (template ID) is not provided, a template ID is generated and returned.
If an ID (template ID) is provided, but it is not in the system, a new record with template ID provided
is created.
If an ID (template ID) is provided, and it is in the system, an update of record with same template ID
is executed.
```
@openapi.path : '/templates'
action Document.Information.Extraction.templates_post(
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.PostTemplatePayload_v2
) returns Document.Information.Extraction_types.PostTemplateResponse;

@Common.Label : 'Template'
@Core.Description : 'Import a template'
@openapi.path : '/templates/import'
action Document.Information.Extraction.templates_import_post(
  @description : 'The template file you wish to import'
  @openapi.in : 'formData'
  @openapi.required : true
  file : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
);

@Common.Label : 'Template'
@Core.Description : 'Get template details for a template ID'
@Core.LongDescription : 'A user is only allowed to retrieve template details that belong to the same zone_id and client_id.'
@openapi.path : '/templates/{template_id}'
function Document.Information.Extraction.templates_(
  @description : 'The ID of the template. Example: ''4176cc01-71f3-4b64-9eb0-cdd9c0cb27fd'''
  @openapi.in : 'path'
  template_id : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.GetTemplateDetails_V2;

@Common.Label : 'Template'
@Core.Description : 'Delete a template and its links to the associated documents for template ID'
@openapi.method : 'DELETE'
@openapi.path : '/templates/{template_id}'
action Document.Information.Extraction.templates__delete(
  @description : 'The ID of the template. Example: ''4176cc01-71f3-4b64-9eb0-cdd9c0cb27fd'''
  @openapi.in : 'path'
  template_id : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.DeleteTemplateV2;

@Common.Label : 'Template'
@Core.Description : 'Activate a template'
@openapi.path : '/templates/{template_id}/activate'
action Document.Information.Extraction.templates__activate_post(
  @description : 'The ID of the template. Example: ''4176cc01-71f3-4b64-9eb0-cdd9c0cb27fd'''
  @openapi.in : 'path'
  template_id : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.TemplateActivateActionResponseV2;

@Common.Label : 'Template'
@Core.Description : 'Deactivate a template'
@openapi.path : '/templates/{template_id}/deactivate'
action Document.Information.Extraction.templates__deactivate_post(
  @description : 'The ID of the template. Example: ''4176cc01-71f3-4b64-9eb0-cdd9c0cb27fd'''
  @openapi.in : 'path'
  template_id : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.TemplateDeActivateActionResponseV2;

@Common.Label : 'Template'
@Core.Description : 'Dissociate a document from a template'
@openapi.method : 'DELETE'
@openapi.path : '/templates/{template_id}/documents/{document_id}'
action Document.Information.Extraction.templates__documents__delete(
  @description : 'The ID of the document. Example: ''5146ce05-7tf3-4g64-9eb0-vaa9f9cb22af'''
  @openapi.in : 'path'
  document_id : String,
  @description : 'The ID of the template. Example: ''4176cc01-71f3-4b64-9eb0-cdd9c0cb27fd'''
  @openapi.in : 'path'
  template_id : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.DeleteAddedDocumentResponse;

@Common.Label : 'Template'
@Core.Description : 'Associate a document with a template'
@openapi.path : '/templates/{template_id}/documents/{document_id}'
action Document.Information.Extraction.templates__documents__post(
  @description : 'The ID of the document. Example: ''5146ce05-7tf3-4g64-9eb0-vaa9f9cb22af'''
  @openapi.in : 'path'
  document_id : String,
  @description : 'The ID of the template. Example: ''4176cc01-71f3-4b64-9eb0-cdd9c0cb27fd'''
  @openapi.in : 'path'
  template_id : String,
  @description : 'Set to false to skip document status validation when associating document with template. The default value is true.'
  @openapi.in : 'query'
  validateDocumentStatus : Boolean,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.DocumentAddResponse;

@Common.Label : 'Template'
@Core.Description : 'Export a template'
@openapi.path : '/templates/{template_id}/export'
function Document.Information.Extraction.templates__export(
  @description : 'The ID of the template. Example: ''4176cc01-71f3-4b64-9eb0-cdd9c0cb27fd'''
  @openapi.in : 'path'
  template_id : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Boolean;

@Common.Label : 'Template'
@Core.Description : 'Get all metadata fields of a template'
@openapi.path : '/templates/{template_id}/metadata'
function Document.Information.Extraction.templates__metadata(
  @description : 'The ID of the template. Example: ''4176cc01-71f3-4b64-9eb0-cdd9c0cb27fd'''
  @openapi.in : 'path'
  template_id : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String
) returns Document.Information.Extraction_types.MetaDataFields;

@Common.Label : 'Template'
@Core.Description : 'Set metadata fields of a template'
@Core.LongDescription : ```
Payload parameter:
- name(required): schema field name
- value(optional): fixed value for header field, fixed value is only applicable to header fields and will be         ignored for line item fields. Default is null
- extraction(optional): specify the extractor for the field, allow value are 'template' and 'schema'.         Default is 'template'
- isLineItemField(optional): should be 'true' if field is a line item field. Default is 'false'
```
@openapi.path : '/templates/{template_id}/metadata'
action Document.Information.Extraction.templates__metadata_post(
  @description : 'The ID of the template. Example: ''4176cc01-71f3-4b64-9eb0-cdd9c0cb27fd'''
  @openapi.in : 'path'
  template_id : String,
  @description : 'The ID of the client'
  @openapi.in : 'query'
  @openapi.required : true
  clientId : String,
  @openapi.in : 'body'
  body : Document.Information.Extraction_types.MetaDataFields
) returns Document.Information.Extraction_types.TemplatePostMetadataResponse;

type Document.Information.Extraction_types.InternalServerError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Internal server error'
  message : String;
};

type Document.Information.Extraction_types.UnauthorizedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'No Authorization given in the request header'
  message : String;
};

type Document.Information.Extraction_types.Capabilities {
  @description : 'Extractable fields along with associated datatypes'
  extraction : Document.Information.Extraction_types.FieldCapabilities;
  @description : 'Document types which can be processed using Document Information Extraction service'
  documentTypes : many String;
  @description : 'Fields extracted from various types of documents along with supported documents for each field'
  enrichment : Document.Information.Extraction_types.Enrichment;
  isExternalModelConsumptionAllowed : Boolean;
};

type Document.Information.Extraction_types.FieldCapabilities {
  headerFields : many Document.Information.Extraction_types.SingleFieldCapabilities;
  lineItemFields : many Document.Information.Extraction_types.SingleFieldCapabilities;
};

type Document.Information.Extraction_types.SingleFieldCapabilities {
  name : String;
  type : String;
};

type Document.Information.Extraction_types.Enrichment {
  sender : many Document.Information.Extraction_types.SingleEnrichmentCapabilities;
  @openapi.name : '...'
  ___ : many Document.Information.Extraction_types.SingleEnrichmentCapabilities;
};

type Document.Information.Extraction_types.SingleEnrichmentCapabilities {
  dataTypes : String;
};

type Document.Information.Extraction_types.DeleteClientPayload {
  value : many Document.Information.Extraction.anonymous.type0;
};

type Document.Information.Extraction_types.PostClientPayload {
  value : many Document.Information.Extraction.anonymous.type1;
};

type Document.Information.Extraction_types.Client {
  clientId : String(128);
  clientName : String(100);
};

type Document.Information.Extraction_types.BadRequestInvalidParamError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E52'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'The parameter must be an integer.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.ClientPayload {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '1234'
  id : String;
  payload : many Document.Information.Extraction.anonymous.type2;
};

type Document.Information.Extraction_types.BadRequestClientDeletionFailedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E24'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Client deletion failed.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.DeleteClient {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully deleted 1 client(s).'
  message : String;
};

type Document.Information.Extraction_types._429ConsumptionQuotaExceededError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E102'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Request exceeds consumption quotas.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.BadRequestClientNotAddedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E98'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Could not add clients.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.PostClient {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 1
  inserted : Integer;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 2
  modified : Integer;
};

type Document.Information.Extraction_types.BadRequestClientNotExistsError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E1'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Invalid client ID. The provided client ID does not exist.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.DeleteConfigurationsRequest {
  value : many Document.Information.Extraction.anonymous.type3;
};

type Document.Information.Extraction_types.CreateConfigurationsRequest {
  value : Document.Information.Extraction_types.Configurations_key_value_pairs;
};

@description : ```
Key: one from the predefined list of keys: ['performPIICheck',
 'clientSegregation',
 'manualDataActivation',
 'coordinateFormat',
 'activateDocumentNotifications',
 'dataFeedbackCollection',
 'documentRetentionTimeDays',
 'enrichmentConfidenceThreshold'].
Value: a non-empty string.
```
type Document.Information.Extraction_types.Configurations_key_value_pairs { };

type Document.Information.Extraction_types.GetConfigurationsResponse {
  results : Document.Information.Extraction_types.Configurations_key_value_pairs;
};

type Document.Information.Extraction_types.BadRequestInvalidJsonError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E56'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Invalid JSON found in the request.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.DeleteConfigurationsResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 2
  deleted : Integer;
};

type Document.Information.Extraction_types.CreateConfigurationsResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 1
  inserted : Integer;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 2
  modified : Integer;
};

type Document.Information.Extraction_types.DocumentConfirmedId {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'CONFIRMED'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Document confirmed successfully.'
  message : String;
};

type Document.Information.Extraction_types.PostDocumentGroundTruth {
  languages : many String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'US'
  country : String(5);
  extraction : Document.Information.Extraction_types.DocumentExtractionGroundTruth;
  enrichment : Document.Information.Extraction_types.MatchedFieldsGroundTruth;
};

type Document.Information.Extraction_types.DocumentExtractionGroundTruth {
  @description : 'Header fields of a document'
  headerFields : many { };
  @description : 'Lineitems of a document'
  lineItems : many Document.Information.Extraction.anonymous.type4;
};

type Document.Information.Extraction_types.MatchedFieldsGroundTruth {
  sender : many Document.Information.Extraction_types.MatchedSender;
  employee : many Document.Information.Extraction_types.MatchedEmployee;
};

type Document.Information.Extraction_types.MatchedSender {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'BE0001'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 1
  confidence : Decimal;
};

type Document.Information.Extraction_types.MatchedEmployee {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E0001'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 1
  confidence : Decimal;
};

type Document.Information.Extraction_types.BadRequestMissingParameterError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E93'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Required parameters not provided.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.GetDocumentResult {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'invoice1-pdf'
  fileName : String(255);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'invoice'
  documentType : String(20);
  created : String;
  finished : String;
  languages : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'pdf'
  fileType : String;
  country : String(5);
  receivedDate : String;
  extraction : Document.Information.Extraction_types.DocumentExtraction;
  enrichment : Document.Information.Extraction_types.MatchedFields;
};

type Document.Information.Extraction_types.DocumentExtraction {
  @description : 'Header fields of a document'
  headerFields : many Document.Information.Extraction_types.DocumentHeaderField;
  @description : 'Lineitems of a document'
  lineItems : many Document.Information.Extraction_types.DocumentLineitem;
};

type Document.Information.Extraction_types.DocumentHeaderField {
  name : String(30);
  value : String;
  confidence : Decimal;
  model : String;
  page : Integer;
  coordinates : Document.Information.Extraction.anonymous.type5;
};

type Document.Information.Extraction_types.FieldCoordinates {
  x : Decimal;
  y : Decimal;
  w : Decimal;
  h : Decimal;
};

type Document.Information.Extraction_types.DocumentLineitem {
  name : String(30);
  value : String;
  confidence : Decimal;
  model : String;
  page : Integer;
  coordinates : Document.Information.Extraction.anonymous.type6;
};

type Document.Information.Extraction_types.MatchedFields {
  sender : many Document.Information.Extraction_types.MatchedSender;
  employee : many Document.Information.Extraction_types.MatchedEmployee;
};

type Document.Information.Extraction_types.DocumentCreatedId {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Ground truth / corrected values uploaded successfully'
  message : String;
};

type Document.Information.Extraction_types.DeleteDocuments {
  value : many Document.Information.Extraction.anonymous.type7;
};

type Document.Information.Extraction_types.GetDocumentsResult {
  results : many Document.Information.Extraction.anonymous.type8;
};

type Document.Information.Extraction_types.ListedDocument {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c1673dee-56d6-4960-9a36-c29529f04b4a'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'invoice.pdf'
  fileName : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'invoice'
  documentType : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26 17:00:00.000000+00:00'
  created : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26 17:02:00.000000+00:00'
  finished : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c1'
  clientId : String;
};

type Document.Information.Extraction_types.DeleteAllDocumentsStatusMessage {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Documents deleted successfully.'
  message : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26T17:00:00.000000+00:00'
  processedTime : Date;
};

type Document.Information.Extraction_types.ServiceUnavailableError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'System is temporarily unavailable'
  message : String;
};

type Document.Information.Extraction_types._415DocumentPostError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E11'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Error in parsing the document.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.BadRequestNoFileUploadedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E92'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'No file was uploaded for processing.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.DocumentStatus {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'PENDING'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26T17:00:00.000000+00:00'
  processedTime : Date;
};

type Document.Information.Extraction_types.PostDocumentsCatalogResult {
  results : many Document.Information.Extraction.anonymous.type9;
  usedOptions : Document.Information.Extraction.anonymous.type10;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 5
  totalDocumentCount : Integer;
};

type Document.Information.Extraction_types.DocumentCatalogOptions {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 10
  limit : Integer;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 2
  offset : Integer;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'created desc'
  order : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'fileName like test receipt'
  likeFilter : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'status eq done or documentType eq invoice'
  filter : String;
};

type Document.Information.Extraction_types.PageText {
  value : many Document.Information.Extraction_types.PagesTextWord;
};

type Document.Information.Extraction_types.PagesTextWord {
  word_boxes : many Document.Information.Extraction.anonymous.type11;
};

type Document.Information.Extraction_types.PagesText {
  results : Document.Information.Extraction_types.PagesTextResults;
};

type Document.Information.Extraction_types.PagesTextResults {
  @openapi.name : '1'
  _1 : many Document.Information.Extraction_types.PagesTextWord;
  @openapi.name : '2'
  _2 : many Document.Information.Extraction_types.PagesTextWord;
  @openapi.name : '3'
  _3 : many Document.Information.Extraction_types.PagesTextWord;
};

type Document.Information.Extraction_types.DocumentOptions {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '...'
  extraction : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'invoice'
  documentType : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-02-17'
  receivedDate : String;
};

type Document.Information.Extraction_types.DocumentTemplateAssociations {
  templateId : many Document.Information.Extraction.anonymous.type12;
};

type Document.Information.Extraction_types.DeleteDataPayload {
  value : many Document.Information.Extraction_types.Delete;
};

type Document.Information.Extraction_types.Delete {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E0001'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'companyCode'
  companyCode : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '1234'
  system : String;
};

type Document.Information.Extraction_types.BadRequestDataRetrieveFailedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E5'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Failed to retrieve data.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.GetData {
  value : many Document.Information.Extraction.anonymous.type13;
};

type Document.Information.Extraction_types.BadRequestDataDeleteFailedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E51'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Failed to delete data.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.DeleteDataResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2'
  deleted : String;
};

type Document.Information.Extraction_types.GetDataJob {
  value : Document.Information.Extraction_types.GetDataJobPayload;
};

type Document.Information.Extraction_types.GetDataJobPayload {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '0:00:00.134951'
  processedTime : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2019-07-04T15:20:37.668873+00:00'
  refreshedAt : String;
};

type Document.Information.Extraction_types.DataPayload {
  value : many Document.Information.Extraction_types.Employee;
};

type Document.Information.Extraction_types.Employee {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E0001'
  id : String(128);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'foo@bar.com'
  email : String(100);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Foo'
  firstName : String(100);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'M.'
  middleName : String(100);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Bar'
  lastName : String(100);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'system'
  system : String(10);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '4711'
  companyCode : String(4);
};

type Document.Information.Extraction_types.GetPendingDataPersistenceJobs {
  value : Document.Information.Extraction_types.GetPendingDataPersistenceJobsPayload;
};

type Document.Information.Extraction_types.GetPendingDataPersistenceJobsPayload {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'PENDING'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2019-07-04T15:20:37.668873+00:00'
  created : String;
};

type Document.Information.Extraction_types.DataLimitExceededError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E87'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Limit per request exceeded.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.BadRequestDataPersistFailedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E53'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Failed to persist data.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.DeleteDataResult {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'PENDING'
  status : String;
};

type Document.Information.Extraction_types.PostDataResult {
  totalDocumentCount : Integer default 7;
  job_ids : many Document.Information.Extraction.anonymous.type14;
};

type Document.Information.Extraction_types.BadRequestPostActivationJobFailedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E144'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Data activation has been executed recently.'
  message : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Next data activation possible in 45 minutes'
  details : String;
};

type Document.Information.Extraction_types.PostDataActivationResult {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'PENDING'
  status : String;
};

type Document.Information.Extraction_types.BadRequestActivationJobRetrieveFailedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E5'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Failed to retrieve data.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.GetActivationJob {
  value : Document.Information.Extraction_types.GetActivationJobPayload;
};

type Document.Information.Extraction_types.GetActivationJobPayload {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '0:01:00'
  processedTime : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2019-07-04T15:20:37.668873+00:00'
  created : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2019-07-04T15:21:37.668873+00:00'
  finished : String;
};

type Document.Information.Extraction_types.DeleteSchemas {
  value : many Document.Information.Extraction.anonymous.type15;
};

type Document.Information.Extraction_types.SchemaCreation {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Custom_Payment_Advice_Schema'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema For Accounts Department Payment Advices'
  schemaDescription : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'paymentAdvice'
  documentType : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Payment Advice with Order Number'
  documentTypeDescription : String;
};

type Document.Information.Extraction_types.SchemaListed {
  schemas : many Document.Information.Extraction.anonymous.type16;
};

type Document.Information.Extraction_types.SchemaAttributes {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Basic Involve FormatSchema'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'SAP Invoice Schema'
  schemaDescription : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Invoice'
  documentType : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Payment Advice with Order Number'
  documentTypeDescription : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26T17:00:00.000000+00:00'
  created : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-04-26T17:00:00.000000+00:00'
  updated : Date;
  predefined : Boolean;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'draft'
  state : String;
};

type Document.Information.Extraction_types.DeleteSchema {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schemas deleted successfully.'
  message : String;
};

type Document.Information.Extraction_types.SchemaCreated {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26T17:00:00.000000+00:00'
  created : Date;
};

type Document.Information.Extraction_types.Schemamodel {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Custom_Payment_Advice_Schema'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema For Accounts Department Payment Advices'
  schemaDescription : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Payment Advice with Order Number'
  documentTypeDescription : String;
};

type Document.Information.Extraction_types.SchemaDetail {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Custom_Payment_Advice_Schema'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema For Accounts Department Payment Advices'
  schemaDescription : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'paymentAdvice'
  documentType : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Payment Advice with Order Number'
  documentTypeDescription : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '893bc685-9a00-43dd-baf4-32e5752b9a0c'
  id : String;
  predefined : Boolean;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '1'
  version : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2024-02-26T03:52:50.773409+00:00'
  created : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2024-02-26T03:52:50.773413+00:00'
  updated : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'active'
  state : String;
  @description : 'Headerfields of a schema'
  headerFields : many Document.Information.Extraction_types.Field;
  @description : 'Lineitems of a schema'
  lineItemFields : many Document.Information.Extraction_types.Field;
};

type Document.Information.Extraction_types.Field {
  name : String(30);
  description : String(100);
  defaultExtractor : Document.Information.Extraction.anonymous.type17;
  setupType : String;
  setupTypeVersion : String;
  setup : Document.Information.Extraction.anonymous.type18;
  formatting : Document.Information.Extraction.anonymous.type19;
  formattingType : String;
  formattingTypeVersion : String;
};

type Document.Information.Extraction_types.Defaultextractor {
  fieldName : String;
};

type Document.Information.Extraction_types.MetadataCoordinates {
  x : Decimal;
  y : Decimal;
  w : Decimal;
  h : Decimal;
};

type Document.Information.Extraction_types.Formatting {
  length : String;
  precision : String;
  decimalSeparator : String;
  thousandSeparator : String;
};

type Document.Information.Extraction_types.UpdateSchema {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema has been updated successfully.'
  message : String;
};

type Document.Information.Extraction_types.SchemaVersionCreated {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2'
  version : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26T17:00:00.000000+00:00'
  created : Date;
};

type Document.Information.Extraction_types.SchemaCapabilities {
  @description : 'Document types supported for Schemas'
  documentTypes : many String;
  @description : 'States of Schemas'
  state : many String;
  setupTypes : Document.Information.Extraction.anonymous.type20;
  formatting : Document.Information.Extraction.anonymous.type21;
};

type Document.Information.Extraction_types.SingleFormat {
  name : String;
  properties : many String;
};

type Document.Information.Extraction_types.SingleFormat1 {
  name : String;
  properties : Document.Information.Extraction_types.SingleFormatProperty;
};

type Document.Information.Extraction_types.SingleFormatProperty {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'dateformat'
  name : String;
  values : many String;
};

type Document.Information.Extraction_types.DeleteVersion {
  version : many Document.Information.Extraction.anonymous.type22;
};

type Document.Information.Extraction_types.SchemaVersionListed {
  schemas : many Document.Information.Extraction.anonymous.type23;
};

type Document.Information.Extraction_types.DeleteSchemaVersion {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema versions deleted successfully.'
  message : String;
};

type Document.Information.Extraction_types.SchemaVersionDetail {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Custom_Payment_Advice_Schema'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema For Accounts Department Payment Advices'
  schemaDescription : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'paymentAdvice'
  documentType : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Payment Advice with Order Number'
  documentTypeDescription : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '893bc685-9a00-43dd-baf4-32e5752b9a0c'
  id : String;
  predefined : Boolean;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2'
  version : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2024-02-26T03:52:50.773409+00:00'
  created : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2024-02-26T03:52:50.773413+00:00'
  updated : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'active'
  state : String;
  @description : 'Headerfields of a schema'
  headerFields : many Document.Information.Extraction_types.Field;
  @description : 'Lineitems of a schema'
  lineItemFields : many Document.Information.Extraction_types.Field;
};

type Document.Information.Extraction_types.SchemaFields {
  @description : 'Headerfields of a schema'
  headerFields : many Document.Information.Extraction_types.Field;
  @description : 'Lineitems of a schema'
  lineItemFields : many Document.Information.Extraction_types.Field;
};

type Document.Information.Extraction_types.FieldsSchemaVersion {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema fields have been uploaded successfully.'
  message : String;
};

type Document.Information.Extraction_types.ActivateSchemaVersion {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema version activated successfully.'
  message : String;
};

type Document.Information.Extraction_types.DeactivateSchemaVersion {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema version deactivated successfully.'
  message : String;
};

type Document.Information.Extraction_types.TemplateActivateActionResponseV2 {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully activated the template'
  message : String;
};

type Document.Information.Extraction_types.TemplateDeActivateActionResponseV2 {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully deactivated the template'
  message : String;
};

type Document.Information.Extraction_types.MetaDataFields {
  metadata : many Document.Information.Extraction_types.Key_value_pair;
};

type Document.Information.Extraction_types.Key_value_pair {
  name : String;
  value : String;
  extraction : String;
  isLineItemField : String;
};

type Document.Information.Extraction_types.TemplatePostMetadataResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'e0ec84e3-49b0-4b08-aa7f-8d696472c248'
  id : String(36);
};

type Document.Information.Extraction_types.PostTemplatePayload_v2 {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '86930543-0f21-4426-a2d8-ef6064cee64c'
  id : String(36);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Test_Template'
  name : String(50);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Test description'
  description : String(100);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String(128);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '86930543-0f21-4426-a2d8-ef6064cee64c'
  schemaId : String(36);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '1'
  schemaVersion : String;
};

type Document.Information.Extraction_types.BadRequestTemplateGetErrorError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E31'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Template not found.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.GetTemplateV2 {
  results : many Document.Information.Extraction.anonymous.type24;
};

type Document.Information.Extraction_types.GetTemplateResult {
  id : String;
  schemaId : String;
  name : String;
  description : String;
  language : String;
  documentType : String;
  clientId : String;
  status : String;
  isActive : Boolean;
  creationDate : Date;
  lastUpdatedDate : Date;
  schemaName : String;
  documentAssociations : many Document.Information.Extraction_types.GetDocumentIds;
  extraction : Document.Information.Extraction_types.GetExtractionField;
};

type Document.Information.Extraction_types.GetDocumentIds {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '7dc93514-bbff-428f-8c49-d07ce3aabbdb'
  id : String;
};

type Document.Information.Extraction_types.GetExtractionField {
  headerFields : many Document.Information.Extraction_types.GetHeaderFields;
  lineItemFields : many Document.Information.Extraction_types.GetLineItemFields;
};

type Document.Information.Extraction_types.GetHeaderFields {
  name : String;
  label : String;
  type : String;
};

type Document.Information.Extraction_types.GetLineItemFields {
  name : String;
  label : String;
  type : String;
};

type Document.Information.Extraction_types.BadRequestTemplateNotCreatedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E27'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Could not create template.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.PostTemplateResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'aa0fa4bf-cc50-4031-8fc1-f1fb6b65b6bf'
  id : String(36);
};

type Document.Information.Extraction_types.DeleteAddedDocumentResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully removed document from the template.'
  message : String;
};

type Document.Information.Extraction_types.DocumentAddResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully added document to the template.'
  message : String;
};

type Document.Information.Extraction_types.GetTemplateDetails_V2 {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '86930543-0f21-4426-a2d8-ef6064cee64c'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'e8998fe1-1f6b-40d3-850d-8c21ff6397a5'
  schemaId : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Test Template'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Test Template Description'
  description : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'en'
  language : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'invoice'
  documentType : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'NO_SAMPLES'
  status : String;
  isActive : Boolean;
  creationDate : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2024-07-02T12:08:11.664728+00:00'
  lastUpdatedDate : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'SAP_Schema'
  schemaName : String;
  documentAssociations : many Document.Information.Extraction_types.GetDocumentIds;
  extraction : Document.Information.Extraction_types.GetExtractionField;
};

type Document.Information.Extraction_types.DeleteTemplateV2 {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully deleted 1 template.'
  message : String;
};

type Document.Information.Extraction_types.PageDimensions {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 1200
  width : Integer;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 2460
  height : Integer;
};

type Document.Information.Extraction_types.PagesDimensionsResults {
  @openapi.name : '1'
  _1 : Document.Information.Extraction_types.PageDimensions;
  @openapi.name : '2'
  _2 : Document.Information.Extraction_types.PageDimensions;
  @openapi.name : '3'
  _3 : Document.Information.Extraction_types.PageDimensions;
};

type Document.Information.Extraction_types.PagesDimensions {
  results : Document.Information.Extraction_types.PagesDimensionsResults;
};

type Document.Information.Extraction_types.DocumentIdInReview {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Document marked for review.'
  message : String;
};

type Document.Information.Extraction_types.DocumentIdReviewed {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Document marked as reviewed.'
  message : String;
};

type Document.Information.Extraction_types.provider_subaccount {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<subaccount_id>'
  subaccount_id : String;
};

type Document.Information.Extraction_types.sbf_context {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<instance_name>'
  instance_name : String;
  provider : Document.Information.Extraction_types.provider_subaccount;
};

type Document.Information.Extraction_types.user_parameters {
  @openapi.name : 'cmk-support'
  cmk_support : Boolean;
};

type Document.Information.Extraction_types.tenantEventRequest {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<global_account_id>'
  global_account_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<zone_id>'
  zone_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<instance_id>'
  instance_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<subaccount_id>'
  subaccount_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<plan_name>'
  plan_name : String(30);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<plan_id>'
  plan_id : String(36);
  context : Document.Information.Extraction_types.sbf_context;
  parameters : Document.Information.Extraction_types.user_parameters;
};

type Document.Information.Extraction_types.tenantDeleteRequest {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<zone_id>'
  zone_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<instance_id>'
  instance_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<subaccount_id>'
  subaccount_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<plan_name>'
  plan_name : String(30);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<plan_id>'
  plan_id : String(36);
};

type Document.Information.Extraction_types.tenantUpdateRequest {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<global_account_id>'
  global_account_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<zone_id>'
  zone_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<instance_id>'
  instance_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<subaccount_id>'
  subaccount_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<plan_name>'
  plan_name : String(30);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<plan_id>'
  plan_id : String(36);
};

type Document.Information.Extraction_types.tenantStatusRequest {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<zone_id>'
  zone_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<instance_id>'
  instance_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '<subaccount_id>'
  subaccount_id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'provisioning'
  operation_name : String;
};

type Document.Information.Extraction_types.Instance {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'sample_instance_id'
  id : String(36);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'sample_instance_id'
  name : String(100);
};

type Document.Information.Extraction_types.BadRequestDataExportFailedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E5'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Failed to retrieve data.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.BadRequestExportJobRetrieveFailedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E5'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Failed to retrieve data.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.PostExportJobPayload {
  tenantIds : many Document.Information.Extraction.anonymous.type25;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2022-01-01'
  startDate : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2022-01-31'
  endDate : String;
};

type Document.Information.Extraction_types.ListedDataExportJobs {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c1673dee-56d6-4960-9a36-c29529f04b4a'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26 17:00:00.000000+00:00'
  created : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26 17:02:00.000000+00:00'
  finished : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '0:00:00.134951'
  processedTime : String;
  tenantIds : many Document.Information.Extraction.anonymous.type26;
};

type Document.Information.Extraction_types.GetDataExportJobsResult {
  results : many Document.Information.Extraction.anonymous.type27;
};

type Document.Information.Extraction_types.DataExportJobExportedTenants {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 12
  @openapi.name : 'ab67a0e4-f510-4882-b89f-a69090bf969f'
  ab67a0e4_f510_4882_b89f_a69090bf969f : Integer;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 10
  @openapi.name : 'cd64a1e4-j091-0938-b89f-a30980bf029h'
  cd64a1e4_j091_0938_b89f_a30980bf029h : Integer;
};

type Document.Information.Extraction_types.DataExportJobExportedDocs {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 22
  totalDocuments : Integer;
  tenantIds : Document.Information.Extraction_types.DataExportJobExportedTenants;
};

type Document.Information.Extraction_types.DataExportJobPayload {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c1673dee-56d6-4960-9a36-c29529f04b4a'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26 17:00:00.000000+00:00'
  created : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2020-03-26 17:02:00.000000+00:00'
  finished : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '0:00:00.134951'
  processedTime : String;
  exportedDocuments : Document.Information.Extraction_types.DataExportJobExportedDocs;
};

type Document.Information.Extraction_types.GetDataExportJob {
  value : Document.Information.Extraction_types.DataExportJobPayload;
};

type Document.Information.Extraction_types.UpdateTrainingState {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c1673dee-56d6-4960-9a36-c29529f04b4a'
  tenantId : String;
  documents : many Document.Information.Extraction.anonymous.type28;
};

type Document.Information.Extraction_types.ocr {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'scene_text_recognition'
  ocr_engine : String;
};

type Document.Information.Extraction_types.settings {
  ocr : Document.Information.Extraction.anonymous.type29;
};

type Document.Information.Extraction_types.SchemaUpdation {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Custom_Payment_Advice_Schema'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema For Accounts Department Payment Advices'
  schemaDescription : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Payment Advice with Order Number'
  documentTypeDescription : String;
};

type Document.Information.Extraction_types.ActivateSchema {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema activated successfully.'
  message : String;
};

type Document.Information.Extraction_types.DeactivateSchema {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema deactivated successfully.'
  message : String;
};

type Document.Information.Extraction_types.FieldsSchema {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema fields have been uploaded successfully.'
  message : String;
};

type Document.Information.Extraction_types.SchemaCategory {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'ShipmentAddress'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Shipment Address details'
  description : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Shipment Address'
  label : String;
};

type Document.Information.Extraction_types.SchemaCategoryUpdateResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema Category has been updated successfully.'
  message : String;
};

type Document.Information.Extraction_types.SchemaCategoryDeleteResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Schema Categories has been deleted successfully.'
  message : String;
};

type Document.Information.Extraction_types.SchemaCategoryModel {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'ShipmentAddress'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Shipment Address details'
  description : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Shipment Address'
  label : String;
};

type Document.Information.Extraction_types.SchemaCategoryUpdate {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'ShipmentAddress'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Shipment Address details'
  description : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Shipment Address'
  label : String;
};

type Document.Information.Extraction_types.SchemaCategoryBulkCreationModel {
  value : many Document.Information.Extraction.anonymous.type30;
};

type Document.Information.Extraction_types.SchemaCategoryCreated {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '1'
  inserted : String;
};

type Document.Information.Extraction_types.DeleteSchemaCategory {
  value : many Document.Information.Extraction.anonymous.type31;
};

type Document.Information.Extraction_types.SingleMetadata {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'ml'
  name : String;
  properties : many String;
};

type Document.Information.Extraction_types.PostTemplatePayload {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '7cb792b9-e470-4c37-ba1d-1164c6ecc577'
  id : String(36);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Test_Template'
  name : String(50);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Test description'
  description : String(100);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String(128);
};

type Document.Information.Extraction_types.DeleteTemplatePayload {
  value : many Document.Information.Extraction.anonymous.type32;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String;
};

type Document.Information.Extraction_types.DeleteTemplate {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully deleted 1 template.'
  message : String;
};

type Document.Information.Extraction_types.GetTemplate {
  results : many Document.Information.Extraction.anonymous.type33;
};

type Document.Information.Extraction_types.GetTemplateDetails {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '7cb792b9-e470-4c37-ba1d-1164c6ecc577'
  id : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '4673cc43-c9f6-46e5-8299-8e9bed43d131'
  schemaId : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Test Template'
  name : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Test Template Description'
  description : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'en'
  language : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'invoice'
  documentType : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'NO_SAMPLES'
  status : String;
  isActive : Boolean;
  creationDate : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '2024-07-02T12:08:11.663815+00:00'
  lastUpdatedDate : Date;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'SAP_Schema'
  schemaName : String;
  extraction : Document.Information.Extraction_types.GetExtractionField;
};

type Document.Information.Extraction_types.SampleDocumentMapping {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Template UUID'
  templateId : String(36);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Sample Document UUID'
  sampleDocumentId : String(36);
};

type Document.Information.Extraction_types.SampleSatusModel {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  id : String(36);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'DONE'
  status : String;
};

type Document.Information.Extraction_types.SampleDocumentList {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  templateId : String(36);
  sampleDocuments : many Document.Information.Extraction_types.SampleSatusModel;
};

type Document.Information.Extraction_types.SampleDocumentAnnotation {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'documentNumber'
  name : String(100);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '12342'
  value : String;
  coordinates : Document.Information.Extraction.anonymous.type34;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 1
  page : String;
};

type Document.Information.Extraction_types.SampleDocumentAnnotations {
  headerFields : many Document.Information.Extraction_types.SampleDocumentAnnotation;
  lineItems : many Document.Information.Extraction.anonymous.type35;
};

type Document.Information.Extraction_types.SampleDocument {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  templateId : String(36);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '484b6e1c-501c-4a07-85cb-84554656a175'
  sampleDocumentId : String(36);
  annotations : Document.Information.Extraction_types.SampleDocumentAnnotations;
};

type Document.Information.Extraction_types.SampleDocumentDetailsResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully added annotations'
  message : String;
};

type Document.Information.Extraction_types.TemplateActivateActionResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully activated the template'
  message : String;
};

type Document.Information.Extraction_types.TemplateDeActivateActionResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully deactivated the template'
  message : String;
};

type Document.Information.Extraction_types.SampleDocumentAnnotationList {
  annotations : Document.Information.Extraction_types.SampleDocumentAnnotations;
};

type Document.Information.Extraction_types.BadRequestTemplateFieldsGetErrorError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E32'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Template fields not found.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.GetTemplateFieldsResult {
  templateId : String;
  name : String;
  label : String;
  type : String;
};

type Document.Information.Extraction_types.GetTemplateFields {
  results : many Document.Information.Extraction.anonymous.type36;
};

type Document.Information.Extraction_types.DeleteTemplateFields {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Successfully deleted template field(s).'
  message : String;
};

type Document.Information.Extraction_types.PostHeaderFields {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Template_UUID1'
  templateId : String(36);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'grossAmount'
  name : String(100);
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'amount'
  label : String(64);
  type : String(16);
};

type Document.Information.Extraction_types.PostHeaderFieldsPayload {
  Payload : many Document.Information.Extraction_types.PostHeaderFields;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c_00'
  clientId : String(128);
};

type Document.Information.Extraction_types.PostTemplateFieldsResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Template fields successfully saved.'
  message : String;
};

type Document.Information.Extraction_types.BadRequestTemplateFieldNotSavedError {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'E34'
  code : String;
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Could not save template fields.'
  message : String;
  details : String;
};

type Document.Information.Extraction_types.GetSampleDocumentsResult {
  @description : 'List of sample documents'
  results : many Document.Information.Extraction_types.ListedDocument;
};

type Document.Information.Extraction_types.DeleteSampleDocumentStatusMessage {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'Documents deleted successfully.'
  message : String;
};

@description : 'List of rules can be retrieved by GET /rules, copy single object to adapt it via POST'
type Document.Information.Extraction_types.Key_value_pair_rules { };

type Document.Information.Extraction_types.CreateRules {
  value : Document.Information.Extraction_types.Key_value_pair_rules;
};

type Document.Information.Extraction_types.GetRulesResponse {
  results : many Document.Information.Extraction_types.Key_value_pair_rules;
};

type Document.Information.Extraction_types.DeleteRuleRequest {
  value : many Document.Information.Extraction.anonymous.type37;
};

type Document.Information.Extraction_types.DeleteRuleResponse {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 1
  deleted : Integer;
};

type Document.Information.Extraction_types.GetDeletedDocumentsClientDetail {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : 'c00'
  clientId : String;
  documents : many Document.Information.Extraction.anonymous.type38;
};

type Document.Information.Extraction_types.GetDeletedDocumentsTenantDetail {
  @Core.Example.$Type : 'Core.PrimitiveExampleValue'
  @Core.Example.Description : '4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
  tenantId : String;
  clients : many Document.Information.Extraction_types.GetDeletedDocumentsClientDetail;
};

type Document.Information.Extraction_types.GetDeletedDocuments {
  tenants : many Document.Information.Extraction_types.GetDeletedDocumentsTenantDetail;
};

type Document.Information.Extraction_types.ConfirmDeletedDocuments {
  successfulDeletedDocuments : many Document.Information.Extraction.anonymous.type39;
  documentsNotInDeletedState : many Document.Information.Extraction.anonymous.type40;
};

type Document.Information.Extraction_types.InitalLoad {
  notExistingDocuments : many Document.Information.Extraction.anonymous.type41;
};

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : 'c_00'
type Document.Information.Extraction.anonymous.type0 : String;

@description : 'Client information'
type Document.Information.Extraction.anonymous.type1 : Document.Information.Extraction_types.Client { };

@description : 'Client information'
type Document.Information.Extraction.anonymous.type2 : Document.Information.Extraction_types.Client { };

@description : ```
Must be a predefined key from the following list: ['performPIICheck',
 'clientSegregation',
 'manualDataActivation',
 'coordinateFormat',
 'activateDocumentNotifications',
 'dataFeedbackCollection',
 'documentRetentionTimeDays',
 'enrichmentConfidenceThreshold']
```
@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : 'example_key_1'
type Document.Information.Extraction.anonymous.type3 : String;

type Document.Information.Extraction.anonymous.type4 : many { };

type Document.Information.Extraction.anonymous.type5 : Document.Information.Extraction_types.FieldCoordinates { };

type Document.Information.Extraction.anonymous.type6 : Document.Information.Extraction_types.FieldCoordinates { };

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
type Document.Information.Extraction.anonymous.type7 : String;

@description : 'List of documents'
type Document.Information.Extraction.anonymous.type8 : Document.Information.Extraction_types.ListedDocument { };

@description : 'List of documents'
type Document.Information.Extraction.anonymous.type9 : Document.Information.Extraction_types.ListedDocument { };

@description : 'List of filtering/ordering options'
type Document.Information.Extraction.anonymous.type10 : Document.Information.Extraction_types.DocumentCatalogOptions { };

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '...'
type Document.Information.Extraction.anonymous.type11 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
type Document.Information.Extraction.anonymous.type12 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
// @Core.Example.Description : '{
//   // id: 'BE0001',
//   // name: 'A',
//   // accountNumber: '12345',
//   // address1: 'A street 5',
//   // address2: '',
//   // city: 'Heidelberg',
//   // countryCode: 'DE',
//   // postalCode: '69117',
//   // state: 'BW',
//   // email: 'a@a.com',
//   // phone: '',
//   // bankAccount: '000001',
//   // taxId: '999',
//   // companyCode: '4711',
//   // system: 'System A'
// }'
type Document.Information.Extraction.anonymous.type13 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : 'ab67a0e4-f510-4882-b89f-a69090bf969f'
type Document.Information.Extraction.anonymous.type14 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
type Document.Information.Extraction.anonymous.type15 : String;

type Document.Information.Extraction.anonymous.type16 : Document.Information.Extraction_types.SchemaAttributes { };

type Document.Information.Extraction.anonymous.type17 : Document.Information.Extraction_types.Defaultextractor { };

type Document.Information.Extraction.anonymous.type18 : Document.Information.Extraction_types.MetadataCoordinates { };

type Document.Information.Extraction.anonymous.type19 : Document.Information.Extraction_types.Formatting { };

@description : 'Format Supported with format properties for Schema'
type Document.Information.Extraction.anonymous.type20 : Document.Information.Extraction_types.SingleFormat { };

@description : 'Format Supported with format properties for Schema'
type Document.Information.Extraction.anonymous.type21 : Document.Information.Extraction_types.SingleFormat1 { };

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '5'
type Document.Information.Extraction.anonymous.type22 : String;

type Document.Information.Extraction.anonymous.type23 : Document.Information.Extraction_types.SchemaAttributes { };

@description : 'List of templates'
type Document.Information.Extraction.anonymous.type24 : Document.Information.Extraction_types.GetTemplateResult;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '1234'
type Document.Information.Extraction.anonymous.type25 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : 'ab67a0e4-f510-4882-b89f-a69090bf969f'
type Document.Information.Extraction.anonymous.type26 : String;

@description : 'List of data export jobs'
type Document.Information.Extraction.anonymous.type27 : Document.Information.Extraction_types.ListedDataExportJobs { };

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : 'ab67a0e4-f510-4882-b89f-a69090bf969f'
type Document.Information.Extraction.anonymous.type28 : String;

type Document.Information.Extraction.anonymous.type29 : Document.Information.Extraction_types.ocr { };

@description : 'Category details'
type Document.Information.Extraction.anonymous.type30 : Document.Information.Extraction_types.SchemaCategoryModel { };

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : 'senderName, ShipmentAddress'
type Document.Information.Extraction.anonymous.type31 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '4da67643-4d0a-4cf6-8fde-0aaf15fe83a0'
type Document.Information.Extraction.anonymous.type32 : String;

@description : 'List of templates'
type Document.Information.Extraction.anonymous.type33 : Document.Information.Extraction_types.GetTemplateResult;

type Document.Information.Extraction.anonymous.type34 : Document.Information.Extraction_types.FieldCoordinates { };

type Document.Information.Extraction.anonymous.type35 : many Document.Information.Extraction_types.SampleDocumentAnnotation;

@description : 'List of templates fields'
type Document.Information.Extraction.anonymous.type36 : Document.Information.Extraction_types.GetTemplateFieldsResult { };

@description : 'Name of the rule to delete'
@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : 'custom_rule_name'
type Document.Information.Extraction.anonymous.type37 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
type Document.Information.Extraction.anonymous.type38 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
type Document.Information.Extraction.anonymous.type39 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '1236cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
type Document.Information.Extraction.anonymous.type40 : String;

@Core.Example.$Type : 'Core.PrimitiveExampleValue'
@Core.Example.Description : '4476cc01-72f3-4b64-9eb0-cdd9c1cb27ff'
type Document.Information.Extraction.anonymous.type41 : String;

type Document.Information.Extraction.types.documentWithFilePost {

  @description: 'file to upload. Only pass this parameter if document is created with a file(word files, vds, images etc.) For link type file, pass link as string parameter.'
  file : LargeBinary;
                                           
  @description: 'name of the file. Only pass this parameter if document is created with a file(word files, vds, images etc.) For link type file, pass title as string parameter.'
  options : String;

}

