package hhips.air;

import db.DBProblem;
import db.Problem;
import editor.*;
import nu.pattern.OpenCV;
import org.json.JSONArray;
import org.opencv.core.Core;
import editor.ImageCutter;
import editor.PDFProcessor;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import uti.FileHelper;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.file.Files;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Controller
@PropertySource("classpath:application.properties")
public class AutoCutterController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AutoCutterController.class);

    public static final String CUTTER_PATH_NAME = "cutter\\";

    @Autowired
    DBProblem dbProblem;

    @Autowired
    private Environment env;

    @PostConstruct
    public void init() {
        try {
            logger.info("------------------load opencv start--------");
            String osName = System.getProperty("os.name");
            String allClassPath = System.getProperty("java.class.path");
            logger.info("java.class.path--->" + allClassPath);
            String []paths = allClassPath.split(";");
            String opencvpath = "";
            for (String p: paths) {
                if (p.contains("\\classes")) {
                    opencvpath = p;
                    break;
                }
            }
            if (opencvpath.contains("class") == false) {
                String allLibraryPath = System.getProperty("java.library.path");
                logger.info("java.library.path--->" + allLibraryPath);
                opencvpath = System.getProperty("catalina.home") + "\\webapps\\hhipsair\\WEB-INF\\classes";
                logger.info("catalina.home--->" + opencvpath);
            }
            opencvpath = opencvpath + "\\static";
            if (osName.startsWith("Windows")) {
                int bitness = Integer.parseInt(System.getProperty("sun.arch.data.model"));
                if (bitness == 32) {
                    opencvpath = opencvpath + "\\opencv\\x86\\";
                } else if (bitness == 64) {
                    opencvpath = opencvpath + "\\opencv\\x64\\";
                } else {
                    opencvpath = opencvpath + "\\opencv\\x86\\";
                }
            } else if (osName.equals("Mac OS X")) {
                opencvpath = opencvpath + "Your path to .dylib";
            }
            logger.info(opencvpath + Core.NATIVE_LIBRARY_NAME + ".dll");
            System.load(opencvpath + Core.NATIVE_LIBRARY_NAME + ".dll");

            OpenCV.loadShared();

            logger.info("------------------load opencv done!--------");
        } catch (Exception e) {
            logger.error("opencv cannot work since load library failed.");
        }
        String pp = env.getProperty("web.upload.path");
        FileHelper.setAbsolutePath(pp);
    }

    @CrossOrigin
    @PostMapping("/auto/pdf")
    public @ResponseBody
    String processPDF(@RequestBody String pdfFile) {
        FileHelper.deleteAllFileInAbsPath(FileHelper.getAbsolutePath() + CUTTER_PATH_NAME);
        logger.info("processPDF ......");
        String fileName = "doc.pdf";
        FileHelper.saveBase64AsPDFFile(pdfFile, CUTTER_PATH_NAME, fileName);
        logger.info("render PDF to image ......");
        PDFProcessor pdfProcessor = new PDFProcessor();
        pdfProcessor.renderPage2Image(fileName, CUTTER_PATH_NAME, "page");

        logger.info("cutting image ...");
        String res = cutAllImageInPath(FileHelper.getAbsolutePath() + CUTTER_PATH_NAME);
        return res;
    }

    @CrossOrigin
    @PostMapping("/auto/png")
    public @ResponseBody
    String processPNG(@RequestBody String pngFileList) {
        FileHelper.deleteAllFileInAbsPath(FileHelper.getAbsolutePath() + CUTTER_PATH_NAME);
        FileHelper.deleteAllFileInAbsPath("D:\\javacode\\hhips\\web\\editor-air\\static\\cutter\\");
        logger.info("process PNG ......");
        JSONArray arr = new JSONArray(pngFileList);
        for(int i = 0; i < arr.length(); i++){
            String fileBase64 = (String)arr.get(i);
            String fileName = "page" + Integer.toString(i) + ".tif";
            FileHelper.saveBase64AsTifFile(fileBase64, CUTTER_PATH_NAME, fileName);
        }

        logger.info("cutting image ...");
        String res = cutAllImageInPath(FileHelper.getAbsolutePath() + CUTTER_PATH_NAME);
        return res;
    }

    @CrossOrigin
    @PostMapping("/auto/delete")
    public @ResponseBody
    String deleteBlock(@RequestBody String blockList) {
        logger.info("process delete request ......" + blockList);
        JSONArray arr = new JSONArray(blockList);
        List<String> allWaitMergeList = new ArrayList<>();
        for(int i = 0; i < arr.length(); i++){
            String filePathName = (String)arr.get(i);
            String fileName = filePathName.substring(filePathName.lastIndexOf("/") + 1);
            allWaitMergeList.add(fileName);
            FileHelper.deleteOneFile(FileHelper.getAbsolutePath() + CUTTER_PATH_NAME + fileName);
        }
        return "done";
    }

    @CrossOrigin
    @PostMapping("/auto/merge")
    public @ResponseBody
    String mergeBlock(@RequestBody String blockList) {
        logger.info("process Merge request ......");
        JSONArray arr = new JSONArray(blockList);
        List<String> allWaitMergeList = new ArrayList<>();
        for(int i = 0; i < arr.length(); i++){
            String filePathName = (String)arr.get(i);
            String fileName = filePathName.substring(filePathName.lastIndexOf("/") + 1);
            allWaitMergeList.add(fileName);
        }
        ImageMerger imageMerger = new ImageMerger();
        imageMerger.doMerge(allWaitMergeList);
        return "done";
    }

    @CrossOrigin
    @PostMapping("/auto/create")
    public @ResponseBody
    String submitAllProblems(@RequestBody BatchNewRequest[] allRequest) {
        logger.info(allRequest.toString());
        for(int i = 0; i < allRequest.length; i++) {
            BatchNewRequest curRequest = allRequest[i];
            Problem curProblem = new Problem();
            curProblem.setProblemindex(curRequest.getIndex());
            curProblem.setProblemchapterid(curRequest.getChapter());
            curProblem.setProblemmodule(curRequest.getModule());
            curProblem.setProblemlevel(curRequest.getLevel());
            int newPId = dbProblem.insertProbelm(curProblem);
            if (newPId == 0) {
                return "save failed";
            }
            curProblem.setIdproblem(newPId);
            String targetFileName = FileHelper.getImageDBName("p", newPId);
            curProblem.setProblemdetail(targetFileName);
            targetFileName = FileHelper.getAbsolutePath() + targetFileName;
            String sourceFileName = curRequest.getImg();
            sourceFileName = sourceFileName.substring(sourceFileName.lastIndexOf("/")+1);
            sourceFileName = FileHelper.getAbsolutePath() + "cutter\\" + sourceFileName;
            Path sourcePath      = Paths.get(sourceFileName);
            Path destinationPath = Paths.get(targetFileName);
            try {
                Files.copy(sourcePath, destinationPath);
            } catch (IOException e) {
                e.printStackTrace();
                logger.error(e.toString());
            }

            targetFileName = FileHelper.getImageDBName("a", newPId);
            curProblem.setProblemanswerdetail(targetFileName);
            targetFileName = FileHelper.getAbsolutePath() + targetFileName;
            destinationPath = Paths.get(targetFileName);
            try {
                Files.copy(sourcePath, destinationPath);
            } catch (IOException e) {
                e.printStackTrace();
                logger.error(e.toString());
            }

            dbProblem.updateProbelm(curProblem);
        }
        return "done";
    }

    @CrossOrigin
    @GetMapping("/auto/list")
    public  @ResponseBody
    List<String> getPartList() {
        ArrayList<String> allPartList = new ArrayList<>();
        String[] paths;
        try {
            File f = new File(FileHelper.getAbsolutePath() + CUTTER_PATH_NAME);

            FilenameFilter filter = new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    if (name.endsWith(".png") == false && name.endsWith(".tif") == false) {
                        return false;
                    }
                    if (name.startsWith("part") == true) {
                        return true;
                    }
                    return false;
                }
            };

            paths = f.list(filter);

            for (String fileName : paths) {
                allPartList.add("/static/cutter/" + fileName);
            }
        } catch (Exception e) {
            logger.error(e.toString());
        }
        return allPartList;
    }

    private String cutAllImageInPath(String pathName) {
        String[] paths;
        String result = "";

        try {
            // create new file
            File f = new File(pathName);

            // create new filter
            FilenameFilter filter = new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    if (name.endsWith(".png") == false && name.endsWith(".tif")==false) {
                        return false;
                    }
                    if (name.startsWith("page") == true) {
                        return true;
                    }
                    return false;
                }
            };

            paths = f.list(filter);

            ImageCutter imageCutter = new ImageCutter();
            imageCutter.isDebug = true;
            for(String fileName:paths) {
                logger.info("do cut --->" + pathName + fileName);
                imageCutter.doCut(pathName + fileName);
                logger.info("do cut done --->" + pathName + fileName + " line height = " + Integer.toString(imageCutter.lineHeight));
                result = result + "-" + Integer.toString(imageCutter.lineHeight);
            }

        } catch(Exception e) {
            // if any error occurs
            e.printStackTrace();
            logger.error(e.toString());
        }
        return result;
    }
}
