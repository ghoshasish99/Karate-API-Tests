Feature: Registration

  Background:
    * url 'https://reqres.in/' 
    * def dataGenerator = Java.type('helper.DataGenerator') 
    * def randomEmail = dataGenerator.getRandomEmail()
  
  Scenario Outline:  Successful Registration
    * def randomPwd = dataGenerator.getRandomPwd()
    * def payload =
    """
		    {
			    "email": "<email>",
			    "password": "<password>"
			  }
    """ 
    Given path 'api/register'
    And request payload
    When method post
    Then status 200
    And match response.token == '#string'
    
    * def id = response.id
    * print 'Created ID is ',id
    * def token = response.token
    * print 'Created token is ',token
    
    Examples:
        | email                  | password     |
        | eve.holt@reqres.in     | #(randomPwd) |
        | tracey.ramos@reqres.in | #(randomPwd) |
    
  Scenario:  Unsuccessful Registration
    * def payload =
    """
		    {
			    "email": "#(randomEmail)"
			  }
    """ 
    Given path 'api/register'
    And request payload
    When method post
    Then status 400
    And match response.error == 'Missing password'
