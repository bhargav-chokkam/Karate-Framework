@Retail-QuickCollectStore @Maintenance
Feature: WillCall Store

  Background:
    Given def baseUrl = "https://api.onep-core.qawesternunion.com/ordrqcvs/qa/v1/ord/orderItems/retail/quickCollectStore"
    And def callToken = callonce read("classpath:com/callableFiles/orderItems/token.feature")
    And configure headers = { Authorization: '#(callToken.token)',Content-Type: '#(Type)',x-api-key:'#(key)' ,x-apigw-api-id:'#(id)'}
    And call read("classpath:com/Common.feature")
    And def lastName = randomName(5)
    And def mtcn = randomNumber(10)
    And def vreq = read("classpath:com/requests/orderItems/qccstx-vv.json")
    * def sreq = read("classpath:com/requests/orderItems/qccstx-vs.json")

  @QuickCollectGalaticID
  Scenario Outline: <TestCaseName>
    Given url baseUrl
    And request vreq
    And set vreq.origCodeCity = "<CodeCity>"
    And set vreq.origCompany = "<Company>"
    And set vreq.clientAccount = "<clientAccount>"
    And set vreq.agentDetails.account = "<agentAccount>"
    And set vreq.receiverDetails.payeeName = "\\" + "<Company>"
    And set vreq.receiverDetails.payeeCity = "<CodeCity>"
    And set vreq.senderDetails.senderName = "BHARGAV\\" + lastName
    And set vreq.mocn = mtcn
    And print vreq
    When method put
    Then status 200
    Then print response
    Given request sreq
    And set sreq.origCodeCity = "<CodeCity>"
    And set sreq.origCompany = "<Company>"
    And set sreq.clientAccount = "<clientAccount>"
    And set sreq.agentDetails.account = "<agentAccount>"
    And set sreq.receiverDetails.payeeName = "\\" + "<Company>"
    And set sreq.receiverDetails.payeeCity = "<CodeCity>"
    And set sreq.senderDetails.senderName = "BHARGAV\\" + lastName
    And set sreq.mocn = mtcn
    And set sreq.galacticUB = "<galaticID>"
    And set sreq.validationInd = "<validationInd>"
    And print sreq
    When method put
    Then status <Status>
    Then print response
    Then if (responseStatus == 400) karate.call("classpath:com/Assertions.feature@galaticErrorValidation")
    Examples: Test Data Master
      | read("classpath:com/testDataFiles/orderItems/QuickCollectGalaticID.csv") |

  @USWalltetQQC
  Scenario: <TestCaseName>
    Given url baseUrl
    And request vreq
    And set vreq.senderDetails.senderName = "BHARGAV\\" + lastName
    And set vreq.mocn = mtcn
    And print vreq
    When method put
    Then status 200
    Then print response
    Given request sreq
    And set sreq.senderDetails.senderName = "BHARGAV\\" + lastName
    And set sreq.mocn = mtcn
    And print sreq
    When method put
    Then status 200
    Then print response