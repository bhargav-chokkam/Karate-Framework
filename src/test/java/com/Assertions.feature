Feature: Assertions Feature

  @galaticErrorValidation
  Scenario:
    * match response.legacyError == "U2230 RTRA LP NOT RECEIVED - PLEASE RETRANSMIT"

  @NewRulesDef_A_idFlag_Y
  Scenario:
    * print "customerLimit from Response: ",response.customerLimit
    * print "customerLimit Passed: ",VerifiedRepeat
    * match response.customerLimit contains VerifiedRepeat

  @NewRulesDef_A_idFlag_N
  Scenario:
    * print "customerLimit from Response: ",response.customerLimit
    * print "customerLimit Passed: ",UnVerifiedNew
    * match response.customerLimit contains UnVerifiedNew

  @NewRulesDef_Y_idFlag_Y
  Scenario:
    * print "customerLimit from Response: ",response.customerLimit
    * print "customerLimit Passed: ",UnVerifiedNew
    * match response.customerLimit contains UnVerifiedNew

  @NewRulesDef_Y_idFlag_N
  Scenario:
    * print "customerLimit from Response: ",response.customerLimit
    * print "customerLimit Passed: ",UnVerifiedRepeat
    * match response.customerLimit contains UnVerifiedRepeat