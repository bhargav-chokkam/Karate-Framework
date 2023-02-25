@Mopay @Maintenance
Feature: Mopay - Money Transafer Payout

    Background:
        Given def wcUrl = "https://api.onep-core.qawesternunion.com/ordrwcvs/qa/v1/ord/orderItems/retail/willCallStore"
        * def ipschxUrl = "https://api.onep-core.qawesternunion.com/ordippyt/qa/v1/ord/orderItems/payout/ipschx"
        * def callToken = callonce read("classpath:com/callableFiles/orderItems/token.feature")
        * configure headers = { Authorization: '#(callToken.token)',Content-Type: '#(Type)',x-api-key:'#(key)',x-apigw-api-id:'#(id)'}
        * def vreq = read("classpath:com/requests/orderItems/wcstox-vv.json")
        * def sreq = read("classpath:com/requests/orderItems/wcstox-vs.json")
        * def ipreq = read("classpath:com/requests/orderItems/payout-ipschx.json")
        * call read("classpath:com/Common.feature")
        * def senderName = randomName(5)
        * def mtcn = randomNumber(10)
        * def sleep = function(millis){ java.lang.Thread.sleep(millis) }

    @IPSCHKGalaticID
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
        * sleep(2000)
        When method put
        Then status 200
        * print mtcn
        * print response
        Given url ipschxUrl
        * request ipreq
        * set ipreq.agentAccountNumber = "<RecAgentAcctNbr>"
        * set ipreq.mocn = mtcn
        * set ipreq.galaticId = "<galaticId>"
        * set ipreq.mtcn = "230408" + mtcn
        * sleep(2000)
        When method post
        Then status <Status>
        * print response
        * if (responseStatus == 400) karate.call("classpath:com/Assertions.feature@galaticErrorValidation")
        Examples: Test Data Master
            | read("classpath:com/testDataFiles/orderItems/IPSCHKGalaticID.csv") |

    @IPSCHKGalaticIDNull
    Scenario Outline: <TestCaseName>
        Given url wcUrl
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
        * print mtcn
        * print response
        Given url ipschxUrl
        * request ipreq
        * set ipreq.agentAccountNumber = "<RecAgentAcctNbr>"
        * set ipreq.mocn = mtcn
        * set ipreq.mtcn = "230408" + mtcn
        * sleep(2000)
        * print ipreq.galaticId
        When method post
        Then status 400
        * print response
        * if (responseStatus == 400) karate.call("classpath:com/Assertions.feature@galaticErrorValidation")
        Examples: Test Data Master
            | TestCaseName | agentAcctNbr | RecAgentAcctNbr |
            | Sanity       | A16084389    | ADA383089       |