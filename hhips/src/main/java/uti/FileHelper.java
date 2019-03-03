package uti;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

@PropertySource("classpath:application.properties")
public class FileHelper {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(FileHelper.class);

	@Autowired
	static private Environment env;

    public static String getAbsolutePath() {
        return absolutePath;
    }

	public static void setAbsolutePath(String absolutePath) {
		FileHelper.absolutePath = absolutePath;
	}

	@Value("${web.upload.path}")
	static String absolutePath = "";

    public static void getRootPath() {
    	absolutePath = env.getProperty("web.upload.path");
	}

	public static String getFilePathName() {
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String day = dateFormat.format(date);
		dateFormat = new SimpleDateFormat("yyyyMM");
		String month = dateFormat.format(date);

		Path path = Paths.get(absolutePath + month);
		System.out.println(absolutePath + month);

		ensurePathExist(month);

		return month + "\\" + day + "_";
	}

	public static String getImageDBName(String typeString, int fileID) {
		String filePathName = getFilePathName() + typeString + Integer.toString(fileID) + ".png";
		return  filePathName;
	}

	private static void ensurePathExist(String pathName) {
		File directory = new File(absolutePath+pathName);
		if (! directory.exists()){
			directory.mkdir();
			System.out.println("Path created -- " + absolutePath + pathName);
		}
	}

	private static boolean saveTextFile(String msg, String fileName) {
		try {
			DataOutputStream fos = new DataOutputStream(new FileOutputStream(absolutePath + fileName));
			fos.writeChars(msg);
			fos.flush();
			fos.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}

		return true;
	}
	
	private static boolean saveBinaryFile(byte[] data, String fileName) {
		try {
			logger.info("start save :" + absolutePath + fileName);
			DataOutputStream fos = new DataOutputStream(new FileOutputStream(absolutePath + fileName));
			logger.info("save :" + absolutePath + fileName);
			fos.write(data, 0, data.length);
			fos.flush();
			fos.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}

		return true;
	}
	
	public static String getBase64String(String fileName) {
		String res = "";
		try {
			File file = new File(absolutePath + fileName);
		    byte[] fileData = new byte[(int) file.length()];
		    DataInputStream dis = new DataInputStream(new FileInputStream(file));
		    dis.readFully(fileData);
		    dis.close();
		    
		    res = Base64.getEncoder().encodeToString(fileData);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();			
		}
		return res;
	}
	
	public static String saveBase64File(String base64String, String typeString, int fileID) {
		byte[] decodedDetail = Base64.getDecoder().decode(base64String);
		String filePathName = getFilePathName() + typeString + Integer.toString(fileID) + ".png";
		saveBinaryFile(decodedDetail, filePathName);
		return filePathName;
	}

	public static void saveBase64AsTifFile(String base64String, String pathName, String fileName) {
        int startIndex = base64String.indexOf("base64")+7;
        base64String = base64String.substring(startIndex);
        try {
            base64String = java.net.URLDecoder.decode(base64String, "UTF-8");
            base64String = base64String.replace(" ", "+");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        while (base64String.charAt(base64String.length()-1) == '=') {
            base64String = base64String.substring(0, base64String.length() - 1);
        }
        byte[] decodedDetail = Base64.getDecoder().decode(base64String);
        ensurePathExist(pathName);
        String filePathName = pathName + fileName;
        saveBinaryFile(decodedDetail, filePathName);
    }

	public static void saveBase64AsPDFFile(String base64String, String pathName, String fileName) {
		int startIndex = base64String.indexOf("base64")+9;
		base64String = base64String.substring(startIndex);
		try {
			base64String = java.net.URLDecoder.decode(base64String, "UTF-8");
			base64String = base64String.replace(" ", "+");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		while (base64String.charAt(base64String.length()-1) == '=') {
			base64String = base64String.substring(0, base64String.length() - 1);
		}
		byte[] decodedDetail = Base64.getDecoder().decode(base64String);
		ensurePathExist(pathName);
		String filePathName = pathName + fileName;
		saveBinaryFile(decodedDetail, filePathName);
	}

	public static String updateBase64File(String base64String, String fileName) {
		byte[] decodedDetail = Base64.getDecoder().decode(base64String);
		saveBinaryFile(decodedDetail, fileName);
		return fileName;
	}

	public static void deleteOneFile(String fileName) {
		File file = new File(fileName);
		file.delete();
	}

	public static void deleteAllFileInAbsPath(String pathName) {
        String[] paths;
        try {
            // create new file
            File f = new File(pathName);

            // create new filter
            FilenameFilter filter = new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    return true;
                }
            };

            paths = f.list(filter);

            for(String fileName:paths) {
                File file = new File(pathName+fileName);
                file.delete();
            }

        } catch(Exception e) {
            // if any error occurs
            e.printStackTrace();
            logger.error(e.toString());
        }
    }
}
