package org.example.features.search;

import net.serenitybdd.junit.runners.SerenityRunner;
import net.thucydides.core.annotations.Issue;
import net.thucydides.core.annotations.Managed;
import net.thucydides.core.annotations.Steps;
import net.thucydides.junit.annotations.UseTestDataFrom;
import org.example.steps.serenity.EndUserSteps2;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebDriver;
import org.springframework.beans.factory.annotation.Qualifier;

@RunWith(SerenityRunner.class)
@UseTestDataFrom("src/resources/data.csv")
public class SearchByKeywordStoryDDT {

    @Managed(uniqueSession = true)
    public WebDriver webdriver;

    @Steps
    public EndUserSteps2 altcineva;
    public String name;
    public String definition;

    @Qualifier
    public String getQualifier() {
        return name;
    }

    public void setName(String name) {
        name = name;
    }

    public void setDefinition(String definition) {
        definition = definition;
    }

    public String getName() {
        return name;
    }

    public String getDefinition() {
        return definition;
    }

    @Issue("#EMAG-1")
    @Test
    public void searching_by_keyword_zimbabwe_should_display_the_corresponding_article() {
        altcineva.is_the_home_page();
        altcineva.looks_for("casti");
        altcineva.should_see_definition("A country in Southern Africa. Official name: Republic of Zimbabwe. Formerly called Southern Rhodesia or Rhodesia.");
    }

    @Test
    public void searching_by_keyword_poo_should_display_the_corresponding_article() {
        altcineva.is_the_home_page();
        altcineva.looks_for("poo");
        altcineva.should_see_definition("Alternative spelling of pooh: an instance of saying \"poo\".");
    }

} 