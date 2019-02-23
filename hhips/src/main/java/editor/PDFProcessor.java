package editor;

import hhips.air.AutoCutterController;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.slf4j.LoggerFactory;
import uti.FileHelper;

import java.awt.image.BufferedImage;
import java.io.File;

public class PDFProcessor {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(PDFProcessor.class);

    public void renderPage2Image(String fileName, String pathName, String imageName) {
        try {
            String pdfFilename = FileHelper.getAbsolutePath() + pathName + fileName;
            PDDocument document = PDDocument.load(new File(pdfFilename));
            PDFRenderer pdfRenderer = new PDFRenderer(document);
            for (int page = 0; page < document.getNumberOfPages(); ++page) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(page, 300, ImageType.RGB);

                String pageName = FileHelper.getAbsolutePath() + pathName + imageName + "_" + (page + 1) + ".png";
                ImageIOUtil.writeImage(bim, pageName, 300);
                logger.info("done with " + pageName);
            }
            document.close();
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }
    }
}
