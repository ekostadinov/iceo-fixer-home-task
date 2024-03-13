@fixerAPI @dates
Feature: As a user, I want to get daily historical rates between two dates, so I can achieve my goals

  Background: set authentication API key
    Given user has access to endpoint "/timeseries"

  @positive @format @smoke
  Scenario: Authenticated users can get rates between two valid dates
    When user makes a request to view daily historical rates between start date "2023-12-01" and end date "2023-12-31"
    Then user should get the response code 200

  @negative @format @p2
  Scenario: Authenticated users can get rates between two valid dates only if the format is valid
    When user makes a request to view daily historical rates between start date "2023/01/01" and end date "2023/12/31"
    Then user should get the response code 200
    And user validates the response with JSON schema "timeseriesWrongDateFormatResponse.json"

  @negative @p2
  Scenario: Authenticated users can get rates between two dates only if these are valid
    When user makes a request to view daily historical rates between start date "2023-02-01" and end date "2023-02-31"
    Then user should get the response code 200

  @negative @p2
  Scenario: Authenticated users can get rates between two dates only if these are not in the future
    When user makes a request to view daily historical rates between start date "2121-02-01" and end date "2121-02-02"
    Then user should get the response code 200
    And user validates the response with JSON schema "timeseriesNoQueryResultsResponse.json"

  @negative @p2
  Scenario: Authenticated users can get rates between two valid dates only with a maximum time frame of 365 days
    When user makes a request to view daily historical rates between start date "2021-01-01" and end date "2023-12-31"
    Then user should get the response code 200
    And user validates the response with JSON schema "timeseriesDateTimeFrameTooLongResponse.json"
