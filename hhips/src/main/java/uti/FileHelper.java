package uti;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

public class FileHelper {
	public static String absolutePath = "";
	
	private static String getFilePathName() {
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String day = dateFormat.format(date);
		dateFormat = new SimpleDateFormat("yyyyMM");
		String month = dateFormat.format(date);

		Path path = Paths.get(absolutePath + month);
		System.out.println(absolutePath + month);

		File directory = new File(absolutePath + month);
		if (! directory.exists()){
			directory.mkdir();
			System.out.println("Path created -- " + absolutePath + month);
		}

		return month + "\\" + day + "_";
	}
	
	private static boolean saveImageFile(byte[] data, String fileName) {
		try {
			DataOutputStream fos = new DataOutputStream(new FileOutputStream(absolutePath + fileName));

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
		saveImageFile(decodedDetail, filePathName);
		return filePathName;
	}
}
