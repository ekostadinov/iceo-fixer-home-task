@fixerAPI @currencies
Feature: As a user, I want to get historical data for currencies, so I can achieve my goals

  @positive @smoke
  Scenario: Authenticated users can get rates between two valid dates for valid base currency
    Given user has access to endpoint "/timeseries"
    When user makes a request to view daily historical rates between start date "2023-01-01" and end date "2023-01-02" with base currency "EUR"
    Then user should get the response code 200

  @positive @smoke
  Scenario: Authenticated users can get rates between two valid dates for valid base currency and symbols
    Given user has access to endpoint "/timeseries"
    When user makes a request to view daily historical rates between start date "2023-01-01" and end date "2023-01-02" with base currency "EUR" and symbols "EUR,USD"
    Then user should get the response code 200

  @negative @p1
  Scenario: Authenticated users can not get rates between two valid dates for invalid base currency
    Given user has access to endpoint "/timeseries"
    When user makes a request to view daily historical rates between start date "2023-01-01" and end date "2023-01-02" with base currency "ZZZ"
    Then user should get the response code 200
    And user validates the response with JSON schema "timeseriesInvalidBaseCurrencyResponse.json"

  @negative @p1
  Scenario: Authenticated users can not get rates between two valid dates for invalid base currency format
    Given user has access to endpoint "/timeseries"
    When user makes a request to view daily historical rates between start date "2023-01-01" and end date "2023-01-02" with base currency "Z1"
    Then user should get the response code 200
    And user validates the response with JSON schema "timeseriesInvalidBaseCurrencyResponse.json"

  @negative @p1
  Scenario: Authenticated users can get rates between two valid dates for valid base currency and mix of symbols
    Given user has access to endpoint "/timeseries"
    When user makes a request to view daily historical rates between start date "2023-01-01" and end date "2023-01-02" with symbols "EUR,ZZZ"
    Then user should get the response code 200

  @negative @p1
  Scenario: Authenticated users can get rates between two valid dates for valid base currency and invalid symbols
    Given user has access to endpoint "/timeseries"
    When user makes a request to view daily historical rates between start date "2023-01-01" and end date "2023-01-02" with symbols "EEE,ZZZ"
    Then user should get the response code 200
    And user validates the response with JSON schema "timeseriesInvalidCurrencySymbolsResponse.json"
