/*
  应用程序基础配置信息，包括数据连接,接口地址配置信息等
 */

(function () {
  const sender = '广东心理学会';

  module.exports = {
    redishost: '192.168.1.220',
    dbhost: '192.168.1.222',
    dbport: '3306',
    dbname: 'logistics',
    dbusername: 'root',
    dbpwd: '123456',
    validateType: 'mail',           // 验证码方式(tel和mail两种),修改后请配置好下面的信息
    nodemailerOption: {             // 邮箱服务配置
      host: 'smtp.126.com',         // 邮箱服务器地址
      secureConnection: true,       // use SSL
      port: 465,
      secure: true,                 // secure:true for port 465, secure:false for port 587
      auth: {
        user: 'gdsxlxh@126.com',    //发件邮箱
        pass: 'gpa218'              //密码或者邮箱授权码测试一下,邮箱服务不同使用的不一样
      }
    },
    mailer: sender,                 // 邮件发件人
    mailTime: 600,                  // 邮件验证码过期时间600s
    mailSubject: '验证码:******,,用于找回密码(10分钟内有效)，请勿将验证码透露给他人,如非本人操作请忽略。',                // 邮件主题,设置为空就和邮件内容一样,否则按设置的来
    mailtext_pre: '【' + sender + '】验证码:',   // 邮件内容前面部分
    mailtext_last: ',用于找回密码(10分钟内有效)，请勿将验证码透露给他人,如非本人操作请忽略。',  // 邮件内容后面部分,分钟按实际修改
    msgTime: 300,                   // 短信验证码过期时间300s
    msgtext_pre: '【' + sender + '】验证码:',    // 短信内容前面部分
    msgtext_last: ',用于找回密码(5分钟内有效)，请勿将验证码透露给他人,如非本人操作请忽略。',    // 短信内容后面部分,分钟按实际修改
    msgOption: {
      baseUrl: 'http://114.55.5.4:9011/hy/?uid=60093&auth=ee4663a8b1c8067a195872e3c1f66324&expid=0&encode=UTF-8',
      params: ['mobile','msg']      //按顺序定义手机号和信息的key值
    }

  };

}).call(this);
