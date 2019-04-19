class AppColors{
  static const APP_THEME = 0xff63ca6c;
  static const APP_BAR = 0xffffffff;

}

class AppInfo{
  // client_id
  static const CLIENT_ID = 'PjPvTjHFGdoMphxQ0awm';
  // 回调地址 必须带上https:// 否则请求不成功
  static const REDIRECT_URI = 'https://www.baidu.com';
  // 应用私钥
  static const CLIENT_SECRET = '3XUXd1xjBIlIcOgA2elIJf0YnTsuBhQY';

}
class AppUrls{
  // host
  static const HTTP_HOST = 'https://www.oschina.net';
  // 通过webview访问此url，点击'连接'，会获取到带有code的json
  static const AUTHORIZE = HTTP_HOST + '/action/oauth2/authorize?';
  // 通过获取的code，再获取token
  static const TOKEN = HTTP_HOST + '/action/openapi/token?';

  // 通过获取的token，再获取 用户信息（头像地址、名称、id等）
  static const USER = HTTP_HOST + '/action/openapi/user?';
  // 通过获取的用户信息，再获取 个人主页详情：
  static const MY_INFORMATION = HTTP_HOST + '/action/openapi/my_information?';

  // 消息列表
  static const MESSAGE_LIST = HTTP_HOST + '/action/openapi/message_list?';
  // 新闻列表
  static const NEWS_LIST = HTTP_HOST + '/action/openapi/news_list?';

}