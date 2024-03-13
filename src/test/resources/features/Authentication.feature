@fixerAPI @authentication
Feature: As a user, I want to get access only when I'm authenticated, so I can achieve my goals

  @positive @smoke
  Scenario: Authenticated users can get rates between two valid dates
    Given user has no access to endpoint "/timeseries"
    When user makes a request to view daily historical rates between start date "2023-01-01" and end date "2023-01-02"
    Then user should get the response code 200
    And user validates the response with JSON schema "timeseriesNoRouteMatchedResponse.json"
