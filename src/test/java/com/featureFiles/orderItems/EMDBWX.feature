@EMDBWX @Maintenance
Feature: WillCall Store

    Background:
        Given def baseUrl = "https://api.onep-core.qawesternunion.com/ordrwcvs/qa/v1/ord/orderItems/retail/willCallStore"
        * def callToken = callonce read("classpath:com/callableFiles/orderItems/token.feature")
        * configure headers = { Authorization: '#(callToken.token)',Content-Type: '#(Type)',x-api-key:'#(key)' ,x-apigw-api-id:'#(id)'}
        * def vreq = read("classpath:com/requests/orderItems/emdbwx-vv.json")
        * def sreq = read("classpath:com/requests/orderItems/emdbwx-vs.json")
        * call read("classpath:com/Common.feature")
        * def senderName = randomName(5)
        * def mtcn = randomNumber(10)
        * def sleep = function(millis){ java.lang.Thread.sleep(millis) }

    @EMDBWXGalacticID
    Scenario Outline: <TestCase>
        Given url baseUrl
        * request vreq
        * set vreq.mocn = mtcn
        * set vreq.senderDetails.senderName = "BHARGAV\\" + senderName
        * set vreq.mtcn = "230408" + mtcn
        When method put
        Then status 200
        * print response
        Given request sreq
        * set sreq.generalInfo.mocn = mtcn
        * set sreq.generalInfo.sender.senderName = "BHARGAV\\" + senderName
        * set sreq.generalInfo.mtcn = "230408" + mtcn
        * set sreq.generalInfo.galacticUB = "<galaticID>"
        * set sreq.generalInfo.validationIndicator = "<validationInd>"
        * sleep(3000)
        When method put
        Then status <Status>
        * print response
        * if (responseStatus == 400) karate.call("classpath:com/Assertions.feature@galaticErrorValidation")
        Examples: Test Data Master
            | read("classpath:com/testDataFiles/orderItems/EMDBWXGalacticID.csv") |