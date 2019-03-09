package editor;

import org.opencv.core.*;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.slf4j.LoggerFactory;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class ImageCutter {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(ImageCutter.class);
    Imgcodecs imageCodecs = new Imgcodecs();
    Mat imgOriginal = null;
    Mat grayImg;
    Mat binaryImgOri;
    Mat binaryImg;
    Mat leftPage;
    Mat rightPage;
    HashMap<Integer, Rect> allBlock = new HashMap<>();
    String fileName;
    public Boolean isDebug = false;
    int fileIndex = 1;
    String filePath;
    public int lineHeight;
    int middleLine;
    boolean twoPageCase = false;
    int pageWidth = 0;

    public Boolean getDebug() {
        return isDebug;
    }

    public String getTimeString() {
        DateFormat df = new SimpleDateFormat("MMddHHmmssSSS");

        Date today = Calendar.getInstance().getTime();
        String dateString = df.format(today);
        return dateString;
    }

    public void setDebug(Boolean debug) {
        isDebug = debug;
    }

    public void doCut(String cutFileFullName) {
        allBlock.clear();
        fileName = cutFileFullName;
        filePath = fileName.substring(0, fileName.lastIndexOf("\\")+1)+"part_";

        if (loadImage() == false) {
            System.out.println("CANNOT load image!");
            logger.error("CANNOT load image!");
            return;
        }
        colorAndErode();
        if (twoPageCase == true) {
            if (cut2Page() == true) {
                imgOriginal = leftPage;
                colorAndErode();
                //brushBlock();
                detectBlock();
                cutImage();

                imgOriginal = rightPage;
                colorAndErode();
                //brushBlock();
                detectBlock();
                cutImage();
                return;
            }
        }
        //brushBlock();
        detectBlock();
        cutImage();
    }

    private boolean loadImage() {
        logger.info("-----start loading-----"+fileName);
        imgOriginal = imageCodecs.imread(fileName);
        logger.info("-----loading done-----");
        if (imgOriginal.empty()) {
            logger.info("-----got empty image!!!!-----");
            return false;
        } else {
            logger.info("-----got NOT empty image!!!!-----");
        }
        return  true;
    }

    private void loadGrayFile() {
        try {
            imgOriginal = imageCodecs.imread(fileName);
            grayImg = imgOriginal.clone();
            Imgproc.cvtColor(imgOriginal, grayImg, Imgproc.COLOR_RGB2GRAY);

            List<MatOfPoint> contours = new ArrayList<>();
            Mat hierarchy = new Mat();

            Imgproc.findContours(grayImg, contours, hierarchy, Imgproc.RETR_LIST, Imgproc.CHAIN_APPROX_SIMPLE);
            MatOfPoint2f mat2fsrc = new MatOfPoint2f();
            MatOfPoint2f mat2fdst = new MatOfPoint2f();
            Scalar color = new Scalar(0, 0, 250);

            for (int i = 0; i < contours.size() - 1; i++) {
                contours.get(i).convertTo(mat2fsrc, CvType.CV_32FC2);
                Imgproc.approxPolyDP(mat2fsrc, mat2fdst, 0.01 * Imgproc.arcLength(mat2fsrc, true), true);
                mat2fdst.convertTo(contours.get(i), CvType.CV_32S);
                Imgproc.drawContours(grayImg, contours, i, color, 30, 8, hierarchy, 0, new Point());
            }

            if (isDebug == true) {
                Imgcodecs.imwrite(fileName + "_gray_contour.PNG", grayImg);
            }
        }
        catch (Exception e) {
            logger.info(e.toString());
        }
    }

    private void colorAndErode() {
        grayImg = imgOriginal.clone();
        binaryImg = imgOriginal.clone();

        try {
            Imgproc.cvtColor(imgOriginal, grayImg, Imgproc.COLOR_BGR2GRAY);
            //Imgproc.threshold(imgOriginal, grayImg, 128, 255, Imgproc.THRESH_BINARY | Imgproc.THRESH_OTSU);
            //adaptiveThreshold(gray, result, 255, ADAPTIVE_THRESH_MEAN_C, THRESH_BINARY, 15, 40);
            Imgproc.adaptiveThreshold(grayImg, binaryImg, 255, Imgproc.ADAPTIVE_THRESH_MEAN_C, Imgproc.THRESH_BINARY, 15, 40);
            binaryImgOri = binaryImg.clone();

        } catch (Exception e) {
            logger.info(e.toString());
            return;
        }
        if (grayImg.empty()) {
            logger.info("-----clone empty image!!!!-----");
            return;
        } else {
            logger.info("-----got clone NOT empty image!!!!-----");
        }
        logger.info("-----color done-----");
        if (isDebug == true) {
            Imgcodecs.imwrite(fileName + "_binarycolor.PNG", binaryImg);
        }

        int erodeSize = 20;
        final Size kernelSize = new Size(erodeSize, erodeSize);

        Mat kernel = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, kernelSize);
        Imgproc.erode(binaryImg, binaryImg, kernel);
        Imgproc.dilate(binaryImg, binaryImg, kernel);
        logger.info("-----erode done-----");

        if (isDebug == true) {
            logger.info("save erode file -->"+fileName + "_erode.PNG");
            Imgcodecs.imwrite(fileName + "_erode.PNG", grayImg);
        }
        if (imgOriginal.width() > imgOriginal.height()) {
            twoPageCase = true;
            pageWidth = imgOriginal.width() / 2;
        } else {
            pageWidth = imgOriginal.width();
        }
    }

    private boolean cut2Page() {
        List<MatOfPoint> contoursDia = new ArrayList<>();
        Mat hierarchyDia = new Mat();
        MatOfPoint2f mat2fsrc = new MatOfPoint2f();
        MatOfPoint2f mat2fdst = new MatOfPoint2f();
        Scalar color =  new Scalar(0, 0, 250);
        Mat tmp = imgOriginal.clone();
        Mat darkBinaryImg = imgOriginal.clone();

        Imgproc.adaptiveThreshold(grayImg, darkBinaryImg, 255, Imgproc.ADAPTIVE_THRESH_MEAN_C, Imgproc.THRESH_BINARY, 15, 10);
        int erodeSize = 20;
        final Size kernelSize = new Size(erodeSize, erodeSize);

        Mat kernel = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, kernelSize);
        Imgproc.erode(darkBinaryImg, darkBinaryImg, kernel);

        Imgproc.findContours(darkBinaryImg, contoursDia, hierarchyDia, Imgproc.RETR_LIST, Imgproc.CHAIN_APPROX_SIMPLE, new Point(0,0));

        Mat tmp2 = imgOriginal.clone();
        Mat tmp3 = imgOriginal.clone();
        int minBlock = pageWidth / 2;
        int leftEnd = 0;
        int rightStart = imgOriginal.width();
        for (int i = 0; i < contoursDia.size(); i++) {
            Rect rec = Imgproc.boundingRect(contoursDia.get(i));
            //System.out.println(Integer.toString(i) + "==" +  rec.toString());

            if ((rec.height < minBlock) || (rec.width<minBlock)) {
                continue;
            }

            if (rec.width > pageWidth)
                continue;

            if (rec.x > minBlock) {
                //right page
                if (rec.x < rightStart)
                    rightStart = rec.x;
            } else {
                //left page
                if ((rec.x + rec.width) > leftEnd)
                    leftEnd = rec.x + rec.width;
            }

            Imgproc.rectangle(tmp2, rec.tl(), rec.br(), new Scalar(0, 200, 0), 2, 4, 0);
        }
        if (leftEnd == 0 && rightStart == imgOriginal.width()) {//not find page break, we need try with other way
            calculateLineHeight(contoursDia);

            List<Rect> allLineBlock = new ArrayList<>();
            int maxWidth = imgOriginal.width() / 2;
            for (int i = 0; i < contoursDia.size(); i++) {
                Rect rec = Imgproc.boundingRect(contoursDia.get(i));
                if (rec.width < lineHeight || rec.height < lineHeight)
                    continue;

                if (rec.width < rec.height *2)
                    continue;

                if (rec.width > maxWidth)
                    continue;

                allLineBlock.add(rec);
            }

            List<Rect> rightBlock = new ArrayList<>();
            for(int i = 0; i < allLineBlock.size(); ++i) {
                Rect cur = allLineBlock.get(i);
                if (cur.x < middleLine) {
                    //from left page
                    if ((cur.x + cur.width) > middleLine) {
                        middleLine = cur.x + cur.width;
                    }
                } else {
                    rightBlock.add(cur);
                }
            }

            rightStart = imgOriginal.width();
            for(int i = 0; i < rightBlock.size(); ++i) {
                Rect cur = rightBlock.get(i);
                if (cur.x < middleLine) {
                    //from left page
                    if ((cur.x + cur.width) > middleLine) {
                        middleLine = cur.x + cur.width;
                    }
                } else {
                    if (cur.x < rightStart)
                        rightStart = cur.x;
                }
            }

            int mid = (middleLine + rightStart) / 2;
            cutInto2Pages(mid, mid);
            if (isDebug) {
                Rect left = new Rect();
                left.x = 0;
                left.y = 0;
                left.width = mid;
                left.height = imgOriginal.height();
                Imgproc.rectangle(tmp3, left.tl(), left.br(), new Scalar(0, 200, 0), 2, 4, 0);
                Imgcodecs.imwrite(fileName+"_block_find_page.PNG", tmp3);
            }
            return true;
        }
        if (isDebug == true) {
            Imgcodecs.imwrite(fileName+"_block_find_page.PNG", tmp2);
        }
        cutInto2Pages(leftEnd, rightStart);
        return  true;
    }

    private void cutInto2Pages(int leftEnd, int rightStart) {
        Rect left = new Rect();
        left.x = 0;
        left.y = 0;
        left.height = imgOriginal.height();
        left.width = leftEnd;
        leftPage = new Mat(imgOriginal, left);

        if (isDebug == true) {
            Imgcodecs.imwrite(fileName+"_left.PNG", leftPage);
        }

        Rect right = new Rect();
        right.x = rightStart;
        right.y = 0;
        right.height = imgOriginal.height();
        right.width = imgOriginal.width() - rightStart;
        rightPage = new Mat(imgOriginal, right);

        if (isDebug == true) {
            Imgcodecs.imwrite(fileName+"_right.PNG", rightPage);
        }
    }

    private void cutImage() {
        HashMap<Integer, Rect> leftBlock = new HashMap<>();

        for(Integer lineY: allBlock.keySet()) {
            Rect cur = allBlock.get(lineY);

            if (cur.width < lineHeight)
                continue;

            leftBlock.put(lineY, cur);
        }


        Map<Integer, Rect> treeMap = new TreeMap<Integer, Rect>(
                new Comparator<Integer>() {
                    @Override
                    public int compare(Integer o1, Integer o2) {
                        return o1-o2;
                    }
                });
        treeMap.putAll(leftBlock);

        Mat tmp = imgOriginal.clone();

        for(Integer lineY: treeMap.keySet()) {
            Rect cur = treeMap.get(lineY);
            if (cur.width < lineHeight && cur.height < lineHeight)
                continue;

            Mat part = new Mat(imgOriginal, treeMap.get(lineY));

            Imgcodecs.imwrite(filePath + String.format("%05d", fileIndex)
                    + "_x" + String.valueOf(cur.x) + "_y" + String.valueOf(cur.y) + ".png", part);

            Imgcodecs.imwrite("D:\\webbackup\\static\\cutter\\part_" + String.format("%05d", fileIndex)
                    + "_x" + String.valueOf(cur.x) + "_y" + String.valueOf(cur.y) + ".png", part);
            fileIndex++;

            Imgproc.rectangle(tmp, treeMap.get(lineY).tl(), treeMap.get(lineY).br(), new Scalar(0, 255, 0), 2, 4, 0);
        }

        Imgcodecs.imwrite(fileName+getTimeString()+"_final_cut.PNG", tmp);
    }

    private boolean isMyBlock(Mat block) {
        int whiteCount = 0;
        int blackCount = 0;
        for (int j = 0; j < block.rows(); j++)
        {
            for (int k = 0; k < block.cols(); k++)
            {
                double[] pixel = block.get(j, k);
                if (pixel[0] == 255)
                    whiteCount++;
                else
                    blackCount++;
            }
        }
        //System.out.println("white / black = " + whiteCount + "/" + blackCount);
        float perF = (float)blackCount/((float)blackCount+(float)whiteCount);
        perF = perF *100;
        int perI = (int)perF;
        if (perI < 5)
            return false;
        //Imgcodecs.imwrite(fileName+"_W"+block.width()+"_H"+block.height()+"_B"+blackCount+"_W"+whiteCount+"_P"+perI + "_block_second.PNG", block);
        return true;
    }

    private void detectBlock() {
        allBlock.clear();
        List<MatOfPoint> contoursDia = new ArrayList<>();
        Mat hierarchyDia = new Mat();
        MatOfPoint2f mat2fsrc = new MatOfPoint2f();
        MatOfPoint2f mat2fdst = new MatOfPoint2f();
        Scalar color =  new Scalar(0, 0, 250);

        List<Rect> unsortedBlock = new ArrayList<>();
        Imgproc.findContours(binaryImg, contoursDia, hierarchyDia, Imgproc.RETR_LIST, Imgproc.CHAIN_APPROX_SIMPLE, new Point(0,0));
        calculateLineHeight(contoursDia);
        logger.info("----line height = "+Integer.toString(lineHeight));
        Mat foundBlock = imgOriginal.clone();
        Mat foundBlockYes = imgOriginal.clone();

        int minSize = lineHeight / 2;
        for (int i = 0; i < contoursDia.size(); i++) {
            Rect rec = Imgproc.boundingRect(contoursDia.get(i));
            Imgproc.rectangle(foundBlock, rec.tl(), rec.br(), new Scalar(0, 200, 0), 2, 4, 0);
            if ((rec.height > grayImg.height() * 0.9) && (rec.width > grayImg.width() * 0.9)) {
                //remove very big block
                continue;
            }
            if ((rec.height < minSize) && (rec.width < minSize)){
                //remove very small block
                continue;
            }

            if ((rec.width < minSize) && (rec.height < lineHeight)){
                //remove very small block
                continue;
            }

            if ((rec.width < lineHeight) && (rec.height > 5 * lineHeight)) {
                continue;
            }

            /*if (rec.x < minSize * 2 || rec.y < minSize * 2) {//maybe it is a line
                continue;
            }*/

            if (rec.height > (imgOriginal.height() * 0.3)) {
                //block with very less black in it
                Mat part = new Mat(binaryImgOri, rec);
                boolean isGoodBlock = isMyBlock(part);
                //System.out.println(Integer.toString(i) + "==" + rec.toString() + isMyBlock(part));
                if (isGoodBlock == false)
                    continue;
            }

            Imgproc.rectangle(foundBlockYes, rec.tl(), rec.br(), new Scalar(0, 200, 0), 2, 4, 0);
            unsortedBlock.add(rec);
        }

        Imgcodecs.imwrite(fileName+getTimeString()+"_block_first_found_rec.PNG", foundBlock);
        Imgcodecs.imwrite(fileName+getTimeString()+"_block_first_foundYES_rec.PNG", foundBlockYes);

        List<Rect> sortedBlock = sortBlocks(unsortedBlock);
        //saveAllPart(sortedBlock);
        for(int i = 0; i<sortedBlock.size();++i) {
            cacheNewBlock(sortedBlock.get(i));
        }
        //saveAllPart(new ArrayList<>(allBlock.values()));
    }

    private List<Rect> sortBlocks(List<Rect> unsortedBlock) {
        List<Rect> sortedBlock = new ArrayList<>();
        //sort block
        int idx= 0;
        Map<Integer, List<Rect>> lineByLine = new HashMap<>();

        for(Rect unsortCur: unsortedBlock) {
            int curYCenter = unsortCur.y + (unsortCur.height / 2);
            if (idx == 0) {
                List<Rect> curLine = new ArrayList<>();
                curLine.add(unsortCur);
                lineByLine.put(curYCenter, curLine);
                idx++;
                continue;
            }

            Integer myLineY = 0;
            for (Integer curY: lineByLine.keySet()) {
                if (Math.abs(curY - curYCenter) < lineHeight) {
                    //found my line
                    myLineY = curY;
                    break;
                }
            }

            if (myLineY > 0) {
                List<Rect> myLine = lineByLine.get(myLineY);
                int y = 0;
                for(y = 0; y < myLine.size(); ++y) {
                    if (myLine.get(y).x > unsortCur.x) {
                        break;
                    }
                }
                myLine.add(y, unsortCur);
                //recalculate Y center after new block added
                int allCenterYSum = 0;
                for(y = 0; y < myLine.size(); ++y) {
                    allCenterYSum = allCenterYSum + myLine.get(y).y + (myLine.get(y).height / 2);
                }
                int newCenterY = allCenterYSum / myLine.size();
                lineByLine.remove(myLineY);
                lineByLine.put(newCenterY, myLine);
                continue;
            }

            List<Rect> curLine = new ArrayList<>();
            curLine.add(unsortCur);
            lineByLine.put(curYCenter, curLine);
        }

        Mat tmp = imgOriginal.clone();
        int color = 0;
        Map<Integer, List<Rect>> afterSortedMap = sortMapByKey(lineByLine);
        for (Integer curY: afterSortedMap.keySet()) {
            List<Rect> thisLine = lineByLine.get(curY);
            logger.info(curY.toString());
            for(int y = 0; y < thisLine.size(); ++y) {
                sortedBlock.add(thisLine.get(y));
                color++;
                Imgproc.rectangle(tmp, thisLine.get(y).tl(), thisLine.get(y).br(), new Scalar(0, color * 5, 0), 2, 4, 0);
            }
        }
        Imgcodecs.imwrite(fileName+getTimeString()+"_block_after_sort.PNG", tmp);
        return sortedBlock;
    }

    public Map<Integer, List<Rect>> sortMapByKey(Map<Integer, List<Rect>> oriMap) {
        if (oriMap == null || oriMap.isEmpty()) {
            return null;
        }
        Map<Integer, List<Rect>> sortedMap = new TreeMap<Integer, List<Rect>>(new Comparator<Integer>() {
            public int compare(Integer key1, Integer key2) {
                return  key1 - key2;
            }});
        sortedMap.putAll(oriMap);
        return sortedMap;
    }

    private void saveAllPart(List<Rect> allPart) {
        for(int i = 0; i<allPart.size();++i) {
            Rect cur = allPart.get(i);
            //if (isDebug == true) {
                Mat part = imgOriginal.clone();
                Imgproc.rectangle(part, allPart.get(i).tl(), allPart.get(i).br(), new Scalar(0, 255, 0), 2, 4, 0);
                Imgcodecs.imwrite(fileName+getTimeString()+"_block_"+Integer.toString(i)+"_"
                        +Integer.toString(cur.x)+"_"+Integer.toString(cur.y)
                        +"!"+Integer.toString(cur.width)+"X"+Integer.toString(cur.height)+"!"+".png", part);
            //}
        }
    }

    private void calculateLineHeight(List<MatOfPoint> contours) {
        ArrayList<Integer> countHeight = new ArrayList<>();
        int minBox = 5;
        for (int i = 0; i < contours.size(); i++) {
            Rect rec = Imgproc.boundingRect(contours.get(i));
            if ((rec.width < minBox) && (rec.height < minBox)) {
                continue;
            }
            countHeight.add(rec.height);
        }

        int[] allHeights = new int[countHeight.size()];
        for (int i = 0; i < countHeight.size(); i++) {
            allHeights[i] = countHeight.get(i);
        }
        Arrays.sort(allHeights, 0, countHeight.size());
        if (countHeight.size() >2) {
            lineHeight = allHeights[allHeights.length/2];
        } else {
            lineHeight = allHeights[0];
        }

        middleLine = imgOriginal.width();
        if (imgOriginal.width() > imgOriginal.height()) {
            middleLine = (int) (imgOriginal.width() / 2 *0.8);
        }
    }

    private void brushBlock() {
        List<MatOfPoint> contoursDia = new ArrayList<>();
        Mat hierarchyDia = new Mat();
        MatOfPoint2f mat2fsrc = new MatOfPoint2f();
        MatOfPoint2f mat2fdst = new MatOfPoint2f();
        Scalar color =  new Scalar(0, 0, 250);
        Mat tmp = imgOriginal.clone();

        Imgproc.findContours(binaryImg, contoursDia, hierarchyDia, Imgproc.RETR_TREE, Imgproc.CHAIN_APPROX_SIMPLE, new Point(0,0));

        Mat tmp2 = binaryImg.clone();
        int minBlock = 20;
        for (int i = 0; i < contoursDia.size(); i++) {
            Rect rec = Imgproc.boundingRect(contoursDia.get(i));

            if ((rec.height > grayImg.height() * 0.9) || (rec.width > pageWidth * 0.9)) {
                continue;
            }
            if ((rec.height < minBlock)&&(rec.width<minBlock)) {
                continue;
            }

            if (rec.x < minBlock*2 || rec.y < minBlock*2) {
                continue;
            }

            cacheNewBlock(rec);

            Imgproc.rectangle(grayImg, rec.tl(), rec.br(), new Scalar(0, 200, 0), -1, 4, 0);

            Imgproc.rectangle(tmp2, rec.tl(), rec.br(), new Scalar(0, 200, 0), 2, 4, 0);
        }

        //Imgcodecs.imwrite(fileName+"_block_first_found.PNG", grayImg);
        Imgcodecs.imwrite(fileName+getTimeString()+"_block_first_found_rec.PNG", tmp2);
    }

    private Rect merge2Rect(Rect one, Rect two) {
        int maxX, maxY;
        if (one.x+one.width > two.x+two.width) {
            maxX=one.x+one.width;
        } else {
            maxX=two.x+two.width;
        }
        if (one.y+one.height > two.y+two.height) {
            maxY = one.y+one.height;
        } else {
            maxY = two.y+two.height;
        }
        int minX, minY;
        if (one.x < two.x) {
            minX = one.x;
        } else {
            minX = two.x;
        }
        if (one.y < two.y) {
            minY = one.y;
        } else {
            minY = two.y;
        }
        Rect afterMerge = new Rect();
        afterMerge.x = minX;
        afterMerge.y = minY;
        afterMerge.width = maxX-minX;
        afterMerge.height = maxY-minY;
        return  afterMerge;
    }

    private boolean needMerge(Rect target, Rect added) {
        int closeThreshHold = lineHeight / 4;

        Rect left = new Rect();
        Rect right = new Rect();

        if (target.x > added.x) {
            left = new Rect(added.x, added.y, added.width, added.height);
            right = new Rect(target.x, target.y, target.width, target.height);
        } else {
            left = new Rect(target.x, target.y, target.width, target.height);
            right = new Rect(added.x, added.y, added.width, added.height);
        }
        int slotX = right.x - (left.x + left.width);
        //may from different page
        if (slotX > (lineHeight * 2))
            return false;

        Rect upper = new Rect();
        Rect lower = new Rect();
        if (target.y > added.y) {
            upper = new Rect(added.x, added.y, added.width, added.height);
            lower = new Rect(target.x, target.y, target.width, target.height);
        } else {
            upper = new Rect(target.x, target.y, target.width, target.height);
            lower = new Rect(added.x, added.y, added.width, added.height);
        }
        int slotY = lower.y - (upper.y + upper.height);
        if (slotY < closeThreshHold)
            return true;

        return false;
    }

    private void cacheNewBlock(Rect newBlock) {
        boolean foundMergeCase = false;
        Rect oldBlock = null;
        for(Integer lineY: allBlock.keySet()) {
            if (needMerge(allBlock.get(lineY), newBlock) == true) {
                oldBlock = allBlock.get(lineY);
                allBlock.remove(lineY);
                foundMergeCase = true;
                break;
            }
        }

        if (foundMergeCase == false) {
            allBlock.put(newBlock.y, newBlock);
            return;
        }

        Rect afterMerge = merge2Rect(oldBlock, newBlock);
        allBlock.put(afterMerge.y, afterMerge);
    }
}
