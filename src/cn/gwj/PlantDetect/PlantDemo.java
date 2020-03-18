package cn.gwj.PlantDetect;

import java.net.URLEncoder;

import com.alibaba.fastjson.JSON;
import com.xs.common.image.ImageAPI;
import com.xs.pojo.image.Plant;
import com.xs.util.baidu.Base64Util;
import com.xs.util.baidu.FileUtil;
import com.xs.util.baidu.HttpUtil;


import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;


class AuthService {

    /**
     * 获取权限token
     * @return 返回示例：
     * {
     * "access_token": "24.460da4889caad24cccdb1fea17221975.2592000.1491995545.282335-1234567",
     * "expires_in": 2592000
     * }
     */
    public static String getAuth() {
        // 官网获取的 API Key 更新为你注册的
        String clientId = "RDoZ3W2FpreV9ZiSGxkqqGru";
        // 官网获取的 Secret Key 更新为你注册的
        String clientSecret = "CCKc9Z6NaR86V9k35WX3ypyO5euiehUG";
        return getAuth(clientId, clientSecret);
    }

    /**
     * 获取API访问token
     * 该token有一定的有效期，需要自行管理，当失效时需重新获取.
     * @param ak - 百度云官网获取的 API Key
     * @param sk - 百度云官网获取的 Securet Key
     * @return assess_token 示例：
     * "24.460da4889caad24cccdb1fea17221975.2592000.1491995545.282335-1234567"
     */
    public static String getAuth(String ak, String sk) {
        // 获取token地址
        String authHost = "https://aip.baidubce.com/oauth/2.0/token?";
        String getAccessTokenUrl = authHost
                // 1. grant_type为固定参数
                + "grant_type=client_credentials"
                // 2. 官网获取的 API Key
                + "&client_id=" + ak
                // 3. 官网获取的 Secret Key
                + "&client_secret=" + sk;
        try {
            URL realUrl = new URL(getAccessTokenUrl);
            // 打开和URL之间的连接
            HttpURLConnection connection = (HttpURLConnection) realUrl.openConnection();
            connection.setRequestMethod("GET");
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();
            // 遍历所有的响应头字段
            for (String key : map.keySet()) {
                System.err.println(key + "--->" + map.get(key));
            }
            // 定义 BufferedReader输入流来读取URL的响应
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String result = "";
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
            /**
             * 返回结果示例
             */
            System.err.println("result:" + result);
            JSONObject jsonObject = new JSONObject(result);
            String access_token = jsonObject.getString("access_token");
            return access_token;
        } catch (Exception e) {
            System.err.printf("获取token失败！");
            e.printStackTrace(System.err);
        }
        return null;
    }

}

/**
 * 植物识别
 * @author 小帅丶
 *
 */

public class PlantDemo {
	public static void main(String[] args) throws Exception {
		//返回字符串
//		String result = getPlantResult("图片路径", "自己应用apikey&sercetkey生成的AccessToken");
//		System.out.println(result);
		//返回java对象
//		Plant plant = getPlantBean("图片路径", "自己应用apikey&sercetkey生成的AccessToken");
//		System.out.println(plant.getResult().get(0).getName());
//		System.out.println(AuthService.getAuth());
//		String s=AuthService.getAuth();
//		System.out.println(s);
//		String result = getPlantResult("空心菜.jpg", "24.75ec117bdf6a4317de29db822f5087e0.2592000.1536297290.282335-11645210");
//		System.out.println(result);
//		返回java对象
//		Plant plant = getPlantBean("图片路径", "自己应用apikey&sercetkey生成的AccessToken");
//		System.out.println(plant.getResult().get(0).getName());
	}
	/**
	 * 植物识别Demo
	 * @param imagePath
	 * @param accessToken
	 * @return 字符串
	 * @throws Exception
	 */
	public static String getPlantResult(String imagePath) throws Exception{
		String accessToken=AuthService.getAuth();
		byte[] imgData = FileUtil.readFileByBytes(imagePath);
        String imgStr = Base64Util.encode(imgData);
		String param = "image=" + URLEncoder.encode(imgStr,"UTF-8");
        // 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
		String result = HttpUtil.post(ImageAPI.PLANT_API, accessToken, param);
//        System.out.println(result);
        return result;
	}
	/**
	 * 植物识别Demo
	 * @param imagePath
	 * @param accessToken
	 * @return LOGO对象
	 * @throws Exception
	 */
	public static Plant getPlantBean(String imagePath,String accessToken) throws Exception{
		byte[] imgData = FileUtil.readFileByBytes(imagePath);
        String imgStr = Base64Util.encode(imgData);
		String param = "image=" + URLEncoder.encode(imgStr,"UTF-8");
        // 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
		String result = HttpUtil.post(ImageAPI.PLANT_API, accessToken, param);
		Plant plant = JSON.parseObject(result,Plant.class);
//        System.out.println(result);
        return plant;
	}
}
