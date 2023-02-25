@Mopay @Maintenance
Feature: Mopay - Money Transafer Payout

  Background:
    Given def wcUrl = "https://api.onep-core.qawesternunion.com/ordrwcvs/qa/v1/ord/orderItems/retail/willCallStore"
    * def mopayUrl = "https://api.onep-core.qawesternunion.com/ordmopyt/qa/v1/ord/payout/mopay"
    * def callToken = callonce read("classpath:com/callableFiles/orderItems/token.feature")
    * configure headers = { Authorization: '#(callToken.token)',Content-Type: '#(Type)',x-api-key:'#(key)' ,x-apigw-api-id:'#(id)'}
    * def vreq = read("classpath:com/requests/orderItems/wcstox-vv.json")
    * def sreq = read("classpath:com/requests/orderItems/wcstox-vs.json")
    * def mreq = read("classpath:com/requests/orderItems/mopay.json")
    * call read("classpath:com/Common.feature")
    * def senderName = randomName(5)
    * def mtcn = randomNumber(10)
    * def sleep = function(millis){ java.lang.Thread.sleep(millis) }

  @MopayGalaticID
  Scenario Outline: <TestCaseName>
    Given url wcUrl
    * print mtcn
    * request vreq
    * set vreq.mocn = mtcn
    * set vreq.senderDetails.senderName = "BHARGAV\\" + senderName
    * set vreq.agentDetails.acctNbr = "<agentAcctNbr>"
    * set vreq.mtcn = "230408" + mtcn
    When method put
    Then status 200
    * print response
    Given request sreq
    * set sreq.mocn = mtcn
    * set sreq.senderDetails.senderName = "BHARGAV\\" + senderName
    * set sreq.agentDetails.acctNbr = "<agentAcctNbr>"
    * set sreq.mtcn = "230408" + mtcn
    * sleep(2000)
    When method put
    Then status 200
    * print response
    Given url mopayUrl
    * request mreq
    * set mreq.mocn = mtcn
    * set mreq.agentAccountNumber = "<RecAgentAcctNbr>"
    * set mreq.mtcn = "230408" + mtcn
    * set mreq.galaticId = "<galaticId>"
    * print mreq
    * sleep(3000)
    When method post
    Then status <Status>
    * print response
    * if (responseStatus == 400) karate.call("classpath:com/Assertions.feature@galaticErrorValidation")
    Examples: Test Data Master
      | read("classpath:com/testDataFiles/orderItems/MopayGalaticID.csv") |

  @test
  Scenario Outline: <TestCaseName>
    Given  url wcUrl
    * request vreq
    * set vreq.mocn = mtcn
    * set vreq.senderDetails.senderName = "BHARGAV\\" + senderName
    * set vreq.agentDetails.acctNbr = "<agentAcctNbr>"
    * set vreq.mtcn = "230408" + mtcn
    When method put
    Then status 200
    * print response
    Given request sreq
    * set sreq.mocn = mtcn
    * set sreq.senderDetails.senderName = "BHARGAV\\" + senderName
    * set sreq.agentDetails.acctNbr = "<agentAcctNbr>"
    * set sreq.mtcn = "230408" + mtcn
    When method put
    Then status 200
    * print mtcn
    * print response
    Given url mopayUrl
    * request mreq
    * set mreq.mocn  = mtcn
    * set mreq.agentAccountNumber = "<RecAgentAcctNbr>"
    * set mreq.mtcn  = "230408" + mtcn
    * print sreq
    * sleep(1000)
    # When method post
    #Then status 200
    #* print response
    Examples: Test Data Master
      | TestCaseName | agentAcctNbr | RecAgentAcctNbr |
      | Sanity       | A16084389    | ADA383089       |