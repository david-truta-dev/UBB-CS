package org.example.steps.serenity;

import net.thucydides.core.annotations.Step;
import org.example.pages.DictionaryPage2;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.hasItem;

public class EndUserSteps2 {

    DictionaryPage2 dictionaryPage;

    @Step
    public void enters(String keyword) {
        dictionaryPage.enter_keywords(keyword);
    }

    @Step
    public void starts_search() {
        dictionaryPage.lookup_terms();
    }

    @Step
    public void should_see_definition(String definition) {
        assertThat(dictionaryPage.getDefinitions(), hasItem(containsString(definition)));
    }

    @Step
    public void is_the_home_page() {
        dictionaryPage.open();
    }

    @Step
    public void hit_enter(String term) {
        enters(term);
        starts_search();
    }

    @Step
    public void looks_for(String term) {
        enters(term);
        starts_search();
    }
}