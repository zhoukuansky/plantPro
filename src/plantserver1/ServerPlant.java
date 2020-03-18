package plantserver1;

import cn.gwj.image.file.*;

import java.io.*;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.*;


import java.lang.*;
import java.util.regex.*;

import javax.websocket.Session;

import plantserver1.mysql;
import webSocketTest.MyWebSocket;
import plantserver1.imageFile;


//class Works extends TimerTask{
//	public Timer t;
//	public String TName;
//	/**
//	 * 构造方法，获取需要暂停的任务
//	 * @param t1
//	 */
//	public Works(Timer t1) {
//		// TODO Auto-generated constructor stub
//		this.t = t1;
//	}
//	@Override
//	public void run() {
//		// TODO Auto-generated method stub
//		if(iTimerCount_100ms++> 10)
//		{						
//			iTimerCount_100ms = 0;
//			System.out.println(iTimerCount_100ms);					
//			// 断开 tcp 连接 
//		//	CloseTcpConnect();	
//		}
//		//can2();
//	}
//}
 
public class ServerPlant implements Runnable {
    public final static int DEFAULT_PORT = 30064;
    public  static ServerSocket listen_socket=null;
    private  static int algin=0;
    Socket socket=null;
	InputStream inputStream = null; 

	Session session=null;
	String DiviceID="";
	InputStreamReader in1=null;   
	OutputStreamWriter out=null;
	static int imagenum=1;
    static int LinkNum=0;
    static Date day=new Date();    
	private static final int rMAX = 480*520;
	private byte[] rTotalBuffer = new byte[rMAX];//接收数据缓存1024字节
	private int rTotalBufferIdex = 0;
	
	TimerTask timerTask = null;
	Timer rssiTimer=null;
	int iTimerCount_100ms = 0;  		//定时器计数	
	static int hulf=0;
	
