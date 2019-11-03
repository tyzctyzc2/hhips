package hhips.air;

import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import uti.FileHelper;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

@Controller
public class ImageController extends MyBaseController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(ImageController.class);

    @PostMapping("/image/rotate")
    public @ResponseBody
    String rotateImage(Model model, @RequestParam(value="imagename", required=true, defaultValue="") String imageName) {
        logger.info("ImageController - [rotateImage] request " + imageName);
        //System.out.println("ImageController - [rotateImage] request " + imageName);
        String fullName = FileHelper.getAbsolutePath() + imageName.substring(0, 6) + "/" + imageName.substring(0, 6) + imageName.substring(10);

        logger.info("ImageController - [rotateImage] request " + fullName);

        doRotate(fullName);
        JSONObject res = new JSONObject();

        res.append("1", true);
        return res.toString();
    }

    void doRotate(String fileName) {
        try {
            BufferedImage originalImage = ImageIO.read(new File(fileName));
            // The required drawing location
            final double rads = Math.toRadians(90);
            final double sin = Math.abs(Math.sin(rads));
            final double cos = Math.abs(Math.cos(rads));
            final int w = (int) Math.floor(originalImage.getWidth() * cos + originalImage.getHeight() * sin);
            final int h = (int) Math.floor(originalImage.getHeight() * cos + originalImage.getWidth() * sin);
            BufferedImage rotatedImage = new BufferedImage(w, h, originalImage.getType());
            final AffineTransform at = new AffineTransform();
            at.translate(w / 2, h / 2);
            at.rotate(rads,0, 0);
            at.translate(-originalImage.getWidth() / 2, -originalImage.getHeight() / 2);
            final AffineTransformOp rotateOp = new AffineTransformOp(at, AffineTransformOp.TYPE_BILINEAR);
            BufferedImage after = new BufferedImage(w, h, originalImage.getType());
            rotatedImage = rotateOp.filter(originalImage,after);

            File outputfile = new File(fileName);
            ImageIO.write(rotatedImage, "png", outputfile);
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }

    }
}
