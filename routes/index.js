const express = require('express'),   
    router = express.Router(),
    user = require("../model/user"),
    util=require("../util/util"),
    crypto = require('crypto'),
    auth = require("../model/auth"),
    roleauth = require("../model/roleauth"),
    captcha = require('trek-captcha');

    let reObj = util.reObj;
    //获取图片验证码
async function getImgCode(req, res) {
  const {token, buffer} = await captcha();
  req.session.captcha = token;
  res.writeHead(200, {'Content-Type': 'image/png'});
  res.write(buffer);
  res.end();
}


/**
 * @function 用户身份验证
 * @author yelin
 * @date 2017-05-19
 * @param username,status,
 */

 // 用户身份验证 对所有的功能请求进行鉴权
router.post('/checklogin',(req, res) => {
  const objdata = {}
  const params = {
    uname: req.body.uname,
    status: 1
  }
  let pwd = req.body.upwd
  user.findAll({where: params}).then(results=> {
      if (results.length > 0) {
        let salt = results[0].upwd.substring(0, 8)
        let password = crypto.createHash('md5').update(pwd + salt).digest('hex');
        if (password.toString() == results[0].upwd.substring(8)) {//登录密码正确

           // 根据角色id查询用户对应权限
           roleauth.findAll({where:{roleid: results[0].utype}}).then(record => {
            let autharr=[]
            if (record.length > 0) {
                //查询所有权限并匹配当前角色的权限，新增url字段
                let newrecord=JSON.parse(JSON.stringify(record))
                auth.findAll({where:{}}).then(authresults=>{
                  if(authresults.length>0)
                  {
                      let authlist=JSON.parse(JSON.stringify(authresults))
                      newrecord.forEach(function(item){
                          authlist.forEach(function (item2) {
                              if(item.authid===item2.authid)
                              {
                                  autharr.push(item2.authurl)
                              }

                          })
                      })
                      objdata.uname = results[0].uname
                      objdata.utype = results[0].utype
                      objdata.uuid = results[0].uuid                      
                      objdata.auth=autharr
                      //成功登陆后保存用户信息到cookie
                      res.cookie('userinfo', objdata, {maxAge: 1000 * 60 * 10, httpOnly: true});
                      req.session.loginstatus = 'true'
                      res.send(util.reObj(0,'用户身份验证成功',objdata))
                  }
                })        
            }
            else
            {
                objdata.uname = results[0].uname
                objdata.utype = results[0].utype                
                objdata.uuid = results[0].uuid
                objdata.auth=autharr
                //成功登陆后保存用户信息到cookie
                res.cookie('userinfo', objdata, {maxAge: 1000 * 60 * 10, httpOnly: true});
                req.session.loginstatus = 'true'
                res.send(util.reObj(0,'用户身份验证成功',objdata))
            }
        }).catch(err => {
            res.send(util.reObj(-1,'failed',err))
        })

          // objdata.uname = results[0].uname
          // objdata.unickname = results[0].unickname
          // objdata.utype = results[0].utype
          // objdata.uuid = results[0].uuid
       
          // //成功登陆后保存用户信息到cookie
          // res.cookie('userinfo', objdata, {maxAge: 1000 * 60 * 10, httpOnly: true});
          // req.session.loginstatus = 'true'
          // res.send(reObj(0, '用户身份验证成功', objdata))
        } else {
          res.send(reObj(-1, '无效的密码', []))
        }
      } else {
        res.send(reObj(-1, '无效的用户', []))
      }
  }).catch(err => {
        res.send(reObj(-1, '用户身份验证失败', err))
    });
})


/*返回浏览器cookie*/
router.get('/cookie', (req, res) => {
  res.send(req.cookies.userinfo)
});

router.get('/getImg', function (req, res, next) {
  getImgCode(req, res);
})

//核对验证码
router.get('/checkCaptcha', function (req, res) {
  var captcha = req.query.captcha;
  if (req.session.captcha == captcha) {
    res.send('success');
  } else {
    res.send('验证码错误');
  }
})


module.exports = router;