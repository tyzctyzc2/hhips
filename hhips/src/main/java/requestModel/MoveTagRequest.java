package requestModel;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({
        "tagId",
        "newParentTagId"
})
public class MoveTagRequest {
    @JsonProperty("tagId")
    Integer tagId;

    @JsonProperty("newParentTagId")
    Integer newParentTagId;

    public Integer getTagId() {
        return tagId;
    }

    public void setTagId(Integer tagId) {
        this.tagId = tagId;
    }

    public Integer getNewParentTagId() {
        return newParentTagId;
    }

    public void setNewParentTagId(Integer newParentTagId) {
        this.newParentTagId = newParentTagId;
    }
}
