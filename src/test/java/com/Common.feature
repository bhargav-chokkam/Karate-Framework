Feature: Common
 
  Scenario:
    * def randomNumber =
      """
      function(max) {
      var num = ""
      var possible = "01234567890123456789";
      for (var i = 0; i < max; i++)
      num += possible.charAt(Math.floor(Math.random() * possible.length));
      return num;
      }
      """
  Scenario:
    * def randomName =
      """
      function(max) {
      var num = ""
      var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      for (var i = 0; i < max; i++)
      num += possible.charAt(Math.floor(Math.random() * possible.length));
      return num;
      }
      """