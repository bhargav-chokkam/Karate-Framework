@Limits @Maintenance
Feature: Limits - Based on country

    Background:
        Given def wcUrl = "https://api.onep-core.qawesternunion.com/ordrwcvs/qa/v1/ord/orderItems/retail/willCallStore"
        * def limitsUrl = "https://api.onep-core.qawesternunion.com/ordlimit/qa/v1/ord/orderItems/limitCheck"
        * def callToken = callonce read("classpath:com/callableFiles/orderItems/token.feature")
        * configure headers = { Authorization: '#(callToken.token)',Content-Type: '#(Type)',x-api-key:'#(key)' ,x-apigw-api-id:'#(id)'}
        * def vreq = read("classpath:com/requests/orderItems/wcstox-vv.json")
        * def sreq = read("classpath:com/requests/orderItems/wcstox-vs.json")
        * def lreq = read("classpath:com/requests/orderItems/limits.json")
        * def ltreq = read("classpath:com/requests/orderItems/limits-trimmed.json")
        * call read("classpath:com/Common.feature")
        * def senderName = randomName(5)
        * def mtcn = randomNumber(16)
        * def customerNumber = randomNumber(9)
        * def sleep = function(millis){ java.lang.Thread.sleep(millis) }

    @LimitsMasterValidation
    Scenario Outline: Test: <Country> - NewRulesDef: <NewRulesDef> - idFlag: <idFlag>
        Given url limitsUrl
        * def NewRulesDef = "<NewRulesDef>"
        * def idFlag = "<idFlag>"
        * request lreq
        * set lreq.prefferedCustomerNumber = customerNumber
        * set lreq.preferredSenderCountry = "<Country>"
        * set lreq.destinationCountry = "<Country>"
        * set lreq.idFlag = "<idFlag>"
        When method post
        Then status 200
        * def VerifiedRepeat = "<VerifiedRepeat>"
        * def UnVerifiedNew = "<UnVerifiedNew>"
        * def UnVerifiedRepeat = "<UnVerifiedRepeat>"
        * match response.countryIdTransactionLimit == "00" +"<IDReqdTrans>"
        * if (NewRulesDef == "A" && idFlag == "Y") karate.call("classpath:com/Assertions.feature@NewRulesDef_A_idFlag_Y")
        * if (NewRulesDef == "A" && idFlag == "N") karate.call("classpath:com/Assertions.feature@NewRulesDef_A_idFlag_N")
        * if (NewRulesDef == "Y" && idFlag == "Y") karate.call("classpath:com/Assertions.feature@NewRulesDef_Y_idFlag_Y")
        * if (NewRulesDef == "Y" && idFlag == "N") karate.call("classpath:com/Assertions.feature@NewRulesDef_Y_idFlag_N")
        Examples: master Data
            | read("classpath:com/testDataFiles/orderItems/LimitsMasterValidation.csv") |

    @LimitsIDReqdTrans
    Scenario Outline: <TestCase>
        Given url limitsUrl
        * request ltreq
        * set ltreq.prefferedCustomerNumber = customerNumber
        * set ltreq.preferredSenderCountry = "<Country>"
        * set ltreq.destinationCountry = "<Country>"
        * set ltreq.idFlag = "<idFlag>"
        * def idFlag = "<idFlag>"
        When method post
        Then status 200
        * print response
        Given def transLimits = response.countryIdTransactionLimit
        * if (idFlag == "Y") for (i=0;i<=transLimits;i++) karate.call("classpath:com/callableFiles/orderItems/limits-wcstox.feature")
        * if (idFlag == "N") for (i=0;i<=transLimits;i++) karate.call("classpath:com/callableFiles/orderItems/limits-wcstox.feature")
        # x.destCntryCode
        # x.pcpNumber
        Examples: master Data
            | read("classpath:com/testDataFiles/orderItems/LimitsIDReqdTrans.csv") |


