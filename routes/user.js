const express = require('express'),
  router = express.Router(),
  user = require("../model/user"),
  formidable = require('formidable'),
  fs = require('fs'),
  util = require("../util/util"),
  crypto = require('crypto'),
  uuid = require('uuid/v1');


let reObj = util.reObj;
let randomString = util.randomString;

let deleteFile = (fileName, fn) => {
  fs.unlink(`${__dirname}/../public/upload/head/${fileName}`, err => {
    if (err) {
      console.log(`------------出现错误:${err} , ${fileName} 图片删除失败!-----------`);
    } else {
      console.log(`------------${fileName} 图片删除成功!------------`);
      if (fn) {
        fn()
      }
    }
  });
}


/**
 * @function 增加用户
 * @author siwei
 * @date 2018
 * @param uuid,uname,utype,name,upwd,unickname,valid,sex,nativeplace,birthday,education,credentialstype,credentialsno,company...
 */
router.post('/add', (req, res) => {
  let salt = randomString(8)
  let upwd = req.body.upwd||crypto.createHash('md5').update('123456').digest('hex')
  let password = salt + crypto.createHash('md5').update(upwd + salt).digest('hex');
  let uname = req.body.uname
  let utype = req.body.utype || ''
  let name = req.body.name || ''
  let unickname = req.body.unickname || ''
  let valid = req.body.valid || ''

  let ucomment = req.body.ucomment || ''
  let status = req.body.status || '1'
  let uicon = req.body.uicon || ''
  let mail = req.body.mail || ''
  let phone = req.body.phone || ''
  let params = {
    uuid: uuid(),
    uname: uname,
    utype: utype,
    name: name,
    upwd: password,
    unickname: unickname,
    valid: valid,
    ucomment: ucomment,
    status: status,
    uicon: uicon,
    mail: mail,
    phone: phone,
  }
  if (uname) {


      user.findOrCreate({where: {uname: uname}, defaults: params}).then(record => {
        if (record[1]) {
          res.send(reObj(0, '添加用户成功', record[0]))
        } else {
          res.send(reObj(-1, '用户已存在'))
        }
      }).catch(err => {
        res.send(reObj(-1, '添加用户失败', err))
      });

  } else {
    res.send(reObj(-1, 'uname,upwd,uiid不能为空'))
  }
})

/**
 * @function 修改用户(前台有同样的接口)
 * @author siwei
 * @date 2018
 * @param uuid,uname,utype,name,upwd,unickname,valid,sex,nativeplace,birthday,education,credentialstype,credentialsno,company...
 */
router.post('/update', (req, res) => {
  let params = {}
  let uuid = req.body.uuid
  let uname = req.body.uname || ''
  let utype = req.body.utype || ''
  let name = req.body.name || ''
  let valid = req.body.valid || ''

  let unickname = req.body.unickname || ''
  let ucomment = req.body.ucomment || ''

  let upwd = req.body.upwd || ''
  let status = req.body.status || 1
  let uicon = req.body.uicon || ''

  let phone = req.body.phone || ''

  if (uuid) {
    params.uuid = uuid
  }
  let updateparams =
    {
      uname: uname,
      utype: utype,
      name: name,
      unickname: unickname,
      ucomment:ucomment,
      uicon:uicon,
      upwd: upwd,
      valid: valid,
      status: status,
      phone: phone
    }
  let salt = randomString(8)
  if (upwd != '') {
    updateparams.upwd = salt + crypto.createHash('md5').update(req.body.upwd + salt).digest('hex');
  }
  //去掉空的属性
  for (var key of Object.keys(updateparams)) {
    if (!updateparams[key])
      delete updateparams[key]
  }
  if (uuid == undefined) {
    res.send(reObj(-1, 'uuid不能为空'))
  } else {
      user.update(updateparams, {where: params}).then(record => {
        if (record[0] > 0) {
          res.send(reObj(0, '修改用户成功', record[0]))
        } else {
          res.send(reObj(-1, '无效的用户id', []))
        }
      }).catch(err => {
        res.send(reObj(-1, '修改用户失败', err))
      });

  }
})

/**
 * @function 修改用户头像
 * @author siwei
 * @date 2018-07-23
 * @param uuid,file(图片)
 */