 //   static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
    public static synchronized void setAlgin(int i) {
    	ServerPlant.algin=i;
    }
    public static synchronized int getAlgin() {
    	return ServerPlant.algin;
    }
    public ServerPlant(Socket ss,Session session1,String id) {
          socket=ss;
          session=session1; 
          DiviceID=id;
    }
	public static int byteArrayToInt(byte[] b, int offset) {
	       int value= 0;
	       for (int i = 0; i < 4; i++) {
	           int shift= (4 - 1 - i) * 8;
	           value +=(b[i + offset] & 0x000000FF) << shift;
	       }
	       return value;
	 }	
    // 断开 tcp 连接 
    private void CloseTcpConnect()
    {
    	try {
			if(inputStream != null)
			{
				inputStream.close();
				in1.close();
				out.close();
				out=null;
				inputStream = null;
				in1=null;
			}
			if(socket != null)
			{
				socket.close();
				socket = null;
			}					
		//	System.out.println("超时关闭TCP");
			rTotalBufferIdex = 0;			
		}
    	catch (SocketException e1) {
			// TODO 自动生成的 catch 块 
    	//	System.out.println("123");
			e1.printStackTrace();
		} 
    	catch (IOException e1) {
			// TODO 自动生成的 catch 块 
			e1.printStackTrace();
		}  		
    }
    public void ListenTimer()
    {
    	timerTask = new TimerTask() {
			@Override
			public void run() { // 定时器到 处理函数
				if(iTimerCount_100ms++> 10)
				{						
					iTimerCount_100ms = 0;
	//				System.out.println(iTimerCount_100ms);	
					CloseTcpConnect();
					rssiTimer.cancel();
					// 断开 tcp 连接 	
				}
			}
		};
		rssiTimer = new Timer();
		rssiTimer.schedule(timerTask, 100, 3000);   // 定时器启动 100ms
    }
    private synchronized boolean CheckDataFromRemote(byte buffer[], int lenght)
    {
    	boolean fileFlag = false;
			if(lenght == 1390) // jpeg 数据
			{				
				if(rTotalBufferIdex + (lenght) > rMAX)
				{
					rTotalBufferIdex = 0;
				}
				else
				{
					System.arraycopy(buffer, 0, rTotalBuffer, rTotalBufferIdex, lenght);
					rTotalBufferIdex += lenght;
				}				
			}
			else if(lenght < 1390) // 数据结束
			{			
				if(rTotalBufferIdex + (lenght) > rMAX)
				{
					// 已超出缓冲区大小 
					rTotalBufferIdex = 0;
				}
				else
				{
					System.arraycopy(buffer, 0, rTotalBuffer, rTotalBufferIdex, lenght);
					rTotalBufferIdex += lenght;	
//					System.out.println("file length["+imagenum+"]:"+rTotalBufferIdex);
				//	if(rTotalBufferIdex==122880)
					fileFlag = true;					
				}
			}
			// 显示图像
			if(fileFlag)
			{
			//	System.out.println("接收到图像");
		//		imageFile.write(imagenum+".bmp", rTotalBuffer,rTotalBufferIdex);
				SimpleDateFormat sDateFormat=new SimpleDateFormat("yyyy-MM-dd hh-mm-ss");     
				String date = sDateFormat.format(new java.util.Date());	
//				System.out.println("Time"+date+":捕获到图像"+rTotalBufferIdex);
//				imageFile.writejpg(this.getClass().getClassLoader().getResource("../../images/"+1+".jpg").getPath(), rTotalBuffer,rTotalBufferIdex);
            	try {           		
            		OutputStream outWeb=session.getBasicRemote().getSendStream();
    	        	outWeb.write(rTotalBuffer,0,rTotalBufferIdex);
    	        	outWeb.flush();
    	        	outWeb.close();
    	        	int i=ServerPlant.getAlgin();
    	        	if(i>0&&i<5) {
    	        		out.write((63+i)+"\r\n");
    	        		ServerPlant.setAlgin(0);
    	        	}
    	        	else {
					out.write("55\r\n");
    	        	}
					out.flush(); 
				}catch(IllegalStateException e){
		        	try {
						socket.close();
					} catch (IOException e1) {
						// TODO 自动生成的 catch 块
						e1.printStackTrace();
					}					
				}
            	catch (IOException e) {
					// TODO 自动生成的 catch 块
				//	e.printStackTrace();
				}
	        	
//				if(mysql.readSql("SELECT  AuTo FROM Node1_Control where Class=\'photo\';").equals("1;")){
//					mysql.CMD("UPDATE Node1_Control SET AuTo=0 WHERE Class='photo';");
//					ImageDemo.updataImage2DB("1.jpg",1);	
//				}
//				else {
//			        ImageDemo.readImage2DB("1.jpg");		
//				}
//		        readDB2Image("images/gwj.jpg","Tom");
				//imagenum++;
			}
		return fileFlag;
    }   
    public static void videServer(Session session1,String id) {

    	TimerTask timerTask = new TimerTask() {
			@Override
			public void run() { // 定时器到 处理函数
				if(hulf++> 9)
				{						
					hulf = 0;
					System.out.println("时间到了");	
				}
			}
		};
		Timer rssiTimer = new Timer();
		//	rssiTimer.schedule(timerTask, 0, 1000);   // 定时器启动 100ms	
		
	    	try {
	    		if(listen_socket==null) {
	    			listen_socket = new ServerSocket(DEFAULT_PORT);
			        listen_socket.setSoTimeout(30000);
	    		}	    					        	
		    		new Thread(){
		    			public void run() {
		    				try {
		    					System.out.println("START1");
			    				Socket socket=listen_socket.accept();
			    	//			System.out.println("START2");
					        	Thread thread = new Thread(new ServerPlant(socket,session1,id));
					        	LinkNum++;
//								SimpleDateFormat sDateFormat1=new SimpleDateFormat("yyyy-MM-dd hh-mm-ss");     
//								String date1 = sDateFormat1.format(new java.util.Date());	
//								System.out.println(date1+"	LinkNum:"+ LinkNum);
					            thread.start();
		    				}
		    		    	catch(SocketTimeoutException s) {
		    		    		System.out.println("Socket timed out!");    		
		    		    	}
			    		      catch(IOException e) {
			    	        	  e.printStackTrace();     	  
			    	          }  
		    			}
		    		}.start();
		    //	System.out.println("START");
	        }  
	    	catch(SocketTimeoutException s) {
	    		System.out.println("Socket timed out!");    		
	    	}
	      catch(IOException e) {
        	  e.printStackTrace();     	  
          }  
    	}
    public void run() {
    	char test[]=new char[10];
    	byte test1[]=new byte[10];
	    ListenTimer();
//		System.out.println(this.getClass().getClassLoader().getResource("../../images/"+1+".jpg").getPath());
        try {
//        	System.out.println("start");        	
        	inputStream=socket.getInputStream();  
    		in1=new InputStreamReader(inputStream,"GB2312");
    		out=new OutputStreamWriter(socket.getOutputStream(),"GB2312");	
    		String s1=DiviceID+"HP",s2=DiviceID+"PB";
    		System.out.println(s1+s2);
        	while(true){
        		if((inputStream.read(test1, 0, 10))!=-1) {
        			iTimerCount_100ms=0;
//        			System.out.println(test1);
                	for(int i = 0; i < test1.length; i++) {//循环将char数组的每一个元素转换为byte并存在上面定义的byte数组中
                	char b = (char) test1[i];//将每一个char转换成byte
                	test[i] = b;//保存到数组中
                	}
        			String Diviceid=String.valueOf(test, 0,10);//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	            		if(Diviceid.equals(s2) ) {//接收图像
	                    	byte buffer1[] = new byte[1390];
	                    	int length=inputStream.read(buffer1);
//        					System.out.println("recive length: "+length);
        					CheckDataFromRemote(buffer1,length);	            				            			
	            		}
	            		else if(Diviceid.equals(s1) ) {//接收图像头
	            			rTotalBufferIdex = 0;
	                    	byte buffer1[] = new byte[1390];
	                    	int length=inputStream.read(buffer1);
//        					System.out.println("recive length: "+length);
        					CheckDataFromRemote(buffer1,length);	
	            		}
	            		else{//接受错误
	            			rTotalBufferIdex = 0;
	            			byte buffer1[] = new byte[1390];
	                    	int length=inputStream.read(buffer1);
	    					System.out.println("接收错误 "+length);
			            	out.write("S:NO\r\n");
				        	out.flush(); 
	    				//	CheckDataFromRemote(buffer,length);
	            		}
            		}
		    	else {//socket读错误
		    	//	System.out.println("Socket colse");
		    		break;
		    	}	        		
        	}
        	rssiTimer.cancel();
        	in1.close();
        	out.close();
        	inputStream.close();
        	socket.close();
//        	System.out.println(df.format(day)+" "+"LinkNum:"+ LinkNum);
        }catch (SocketException e) {
           // e.printStackTrace(); 
        	System.out.println("超时关闭");
        } 
        catch (Exception e) {
            e.printStackTrace();        
        }
	    mysql.CMD("update Node1_Control set AuTo=0 where diviceID='"+DiviceID+"' and Class='vide';");
    	LinkNum--;
    }
}

