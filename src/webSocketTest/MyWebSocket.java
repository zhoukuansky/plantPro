package webSocketTest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.concurrent.CopyOnWriteArraySet;
 
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
 
import plantserver1.*;

//该注解用来指定一个URI，客户端可以通过这个URI来连接到WebSocket。类似Servlet的注解mapping。无需在web.xml中配置。
@ServerEndpoint("/websocket")
public class MyWebSocket {
    //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
    private static int onlineCount = 0;
     
    //concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
    private static CopyOnWriteArraySet<MyWebSocket> webSocketSet = new CopyOnWriteArraySet<MyWebSocket>();

    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;
    private String id="";
     
    /**
     * 连接建立成功调用的方法
     * @param session  可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    @OnOpen
    public void onOpen(Session session){
        this.session = session;
        webSocketSet.add(this);     //加入set中
        addOnlineCount();           //在线数加1
        System.out.println("有新连接加入！当前在线人数为" + getOnlineCount());
    }
     
    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(){
        webSocketSet.remove(this);  //从set中删除
        subOnlineCount();           //在线数减1   
        mysql.CMD("update DiviceStatus set vide=0 where diviceID='"+id+"';"
        		+ "update Node1_Control set AuTo=0 where diviceID='"+id+"' and Class='vide';");
        System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
    }
     
    /**
     * 收到客户端消息后调用的方法
     * @param message 客户端发送过来的消息
     * @param session 可选的参数
     */
    @OnMessage
    public void onMessage(String message, Session session) {
//        System.out.println("来自客户端的消息:" + message);
    	byte[] Buffer = new byte[2*640*480+100];//接收数据缓存1024字节 
    	if(message.length()==1) {
    		ServerPlant.setAlgin(Integer.valueOf(message));
    	}
    	else if(message.indexOf("capture")==0) {
//    		System.out.println("");
//        	System.out.println(message);
    		id=message.substring(8);
//    		System.out.println(id);
//    		System.out.println(id+":122");
    		mysql.CMD("update DiviceStatus set vide=1 where diviceID='"+id+"';"
    				+ "update Node1_Control set AuTo=1 where diviceID='"+id+"' and Class='vide';");
  	       ServerPlant.videServer(this.session,id);
  	   //  session.getBasicRemote().
//	//	        	ServerPlant.videServer(out);
//	  	    	  for(int i=0;i<9;i++) { 
//	  	        	FileInputStream in=new FileInputStream(new File(this.getClass().getClassLoader().getResource("../../images/"+(i+1)+".jpg").getPath()));
//	     // 	        	FileInputStream in=new FileInputStream(new File("1.jpg"));
//	  	      	//          String sql = "update photo set name=DATE_ADD(NOW(),INTERVAL 8 HOUR),photo=? where id=?";
//	  	      	        	int lenth=in.read(Buffer);
//	//  	      	        	ServerPlant.videServer(out);
//	  			        	OutputStream out=this.session.getBasicRemote().getSendStream();
//	  	      	        	out.write(Buffer,0,lenth);
//	  	      	        	out.flush();  
//                            out.close();
//	  	      	        	in.close();
//	  	      	        	Thread.sleep(200);
//	  	    	  }
//	  	        	 
//    		  } catch (IOException | InterruptedException  e) {
//    		      e.printStackTrace();
//    		      //System.out.println(e.getMessage());
//    		  }        	
        }
        //群发消息       
//        for(MyWebSocket item: webSocketSet){             
//            try {
//                item.sendMessage(message);
//            } catch (IOException e) {
//                e.printStackTrace();
//                continue;
//            }
//        }
    }
     
    /**
     * 发生错误时调用
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error){
    //    System.out.println("发生错误");
        mysql.CMD("update DiviceStatus set vide=0 where diviceID='"+id+"';"
        		+ "update Node1_Control set AuTo=0 where diviceID='"+id+"' and Class='vide';");
    //    error.printStackTrace();
    }
     
    /**
     * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。
     * @param message
     * @throws IOException
     */
    public void sendMessage(String message) throws IOException{
        this.session.getBasicRemote().sendText(message);
        //this.session.getAsyncRemote().sendText(message);
    }
 
    public static synchronized int getOnlineCount() {
        return onlineCount;
    }
 
    public static synchronized void addOnlineCount() {
        MyWebSocket.onlineCount++;
    }
     
    public static synchronized void subOnlineCount() {
        MyWebSocket.onlineCount--;
    }
}