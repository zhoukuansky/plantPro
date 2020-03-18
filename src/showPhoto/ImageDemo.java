package showPhoto;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author Administrator ����д�����ݿ��Լ������ݿ��ж�ȡ
 */
public class ImageDemo {

    // ��ͼƬ�������ݿ�
    public static void readImage2DB(String path,String diviceID) {
//        String path = "1.jpg";
        Connection conn = null;
        PreparedStatement ps = null;
        FileInputStream in = null;
        try {
            in = ImageUtil.readImage(path);
            conn = DBUtil.getConn();
            String sql = "insert into photo (name,photo,diviceID)values(DATE_ADD(NOW(),INTERVAL 8 HOUR),?,'"+diviceID+"')";
            ps = conn.prepareStatement(sql);
//            ps.setInt(1, 1);
 //           ps.setString(1, "");
            ps.setBinaryStream(1, in, in.available());
            int count = ps.executeUpdate();
            if (count > 0) {
                System.out.println("����ɹ���");
            } else {
                System.out.println("����ʧ�ܣ�");
            }
        } catch (Exception e) {
        	System.out.println("ͼƬ�������ݿ����");
            e.printStackTrace();
        } finally {
            DBUtil.closeConn(conn);
            if (null != ps) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

    }
    public static void updataImage2DB(String path,int id,String diviceID) {
//      String path = "1.jpg";
      Connection conn = null;
      PreparedStatement ps = null;
      FileInputStream in = null;
      try {
          in = ImageUtil.readImage(path);
          conn = DBUtil.getConn();
          String sql = "update photo set name=DATE_ADD(NOW(),INTERVAL 8 HOUR),photo=? where id=? and diviceID='"+diviceID+"'";
          ps = conn.prepareStatement(sql);
//          ps.setInt(1, 1);
//           ps.setString(1, "");
          ps.setBinaryStream(1, in, in.available());
          ps.setInt(2, id);
          int count = ps.executeUpdate();
          if (count > 0) {
              System.out.println("����ɹ���");
          } else {
              System.out.println("����ʧ�ܣ�");
          }
      } catch (Exception e) {
          e.printStackTrace();
      } finally {
          DBUtil.closeConn(conn);
          if (null != ps) {
              try {
                  ps.close();
              } catch (SQLException e) {
                  e.printStackTrace();
              }
          }
      }

  }
    public static void readDB2ImageId(String targetPath,int id) {  
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConn();
            String sql = "select * from photo where id =? and diviceID='01234567'";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                InputStream in = rs.getBinaryStream("photo");
                ImageUtil.readBin2Image(in, targetPath);
            }
            System.out.println("read images from sql succes");
            System.out.println(DBUtil.URL);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConn(conn);
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

        }
    }
    // ��ȡ���ݿ���ͼƬ
    public static void readDB2Image(String targetPath,String sqlname) {  
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConn();
            String sql = "select * from photo where name =?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, sqlname);
            rs = ps.executeQuery();
            while (rs.next()) {
                InputStream in = rs.getBinaryStream("photo");
                ImageUtil.readBin2Image(in, targetPath);
            }
            System.out.println("read images from sql succes");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConn(conn);
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

        }
    }
    //����
//    public static void main(String[] args) {
//       // readImage2DB();
//        readDB2Image("images/gwj.jpg","Tom");
//    }
}