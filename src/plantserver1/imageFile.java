package plantserver1;
import java.io.*;

public class imageFile {
	public static void write(String filename, byte buffer[],int lent) {
    	byte header2[]= {
    			0x42,0x4D,0x48,(byte)0xE0,0x01,0x00,0x00,0x00,0x00,0x00,0x46,0x00,0x00,0x00,0x38,0x00,
    			0x00,0x00,(byte)0xF0,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x01,0x00,0x10,0x00,0x03,0x00,
    			0x00,0x00,0x02,(byte)0xE0,0x01,0x00,0x12,0x0B,0x00,0x00,0x12,0x0B,0x00,0x00,0x00,0x00,
    			0x00,0x00,0x00,0x00,0x00,0x00,0x00,(byte)0xF8,0x00,0x00,(byte)0xE0,0x07,0x00,0x00,0x1F,0x00,
    			0x00,0x00,0x00,0x00,0x00,0x00		 			
    	};//正确的头部信息
    	byte header[]={0x42,0x4D,//0x00,0x00,
    			0x36,(byte)0xe0,0x01,0x00,//总的文件大小
    			0x00,0x00,0x00,0x00,
    			0x36,0x00,0x00,0x00,//真正数据的位置
    			0x28,0x00,0x00,0x00,//第二部分的大小
    			(byte)0xF0,0x00,0x00,0x00,//240 宽
    			0x00,0x01,0x00,0x00,//高 320：40，01 256：00，01
    			0x01,0x00,//1，不用管
    			0x10,0x00,//24色0x18   16色：0x10
    			0x00,0x00,0x00,0x00,0x00,0x00,
    			0x00,0x00,0x00,0x00,
    			0x00,0x00,0x00,0x00,
    			0x00,0x00,0x00,0x00,
    			0x00,0x00,0x00,0x00,
    			0x00,0x00};	//,0x19,(byte)0xE3
    	File file=new File(filename);

        if(!file.exists()){     
            try {
                file.createNewFile();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }            
        }
     //   System.out.println(image.length);
    	try {
 //       	File rfile=new File("2.bmp");
//            byte[]  readbuff=new byte[buffer.length];  
//            int hasRead=0;  
//       	    RandomAccessFile myFile=new RandomAccessFile(rfile,"rw");
//	        myFile.seek(56);  //绉诲姩鍒版枃浠剁粨灏�
//	        hasRead=myFile.read(readbuff, 0, 230400);
//	        System.out.println(readbuff.length+"    "+hasRead);
//	        System.out.println(readbuff[0]);
//	        myFile.close();
    		//鍐欏叆
			FileOutputStream out = new FileOutputStream(file);
			out.write(header2);
			out.write(buffer, 0, lent);	
			out.close();
		} catch (FileNotFoundException e) {
			// TODO 鑷姩鐢熸垚鐨� catch 鍧�
			System.out.println("无此文件\r\n");
			e.printStackTrace();
		}
    	catch(Exception e) {
    		System.out.println(e.getMessage());
    		
    	}
		
		
	}
	public static void writejpg(String filename, byte buffer[],int lent) {

    	File file=new File(filename);
        if(!file.exists()){     
            try {
                file.createNewFile();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }            
        }
     //   System.out.println(image.length);
    	try {
			FileOutputStream out = new FileOutputStream(file);
	//		out.write(header2);
			out.write(buffer, 0, lent);	
			out.close();
		} catch (FileNotFoundException e) {
			// TODO 鑷姩鐢熸垚鐨� catch 鍧�
			System.out.println("无此文件\r\n");
			e.printStackTrace();
		}
    	catch(Exception e) {
    		System.out.println(e.getMessage());
    		
    	}
		
		
	}
}
