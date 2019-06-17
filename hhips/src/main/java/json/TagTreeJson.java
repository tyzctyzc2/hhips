package json;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import db.Tag;

import java.util.List;

@JsonPropertyOrder({
        "id",
        "text",
        "children"
})
public class TagTreeJson {
    @JsonProperty("id")
    Integer id;

    @JsonProperty("text")
    String text;

    @JsonProperty("children")
    List<TagTreeJson> children;

    public TagTreeJson(Tag tag) {
        this.id = tag.getIdtag();
        this.text = tag.getTagname();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public List<TagTreeJson> getChildren() {
        return children;
    }

    public void setChildren(List<TagTreeJson> children) {
        this.children = children;
    }
}
