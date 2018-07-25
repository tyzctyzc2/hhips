package report;

class ScoreCalculator1 implements ScoreCalculator {

    @Override
    public int GetBaseScore(boolean pass) {
        if (pass)
            return 2;
        return -2;
    }

    @Override
    public int GetWrongTimeScore(int wrongTimeCount) {
        if (wrongTimeCount > 0)
            return -1;
        return 0;
    }

    @Override
    public int GetUsedTimeScore(int totalUsedTime) {
        if (totalUsedTime <3)
            return 1;

        if (totalUsedTime > 10)
            return -1;

        return 0;
    }

    @Override
    public int GetModuleScore(int moduleID) {
        return 0;
    }
}


class ScoreCalculator2 implements ScoreCalculator {

    @Override
    public int GetBaseScore(boolean pass) {
        return 4;
    }

    @Override
    public int GetWrongTimeScore(int wrongTimeCount) {
        if (wrongTimeCount > 0)
            return -1;
        return 0;
    }

    @Override
    public int GetUsedTimeScore(int totalUsedTime) {
        if (totalUsedTime <5)
            return 1;

        if (totalUsedTime > 15)
            return -1;

        return 0;
    }

    @Override
    public int GetModuleScore(int moduleID) {
        return 0;
    }
}

class ScoreCalculator3 implements ScoreCalculator {

    @Override
    public int GetBaseScore(boolean pass) {
        return 10;
    }

    @Override
    public int GetWrongTimeScore(int wrongTimeCount) {
        if (wrongTimeCount > 0)
            return -1;
        return 0;
    }

    @Override
    public int GetUsedTimeScore(int totalUsedTime) {
        if (totalUsedTime <10)
            return 1;

        if (totalUsedTime > 20)
            return -1;

        return 0;
    }

    @Override
    public int GetModuleScore(int moduleID) {
        return 0;
    }
}

class ScoreCalculator4 implements ScoreCalculator {

    @Override
    public int GetBaseScore(boolean pass) {
        return 14;
    }

    @Override
    public int GetWrongTimeScore(int wrongTimeCount) {
        if (wrongTimeCount > 0)
            return 0;
        return 1;
    }

    @Override
    public int GetUsedTimeScore(int totalUsedTime) {
        if (totalUsedTime <30)
            return 1;

        return 0;
    }

    @Override
    public int GetModuleScore(int moduleID) {
        return 0;
    }
}


public class ProblemScoreCalculator {

    public static ScoreCalculator GetCalculator(int level) {
        switch (level) {
            case 1:
                return new ScoreCalculator1();
            case 2:
                return new ScoreCalculator2();
            case 3:
                return new ScoreCalculator3();
            case 4:
                return new ScoreCalculator4();
        }
        return null;
    }
}