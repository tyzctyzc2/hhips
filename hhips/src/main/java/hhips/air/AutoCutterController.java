package hhips.air;

import editor.CutPartData;
import editor.ImageCutter;
import editor.PDFProcessor;
import nu.pattern.OpenCV;
import org.opencv.core.Core;
import editor.ImageCutter;
import editor.PDFProcessor;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import uti.FileHelper;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.List;

@Controller
public class AutoCutterController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AutoCutterController.class);

    static final String CUTTER_PATH_NAME = "cutter\\";

    @PostConstruct
    public void init() {
        try {
            logger.info("------------------load opencv start--------");
            String osName = System.getProperty("os.name");
            //String opencvpath = System.getProperty("java.library.path");
            //String opencvpath = FileHelper.absolutePath;
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
    }

    @CrossOrigin
    @PostMapping("/auto/pdf")
    public @ResponseBody
    String processPDF(@RequestBody String pdfFile) {
        FileHelper.deleteAllFile(CUTTER_PATH_NAME);
        logger.info("processPDF ......");
        String fileName = "doc.pdf";
        FileHelper.saveBase64AsBinaryFile(pdfFile, CUTTER_PATH_NAME, fileName);
        logger.info("render PDF to image ......");
        PDFProcessor pdfProcessor = new PDFProcessor();
        pdfProcessor.renderPage2Image(fileName, CUTTER_PATH_NAME, "page");

        logger.info("cutting image ...");
        cutAllImageInPath(FileHelper.absolutePath + CUTTER_PATH_NAME);
        return "pending...";
    }

    @CrossOrigin
    @GetMapping("/auto/list")
    public  @ResponseBody
    List<String> getPartList() {
        ArrayList<String> allPartList = new ArrayList<>();
        String[] paths;
        try {
            File f = new File(FileHelper.absolutePath + CUTTER_PATH_NAME);

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
                allPartList.add("\\cutter\\" + fileName);
            }
        } catch (Exception e) {
            logger.error(e.toString());
        }
        return allPartList;
    }

    private void cutAllImageInPath(String pathName) {
        String[] paths;

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
            //imageCutter.isDebug = true;
            for(String fileName:paths) {
                logger.info("do cut --->" + pathName + fileName);
                imageCutter.doCut(pathName + fileName);
            }

        } catch(Exception e) {
            // if any error occurs
            e.printStackTrace();
            logger.error(e.toString());
        }
    }
}
