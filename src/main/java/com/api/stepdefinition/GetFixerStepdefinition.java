package com.api.stepdefinition;

import static org.junit.Assert.*;

import io.restassured.config.HeaderConfig;
import io.restassured.config.RestAssuredConfig;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.api.utils.TestContext;

import io.cucumber.java.en.*;
import io.restassured.module.jsv.JsonSchemaValidator;

public class GetFixerStepdefinition {
	private TestContext context;
	private static final Logger LOG = LogManager.getLogger(GetFixerStepdefinition.class);
	
	public GetFixerStepdefinition(TestContext context) {
		this.context = context;
	}

	@Given("user has access to endpoint {string}")
	public void userHasAccessToEndpoint(String endpoint) {
		context.session.put("endpoint", endpoint);
	}

	@Given("user has no access to endpoint {string}")
	public void userHasNoAccessToEndpoint(String endpoint) {
		context.session.put("endpoint", endpoint);
		context.requestSetup().given().config(
				RestAssuredConfig.config().headerConfig(
						HeaderConfig.headerConfig().overwriteHeadersWithName("apikey"))).header("apikey", "invalid-KEY-h3r3")
				.log()
				.all()
				.when().get(context.session.get("endpoint").toString());

	}

	@Then("user should get the response code {int}")
	public void userShpuldGetTheResponseCode(Integer statusCode) {
		assertEquals(Long.valueOf(statusCode), Long.valueOf(context.response.getStatusCode()));
	}

	@When("user makes a request to view daily historical rates between start date {string} and end date {string}")
	public void userMakesARequestToViewDailyHistoricalRatesFromTo(String startDate, String endDate) {
		context.response = context.requestSetup()
				.queryParams("start_date",startDate, "end_date", endDate)
				.when().get(context.session.get("endpoint").toString());
	}

	@When("user makes a request to view daily historical rates between start date {string} and end date {string} with base currency {string}")
	public void userMakesARequestToViewDailyHistoricalRatesFromToAndBaseCurrency(String startDate, String endDate, String currency) {
		context.response = context.requestSetup()
				.queryParams("start_date",startDate, "end_date", endDate, "base", currency)
				.when().get(context.session.get("endpoint").toString());
	}

	@When("user makes a request to view daily historical rates between start date {string} and end date {string} with base currency {string} and symbols {string}")
	public void userMakesARequestToViewDailyHistoricalRatesFromToAndBaseCurrencyAndSymbols(String startDate, String endDate, String currency, String symbols) {
		context.response = context.requestSetup()
				.queryParams("start_date",startDate, "end_date", endDate, "base", currency, "symbols", symbols)
				.when().get(context.session.get("endpoint").toString());
	}

	@When("user makes a request to view daily historical rates between start date {string} and end date {string} with symbols {string}")
	public void userMakesARequestToViewDailyHistoricalRatesFromToAndSymbols(String startDate, String endDate, String symbols) {
		context.response = context.requestSetup()
				.queryParams("start_date",startDate, "end_date", endDate, "symbols", symbols)
				.when().get(context.session.get("endpoint").toString());
	}

	@Then("user validates the response with JSON schema {string}")
	public void userValidatesResponseWithJSONSchema(String schemaFileName) {
		context.response.then().assertThat().body(JsonSchemaValidator.matchesJsonSchemaInClasspath("schemas/"+schemaFileName));
		LOG.info("Successfully Validated schema from "+schemaFileName);
	}
}
