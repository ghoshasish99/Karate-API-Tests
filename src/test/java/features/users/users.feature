Feature: User functionalities

  Background:
    * url 'https://reqres.in/'
    * def dataGenerator = Java.type('helper.DataGenerator') 
    
  
  Scenario Outline:  Create User
    * def randomName = dataGenerator.getRandomName()
    * def randomJob = dataGenerator.getRandomJob()
    * def payload =
    """
		    {
			    "name": "<name>",
			    "job": "<job>"
				}
    """ 
    Given path 'api/users'
    And request payload
    When method post
    Then status 201
    And match response.name == '<name>'
    
    * def id = response.id
    * print 'Created ID is ',id
    
    Examples:
        | name          | job          |
        | #(randomName) | #(randomJob) |
        | #(randomName) | #(randomJob) |
 
  @Smoke  
  Scenario:  Fetch User  
    Given path 'api/users/2'
    When method get
    Then status 200
    And match response.data.first_name == 'Janet'
    And match response.data.id == 2
    And match response.data.avatar == "#string"
    
  Scenario:  Create and Delete User
    * def payload =
    """
		    {
			    "name": "morpheus",
			    "job": "leader"
				}
    """ 
    Given path 'api/users'
    And request payload
    When method post
    Then status 201
    And match response.name == 'morpheus'
    
    * def id = response.id
    * print 'Created ID is ',id  
    
    Given path 'api/users/'+id
    When method delete
    Then status 204