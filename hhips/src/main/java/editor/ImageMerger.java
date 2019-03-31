package editor;

import hhips.air.AutoCutterController;
import org.opencv.core.Mat;
import org.opencv.core.Point;
import org.opencv.core.Scalar;
import org.opencv.core.Size;
import org.opencv.imgcodecs.Imgcodecs;
import org.slf4j.LoggerFactory;
import uti.FileHelper;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ImageMerger {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(ImageMerger.class);
    Imgcodecs imageCodecs = new Imgcodecs();

    public static String VUE__IMAGE_PATH = "D:\\webbackup\\static\\cutter\\";

    public void doSmartMerge(List<String> allWaitMerge) {
        Map<String, Map<Point, String>> allPages = new HashMap<>();
        for(String curFileName : allWaitMerge) {
            String myPage = curFileName.substring(4,6);
            Map<Point, String> allMyPage;
            if (allPages.containsKey(myPage) == true) {
                allMyPage = allPages.get(myPage);
            } else {
                allMyPage = new HashMap<>();
            }
            String myXString = curFileName.substring(curFileName.indexOf("_x") + 2, curFileName.indexOf("_y"));
            String myYString = curFileName.substring(curFileName.indexOf("_y") + 2, curFileName.indexOf("."));
            int myMinX = Integer.parseInt(myXString);
            int myMinY = Integer.parseInt(myYString);

            Point myPoint = new Point(myMinX, myMinY);

            allMyPage.put(myPoint,curFileName);
            allPages.put(myPage, allMyPage);
        }

        for(String page : allPages.keySet()) {
            doSmartOnePage(allPages.get(page));
        }
    }

    private void doSmartOnePage(Map<Point,String> allPartName) {
        ArrayList<Point> sortedPoint = new ArrayList<>();
        for (Point myPoint : allPartName.keySet()) {
            int i = 0;
            for(i = 0; i < sortedPoint.size(); ++i) {
                if (sortedPoint.get(i).y > myPoint.y) {
                    break;
                }
            }
            sortedPoint.add(i, myPoint);
        }

        int minHeight = 100;
        for(int i = 1; i < sortedPoint.size(); ++i) {
            double thisHeight = sortedPoint.get(i).y - sortedPoint.get(i - 1).y;
            if (thisHeight < minHeight && thisHeight > 40) {//very small height will not count
                minHeight = (int) thisHeight;
            }
        }

        minHeight = minHeight;
        logger.info("merge height = " +String.valueOf(minHeight));

        List<String> waitMerge = new ArrayList<>();
        waitMerge.add(allPartName.get(sortedPoint.get(0)));
        for(int i = 1; i < sortedPoint.size(); ++i) {
            Mat lastImg;
            lastImg = imageCodecs.imread(FileHelper.getAbsolutePath() +
                    AutoCutterController.CUTTER_PATH_NAME + allPartName.get(sortedPoint.get(i-1)));

            double thisHeight = sortedPoint.get(i).y - sortedPoint.get(i - 1).y - lastImg.height();
            if (thisHeight < minHeight) {
                waitMerge.add(allPartName.get(sortedPoint.get(i)));
            } else {
                if (waitMerge.size() > 1) {
                    doMerge(waitMerge);
                }
                waitMerge = new ArrayList<>();
                waitMerge.add(allPartName.get(sortedPoint.get(i)));
            }
        }
        if (waitMerge.size() > 1) {
            doMerge(waitMerge);
        }
    }

    public void doMerge(List<String> allWaitMerge) {
        if (allWaitMerge.size() < 2)
            return;

        Map<Point, Mat> allMat = new HashMap<>();
        int minX = 10000;
        int minY = 10000;
        int maxX = 0;
        int maxY = 0;
        int imgType = 0;
        String myPage = "";
        for(int i = 0; i < allWaitMerge.size(); ++i) {
            String curFileName = allWaitMerge.get(i);
            myPage = curFileName.substring(4,6);
            logger.info(curFileName);
            Mat thisImg;
            thisImg = imageCodecs.imread(FileHelper.getAbsolutePath() +
                    AutoCutterController.CUTTER_PATH_NAME + curFileName);
            logger.info("sizex=" + String.valueOf(thisImg.width()) + "sizey=" + String.valueOf(thisImg.height()));
            String myXString = curFileName.substring(curFileName.indexOf("_x") + 2, curFileName.indexOf("_y"));
            String myYString = curFileName.substring(curFileName.indexOf("_y") + 2, curFileName.indexOf("."));
            int myMinX = Integer.parseInt(myXString);
            int myMinY = Integer.parseInt(myYString);
            if (myMinX < minX)
                minX = myMinX;
            if (myMinY < minY)
                minY = myMinY;

            int myMaxX = myMinX + thisImg.width();
            int myMaxY = myMinY + thisImg.height();

            if (myMaxX > maxX)
                maxX = myMaxX;

            if (myMaxY > maxY)
                maxY = myMaxY;

            allMat.put(new Point(myMinX, myMinY), thisImg);
            imgType = thisImg.type();

            File file = new File( FileHelper.getAbsolutePath() + AutoCutterController.CUTTER_PATH_NAME + curFileName);
            file.delete();
        }

        logger.info("minX=" + String.valueOf(minX) + "  minY=" + String.valueOf(minY) + " maxX=" + String.valueOf(maxX) + "    maxY=" + String.valueOf(maxY));

        Mat fullImg = new Mat(new Size(maxX - minX + 1, maxY - minY + 1), imgType);
        fullImg.setTo(new Scalar(255,255,255));
        logger.info("sizeX=" + String.valueOf(maxX - minX + 1) + "  sizeY=" + String.valueOf(maxY - minY + 1));
        for (Point myPoint : allMat.keySet()) {
            Mat thisImg = allMat.get(myPoint);
            logger.info("this posx=" + String.valueOf((int)myPoint.x - minX) + "    this posy=" + String.valueOf((int)myPoint.y - minY));
            logger.info("this sizex=" + String.valueOf(thisImg.width()) + " this sizey=" + String.valueOf(thisImg.height()));
            Mat myTarget = fullImg.submat((int)myPoint.y - minY, (int)myPoint.y - minY+thisImg.height(),
                    (int)myPoint.x - minX, (int)myPoint.x - minX + thisImg.width());
            thisImg.copyTo(myTarget);
        }

        String nameIndex = allWaitMerge.get(0);
        nameIndex = nameIndex.substring(nameIndex.indexOf("_")+1, nameIndex.indexOf("_x"));

        String newName = "part" + myPage + "_" + nameIndex + "_x" + String.valueOf(minX) + "_y" + String.valueOf(minY) + ".png";
        Imgcodecs.imwrite(FileHelper.getAbsolutePath() + AutoCutterController.CUTTER_PATH_NAME + newName, fullImg);

        Imgcodecs.imwrite(ImageMerger.VUE__IMAGE_PATH + newName, fullImg);

    }
}
