/**
 * 程序访问入口
 *
 * */
//====================引入模块=================
const express = require('express'),
        path = require('path'),
        logger = require('morgan'),
        bodyParser = require('body-parser'),
        cookieParser = require('cookie-parser'),
        compression = require('compression'),
        session = require('express-session'),
        
//====================引入路由=================
        user = require('./routes/user'),
        role = require('./routes/role'),
        auth = require('./routes/auth'),                     
        validate = require('./routes/validate'),                
        index=require('./routes/index'),
        ueditor = require("ueditor"),
        app = express();

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(express.static(path.join(__dirname, 'public')));
app.use(session({
    secret: '123456',
    cookie: { maxAge: 1000*600 },
    resave: true,//是否允许session重新设置
    saveUninitialized: false,//session过期30分钟，，如果有人操作，每次以当前时间为起点，使用原设定的maxAge重设session过期时间到30分钟只有这种业务场景必须同行设置resave rolling为true.同时saveUninitialized要设置为false允许修改。
    rolling:true,//是否按照原设定的maxAge值重设session同步到cookie中
    name: 'gps'}))
//cookie处理
app.use(cookieParser());
app.use(compression({level: 9}));//优化压缩静态资源
app.use(logger('dev'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
//app.use(express.static(path.join(__dirname, 'dist')));


app.use('/',index);     //前台入口
/*  前台路由   end  */

//app.use('/admin',express.static(path.join(__dirname, 'dist')));      //后台入口

app.use('/',validate); //验证会话是否超时
app.use('/auth',auth);   //权限相关的接口
app.use('/users',user);   //用户相关的接口
app.use('/role',role);   //角色相关的接口



// catch 404 and forward to error handler
app.use((req, res, next) => {
  let err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use((err, req, res, next) => {
    res.status(err.status || 500);
    res.send(err)
  });
}

// production error handler
// no stacktraces leaked to user
app.use((err, req, res, next) => {
  res.status(err.status || 500);
  res.send(err)
});



module.exports = app;
