<template>
    <div class="login-wrap">
        <div class="ms-title">GPS后台管理系统</div>
        <div class="ms-login">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="0px" class="demo-ruleForm">
                <el-form-item prop="username">
                    <el-input v-model="ruleForm.username" placeholder="username" ref="input"></el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input type="password" placeholder="password" v-model="ruleForm.password" @keyup.enter.native="submitForm('ruleForm')"></el-input>
                </el-form-item>
                <div class="captcha">
                  <input type="text" class="cap-input" placeholder="请输入验证码" ref="thisMa" v-model="inputMa">
                  <!--<button class="cap-num" @click="createCode">{{checkCode}}</button>-->
                  <img class="cap-num" :src="capSrc" @click="changeCap" alt="这是验证码" title="点击刷新" ref="capImg">
                  <div class="error_msg" v-show="errorShow">{{errorMsg}}</div>
                </div>
                <div class="login-btn">
                    <el-button type="primary" @click="submitForm('ruleForm')">登录</el-button>
                </div>
                <!--<p style="font-size:12px;line-height:30px;color:#999;">Tips : 用户名和密码随便填。</p>-->
            </el-form>
        </div>
    </div>
</template>

<script>

    import md5 from '../../../public/js/md5.min.js'
    export default {
        data: function(){
            return {
                errorShow:false,
                errorMsg:'',
                inputMa:'',
                capSrc:'',
                ruleForm: {
                    username: '',
                    password: ''
                },
                rules: {
                    username: [
                        { required: true, message: '请输入用户名', trigger: 'blur' }
                    ],
                    password: [
                        { required: true, message: '请输入密码', trigger: 'blur' }
                    ]
                }
            }
        },
      mounted(){
          this.$refs['input'].focus()
          this.changeCap()
      },

      created(){
        let self = this;
        document.onkeydown = function(e){
          let key = window.event.keyCode;
          if(key === 13){
            self.submitForm('ruleForm');
          }
        }
      },
        methods: {
            submitForm(formName) {
                const self = this;
                  self.$refs[formName].validate((valid) => {
                    if (valid) {
                      let self = this;
                      if(self.inputMa == ''){
                        self.errorShow = true;
                        self.errorMsg = '验证码不能为空';
                      }else{
                        this.$axios.get('/checkCaptcha?captcha=' + self.inputMa)
                          .then(function (response) {
                            if (response.data === 'success') {
                              self.errorShow = false;
                              let postdata = {uname: self.ruleForm.username, upwd: md5(self.ruleForm.password)}
                              self.$axios.post('/checklogin', postdata)
                                .then(function (response) {
                                  if (response.data.code === 0) {
                                    self.errorShow = false;

                                    sessionStorage.setItem('token', response.data.data.id)
                                    sessionStorage.setItem('userinfo', JSON.stringify(response.data.data))
                                    sessionStorage.setItem('ms_username', response.data.data.uname);
                                    sessionStorage.setItem('utype', response.data.data.utype);
                                    sessionStorage.setItem('authlist',response.data.data.auth)
                                    self.$router.push('/readme');
                                  } else {
                                    self.errorShow = true;
                                    self.errorMsg = '用户名或密码错误，请重试';
                                    self.changeCap();
                                  }
                                })
                                .catch(function (error) {
                                  console.log(error);
                                });

                            } else {
                              self.inputMa = '';
                              self.$refs.thisMa.focus();
                              self.changeCap();
                              self.errorShow = true;
                              self.errorMsg = '验证码错误，请重试';
                            }
                          })
                          .catch(function (error) {
                            console.log(error);
                          });
                      }
                    } else {
                        return false;
                    }
                });
            },
            changeCap(){
                this.capSrc = '/getImg?' + Math.random();
            }
        }

    }
</script>

<style scoped>
    .captcha{
      padding-bottom: 24px;
      overflow: hidden;
      position: relative;
      margin-bottom: 5px;
    }
    .captcha .cap-input{
      padding: 0 15px;
      width: 240px;
      border: 1px solid #dcdfe6;
      -webkit-box-sizing: border-box;
      box-sizing: border-box;
      color: #606266;
      height: 40px;
      line-height: 40px;
      vertical-align: middle;
      border-radius: 4px;
    }
    .captcha .cap-input:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
      color: #999; opacity:1;
    }

    .captcha .cap-input::-moz-placeholder { /* Mozilla Firefox 19+ */
      color: #999;opacity:1;
    }

    .captcha .cap-inputinput:-ms-input-placeholder{
      color: #999;opacity:1;
    }

   .captcha .cap-input::-webkit-input-placeholder{
      color: #999;opacity:1;
    }
    .captcha .cap-num{
      border:1px solid #dcdfe6;
      width: 106px;
      height: 40px;
      vertical-align: middle;
      border-radius: 4px;
      outline: none;
      float: right;
    }

    .error_msg{
      position: absolute;
      left: 0;
      bottom:0;
      color: #f56c6c;
      font-size: 12px;
    }

    .login-wrap{
        position: relative;
        width:100%;
        height:100%;
    }
    .ms-title{
        position: absolute;
        top:50%;
        width:100%;
        margin-top: -230px;
        text-align: center;
        font-size:30px;
        color: #fff;

    }
    .ms-login{
        position: absolute;
        left:50%;
        top:50%;
        width:360px;
        height:220px;
        margin:-150px 0 0 -190px;
        padding:40px;
        border-radius: 5px;
        background: #fff;
    }

    .login-btn button{
        text-align: center;
    }
    .login-btn button{
        width:100%;
        height:36px;
    }
</style>
