package cn.gwj.PlantDetect;

import java.io.File;
import java.io.FileInputStream;
import java.sql.SQLException;


/**
 * Hello world!
 *
 */
public class App 
{

    public static void main( String[] args )
    {
    	final int rMAX = 2*240*256+100;
    	byte[] Buffer = new byte[rMAX];//接收数据缓存1024字节
        try {
        	FileInputStream in=new FileInputStream(new File("1.jpg"));
//            String sql = "update photo set name=DATE_ADD(NOW(),INTERVAL 8 HOUR),photo=? where id=?";
        	int lenth=in.read(Buffer);
        	//String s=Buffer.toString();
        	System.out.println(" sdfgv "+lenth);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
