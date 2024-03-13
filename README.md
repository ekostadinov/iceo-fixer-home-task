# Iceo-Home-Task-API-Cucumber

## **Overview:**
Take home task on REST API automation with Cucumber, based on the JAVA stack (including REST Assured). My main goal is to
leverage a library that provides a domain-specific language (DSL) for writing powerful, maintainable tests for RESTful APIs. Cucumber is an open source library, which supports behavior driven development. 
To be more precise, Cucumber can be defined as a testing framework, driven by plain English text. It serves as documentation, automated tests, and
a development aid – all in one.

I have tried to follow all good development practices in this solution.

### **Some of the key features of this framework:**

1. It generates Extent report with all the step details. Report will be generated both HTML & PDF file format.
2. Generates execution logs, with detailed request and response details.
3. Annotations/tags allow sub-set of regression to be executed (smoke, positive/negative, by priority).
4. This also can validate response body using json schema and java pojo classes.
5. Test execution can be triggered form command line. 
6. Easy integration to CI/CD pipeline.

## **Required Setup :**

- [Java](https://www.guru99.com/install-java.html) should be installed and configured.
- [Maven](https://mkyong.com/maven/how-to-install-maven-in-windows/) should be installed and configured.
- Download the files from this Git repository either as zip file OR using Git.

## **Running Tests:**
1. Add your API key to `./config.properties` as:
```
fixerApiKey = YOUR_KEY_HERE
```
**NOTE** you need an active subscription - free is limited to 100 requests/month
2. Open the command prompt and navigate to the folder in which pom.xml file is present.
Run the below Maven command.
```
    mvn clean test
```
3. Once the execution completes report & log will be generated in folder below:
**Report:** 		*target/report*<br>
**Log:** 		*target/logs*

## **Future Improvements:**

- Use more advanced secrets management (env vars, dedicated service, CI plugins)
- Add CI pipeline file (YML)
- Use dynamic Gherkin variables, for example dates can be calculated based on the date today
- Further decompose the Step definitions (glue) classes
- Better validation of the response with JSON schema/contract
- Generate JSON REST POJO content automatically using jsonschema2pojo-maven-plugin
- Better use DTOs in a `./Model` namespace
- DRY (improve) the Gherkin scenarios with Scenario Outline and example tables
- Extend the test coverage for the rest ot the HTTP codes
