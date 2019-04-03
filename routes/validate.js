/**
 * Created by Eric_HSBC on 16-6-26.
 * 登录验证
 */

const express = require('express');
const router = express.Router();


let isAdminLogined = req => {
  return req.session.loginstatus;
}

router.all("/*", (req, res, next) => {
  if (isAdminLogined(req)) {
    next()
  } else {
    res.send('expired')
  }
});


module.exports = router;
