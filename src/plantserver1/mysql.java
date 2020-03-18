package plantserver1;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;


public class mysql{
	     static String url="jdbc:mysql://10.4.208.78:32409/plant?useSSL=false&useUnicode=true&characterEncoding=utf8";	
	//static String url = "jdbc:mysql://39.108.74.92:32686/plant?useSSL=false&useUnicode=true&characterEncoding=utf8";
	     static int LinkNum=0;
	     static Date day=new Date();  
	     static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	     
	     @SuppressWarnings("finally")
		static  public String readSql(String cmd) {
		        String sql;
		        Statement stmt=null;
		        Connection con=null;
		        ResultSet rs=null;
		        String reback="";
		        try {
			        	Class.forName("com.mysql.jdbc.Driver");	
			        	con=DriverManager.getConnection(url,"root","123456");
			        	stmt=con.createStatement();
			        //	sql="SELECT  * FROM Node1_Control";
			        	sql=cmd;
			        	rs=stmt.executeQuery(sql);
			        	String s1,s2="";
			        	int a=rs.getMetaData().getColumnCount();
			        	while(rs.next()) {
			        		s1="";
			        		for(int i=0;i<a;i++) {
			        			if(i==a-1)
			        			s1=s1+rs.getString(i+1)+";";
			        			else
			        			s1=s1+rs.getString(i+1)+' ';
			        		}	        		
			        	//	System.out.println(s1);
			        		s2=s2+s1;
		                } 
			        //	System.out.println(s2);	
			        	reback=s2;	
		        	}catch(java.lang.ClassNotFoundException e){
		               System.err.println("Class not dound:"+e.getMessage());
		               reback=e.getMessage();	
			        }catch(SQLException e){
			           System.err.println(df.format(day)+":  "+e.getMessage());
			           reback=e.getMessage();		        
		          	}
		        	finally {
		        		try{
		        		    if(rs != null){
		        		        rs.close();
		        		        rs = null;
		        		    }  
		        		}catch(final SQLException e){
		        		    e.printStackTrace();
		        		}finally{
		        		    try{
		        		        if(stmt != null){
		        		        	stmt.close();
		        		        	stmt = null;
		        		        }
		        		    }catch(final SQLException e){
		        		        e.printStackTrace();
		        		    }finally{
				        		  try{
				        		     if(con != null){
					        		   con.close();
					        		   con = null;
				        		     }
				        		}catch(final SQLException e){
				        		     e.printStackTrace();
				        		}finally{
				        		     return reback;
				        		}
		        		    }
		        		}
		        	}
	          }

		 @SuppressWarnings("finally")
		static public String CMD(String cmd) {
				        Statement stmt=null;
				        Connection con=null;
				        String reback="";
			        try {
			        	Class.forName("com.mysql.jdbc.Driver");	
			        	con=DriverManager.getConnection(url,"root","123456");
			        	stmt=con.createStatement();
			        	int index=0;
			    		while((index=cmd.indexOf(';'))!=-1) {
			    			String s=cmd.substring(0,index+1);
			    		//	System.out.println(s);
			    			stmt.executeUpdate(s);
			    			cmd=cmd.substring(index+1, cmd.length());
			    		//	System.out.println(cmd);
			    		}			    		
			    		con.close();
			            stmt.close(); 		
		                reback="OK";
			        }catch(java.lang.ClassNotFoundException e){
			               System.err.println("Class not dound:"+e.getMessage());
			               reback=e.getMessage();
			        } 
			        catch(SQLException ex){
			           System.err.println(df.format(day)+":  "+ex.getMessage());
			           reback=ex.getMessage();
			        }
		        	finally {
		        		    try{
		        		        if(stmt != null){
		        		        	stmt.close();
		        		        	stmt = null;
		        		        }
		        		    }catch(final SQLException e){
		        		        e.printStackTrace();
		        		    }finally{
				        		  try{
				        		     if(con != null){
					        		   con.close();
					        		   con = null;
				        		     }
				        		}catch(final SQLException e){
				        		     e.printStackTrace();
				        		}finally{
				        		     return reback;
				        		}		        
		        		}
		        	}
		      }
}
