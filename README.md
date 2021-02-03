# Karate-test
 
 ![Karate Test](https://github.com/ghoshasish99/karate-test/workflows/Karate%20Test/badge.svg)
 
 ```powershell
 mvn archetype:generate \
-DarchetypeGroupId=com.intuit.karate \
-DarchetypeArtifactId=karate-archetype \
-DarchetypeVersion=0.9.6 \
-DgroupId=<your_group_id> \
-DartifactId=<your_project_name>
 ```

```gherkin
Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200
```
