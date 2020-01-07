package report;

import dbmodel.SourceChapterSummary;

public class SourceChapterReport extends SourceChapterSummary {
    private Integer problemDoneCount;
    private Integer problemWrongCount;
    private Integer problemBlankCount;

    public SourceChapterReport(SourceChapterSummary sourceChapterSummary) {
        setChapternotecount(sourceChapterSummary.getChapternotecount());
        setChapterproblemcount(sourceChapterSummary.getChapterproblemcount());
        setIdsourcechapter(sourceChapterSummary.getIdsourcechapter());
        setSourcechapterindex(sourceChapterSummary.getSourcechapterindex());
        setSourcechaptername(sourceChapterSummary.getSourcechaptername());
        setSourceid(sourceChapterSummary.getSourceid());
    }

    public Integer getProblemDoneCount() {
        return problemDoneCount;
    }

    public void setProblemDoneCount(Integer problemDoneCount) {
        this.problemDoneCount = problemDoneCount;
    }

    public Integer getProblemWrongCount() {
        return problemWrongCount;
    }

    public void setProblemWrongCount(Integer problemWrongCount) {
        this.problemWrongCount = problemWrongCount;
    }

    public Integer getProblemBlankCount() {
        return problemBlankCount;
    }

    public void setProblemBlankCount(Integer problemBlankCount) {
        this.problemBlankCount = problemBlankCount;
    }
}
