# API Testing with Karate
 
 ![Karate Test](https://github.com/ghoshasish99/karate-test/workflows/Karate%20Test/badge.svg)
 
 For a quickstart, use the Karate Maven archetype to create a skeleton project with one command.
 
 ```powershell
 mvn archetype:generate \
-DarchetypeGroupId=com.intuit.karate \
-DarchetypeArtifactId=karate-archetype \
-DarchetypeVersion=0.9.6 \
-DgroupId=<your_group_id> \
-DartifactId=<your_project_name>
 ```
Sample feature files : 
```gherkin
Scenario:  Fetch User
    Given url 'https://reqres.in/''
    And path 'api/users/2'
    When method get
    Then status 200
```
But its best to define base URL in the `Background` section, like this :
```gherkin
Background:
    * url 'https://reqres.in/'
```
It is important to note that Karate exposes the `status` and `response` to be used for various purposes.
Assertions can be added in this way :
```gherkin
  And match response.data.first_name == 'Janet'
  And match response.data.id == 2
  And match response.data.avatar == "#string"
```
For Data driven scenarios, one can use `Scenario Outline` instead of `Scenario` in this way :
```gherkin
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
```
For Parallel execution using Junit 5, the Runner class should be like this :
```java
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TestParallel {

    @Test
    void testParallel() {
        Results results = Runner.parallel(getClass(),5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
```
To run the full test set :
```powershell
mvn test
```
To run specific scenarios :
Tag the scenarios with tag of your choice, like so :
```gherkin
@Smoke  
  Scenario:  Fetch User  
    Given path 'api/users/2'
    When method get
    Then status 200
```
Then run these scenarios using : 
```powershell
mvn test -Dkarate.options="--tags @Smoke"
```
To run scenarios other than the tagged ones :
```powershell
mvn test -Dkarate.options="--tags ~@Smoke"
```
For more information on Karate please refer [here.](https://github.com/intuit/karate)
