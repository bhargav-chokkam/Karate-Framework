@Retail-WillCallStore @Maintenance
Feature: WillCall Store

  Background:
    Given def baseUrl = "https://api.onep-core.qawesternunion.com/ordrwcvs/qa/v1/ord/orderItems/retail/willCallStore"
    And def callToken = callonce read("classpath:com/callableFiles/orderItems/token.feature")
    And configure headers = { Authorization: '#(callToken.token)',Content-Type: '#(Type)',x-api-key:'#(key)' ,x-apigw-api-id:'#(id)'}
    * def vreq = read("classpath:com/requests/orderItems/wcstox-vv.json")
    * def sreq = read("classpath:com/requests/orderItems/wcstox-vs.json")
    And call read("classpath:com/Common.feature")
    And def senderName = randomName(5)
    And def mtcn = randomNumber(10)

  Scenario: <TestCase>
    Given url baseUrl
    And request vreq
    And set vreq.mocn = mtcn
    And set vreq.senderDetails.senderName = "BHARGAV\\" + senderName
    And set vreq.agentDetails.acctNbr = agentAcctNbr
    And set vreq.mtcn = "230408" + mtcn
    When method put
    Then status 200
    Then print response
    And request sreq
    And set sreq.mocn = mtcn
    And set sreq.senderDetails.senderName = "BHARGAV\\" + senderName
    And set sreq.agentDetails.acctNbr = agentAcctNbr
    And set sreq.mtcn = "230408" + mtcn
    When method put
    Then status 200
    Then print mtcn
    Then print response