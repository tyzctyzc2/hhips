package report;

public interface ScoreCalculator {
    int GetBaseScore(boolean pass);
    int GetWrongTimeScore(int wrongTimeCount);
    int GetUsedTimeScore(int totalUsedTime);
    int GetModuleScore(int moduleID);
}