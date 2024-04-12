import ballerina/http;
import defect.datasource;

datasource:Client db_client = check new;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    resource function post defects(@http:Payload Issue an_issue) returns http:Ok|error {
      stream<datasource:Issue, error?> issues = db_client -> /issues();
      check db_client -> issues.post([an_issue]);
      return http:Ok;
    }

}
