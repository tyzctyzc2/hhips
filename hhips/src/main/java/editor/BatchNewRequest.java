package editor;

import com.fasterxml.jackson.annotation.JsonProperty;

public class BatchNewRequest {
    @JsonProperty("img")
    private String img;

    @JsonProperty("index")
    private String index;

    @JsonProperty("level")
    private Integer level;

    @JsonProperty("module")
    private Integer module;

    @JsonProperty("chapter")
    private Integer chapter;

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Integer getModule() {
        return module;
    }

    public void setModule(Integer module) {
        this.module = module;
    }

    public Integer getChapter() {
        return chapter;
    }

    public void setChapter(Integer chapter) {
        this.chapter = chapter;
    }
}
