package json;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({
        "foundDuplicate",
        "word",
        "explanation"
})
public class WordSearchResponse {
    @JsonProperty("foundDuplicate")
    boolean foundDuplicate;

    @JsonProperty("word")
    String word;

    @JsonProperty("explanation")
    String explanation;

    public boolean isFoundDuplicate() {
        return foundDuplicate;
    }

    public void setFoundDuplicate(boolean foundDuplicate) {
        this.foundDuplicate = foundDuplicate;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }
}
