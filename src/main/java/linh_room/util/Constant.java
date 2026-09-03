package linh_room.util;

import java.io.File;

public class Constant {

    public static final String UPLOAD_DIR = System.getProperty("linhroom.upload.dir", "C:\\upload");

    public static String getCategoryUploadDir() {
        String dir = UPLOAD_DIR + File.separator + "category";
        File folder = new File(dir);
        if (!folder.exists()) {
            folder.mkdirs();
        }
        return dir;
    }

    public static String getUserUploadDir() {
        String dir = UPLOAD_DIR + File.separator + "user";
        File folder = new File(dir);
        if (!folder.exists()) {
            folder.mkdirs();
        }
        return dir;
    }
}