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

    public void doMerge(List<String> allWaitMerge) {
        if (allWaitMerge.size() < 2)
            return;

        Map<Point, Mat> allMat = new HashMap<>();
        int minX = 10000;
        int minY = 10000;
        int maxX = 0;
        int maxY = 0;
        int imgType = 0;
        for(int i = 0; i < allWaitMerge.size(); ++i) {
            String curFileName = allWaitMerge.get(i);
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

        String newName = "part_" + nameIndex + "_x" + String.valueOf(minX) + "_y" + String.valueOf(minY) + ".png";
        Imgcodecs.imwrite(FileHelper.getAbsolutePath() + AutoCutterController.CUTTER_PATH_NAME + newName, fullImg);

        Imgcodecs.imwrite(ImageMerger.VUE__IMAGE_PATH + newName, fullImg);

    }
}