router.post('/headupload', (req, res) => {
  /*1.创建表单*/
  let form = new formidable.IncomingForm();
  /*1.1设置上传图片放置的临时路径*/
  form.uploadDir = './public/upload';
  /*2.使用表单解析对应的请求*/
  form.parse(req, (err, fields, files) => {
    res.set('Content-Type', 'text/html');
    if (err) {
      res.send(reObj(-1, '图片上传失败', err))
    } else {

      let uuid = fields.uuid || req.cookies.userinfo.uuid  //ie上传时fields没有数据,就拿cookie的信息
      // let types = files.file.name.split('.'); //将文件名以.分隔，取得数组最后一项作为后缀名。
      let newPath = `${__dirname}/../public/upload/head/`;
      // let newName = `${uuid}.${String(types[types.length - 1])}`;
      let newName = `${uuid}.png`;
      // console.log(newName + ' 头像上传成功');
      /*3.文件重命名到新路径*/
      fs.renameSync(files.file.path, newPath + newName);
      /*4.更新对应uuid数据的uicon字段*/
      let params = {
        uuid: uuid
      }
      let uicon = '/upload/head/' + newName;
      let updateparams = {
        uicon: uicon,
      }
      if (uuid == undefined) {
        res.send(reObj(-1, 'uuid不能为空', err))
      } else {

        if (uicon.length > 250) {
          res.send(reObj(-1, '请求参数长度超出限制'))
        } else {

          user.update(updateparams, {where: params}).then(record => {
            if (record[0] > 0) {
              res.send(reObj(0, '图片上传成功', record[0]))
            } else {
              res.send(reObj(-1, '无效的用户id', []))
            }
          }).catch(err => {
            res.send(reObj(-1, '图片上传失败', err))
          });
        }
      }
    }
  })
})


/**
 * @function 直接删除用户
 * @author siwei
 * @date 2018-07-24
 * @param uuid
 */
router.post('/del', (req, res) => {
  let uuid = req.body.uuid;
  let params = {
    uuid: uuid
  }
 // let filename = `${uuid}.png`

  user.destroy({where: params}).then(record => {
    if (record > 0) {
   //   deleteFile(filename)
      res.send(reObj(0, '删除用户成功', record))
    } else {
      res.send(reObj(-1, '删除用户失败或此记录不存在', record))
    }
  }).catch(err => {
    res.send(reObj(-1, '删除用户失败', err))
  });
})

/**
 * @function 用户密码重置接口(后台)
 * @author siwei
 * @date 2018-07-30
 * @param uuid,upwd
 */
router.post('/reset', (req, res) => {
  let params = {}
  let uuid = req.body.uuid
  let upwd = req.body.upwd

  if (uuid && upwd) {
    params.uuid = uuid
    let updateparams = {
      upwd: upwd,
    }
    let salt = randomString(8)
    if (upwd != '') {
      updateparams.upwd = salt + crypto.createHash('md5').update(req.body.upwd + salt).digest('hex');
    }

    user.update(updateparams, {where: params}).then(record => {
      if (record[0] > 0) {
        res.send(reObj(0, '重置密码成功', record[0]))
      } else {
        res.send(reObj(-1, '无效的用户id'))
      }
    }).catch(err => {
      res.send(reObj(-1, '重置密码失败', err))
    });
  } else {
    res.send(reObj(-1, 'uuid,upwd不能为空'))
  }
})


/**
 * @function 获取用户详细数据
 * @author siwei
 * @date 2018
 * @param uuid
 */
router.post('/getuserinfo', (req, res) => {
  let params = {}
  let uuid = req.body.uuid
  if (uuid) {
    params.uuid = uuid;
  }
  if (uuid) {
    user.findOne({where: params}).then(record => {
      if (record) {
        res.send(reObj(0, '获取用户数据成功', record))
      } else {
        res.send(reObj(-1, '获取用户数据失败或此记录不存在', {}))
      }
    }).catch(err => {
      res.send(reObj(-1, '获取用户数据失败', err))
    });
  } else {
    res.send(reObj(-1, 'uuid不能为空', []))
  }
})

/**
 * @function 获取所有用户数据
 * @author siwei
 * @date 2018
 * @param pagerow,page
 */
router.post('/find', (req, res) => {
  let params = {}
  /*let status=req.body.status*/
  let pagerow = parseInt(req.body.pagerow)
  let page = parseInt(req.body.page)
  //对页码进行容错
  if (pagerow > 999) {
    pagerow = 999
  }
  if (page == 0) {
    page = 1
  }
  /* if(status){
       params.status=status
   }*/

  user.findAndCountAll({
    order: "updatetime DESC",
    limit: pagerow || 100,
    offset: parseInt(pagerow * (page - 1)) || 0,
    where: params
  }).then(record => {
    res.send(reObj(0, '获取用户列表成功', record.rows, record.count))
  }).catch(err => {
    res.send(reObj(-1, '获取用户列表失败', err))
  });
})




module.exports = router;
