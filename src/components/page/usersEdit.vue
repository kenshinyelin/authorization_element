<template>
    <div class="user-form">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-menu"></i> 用户管理</el-breadcrumb-item>
                <el-breadcrumb-item v-if="isNew">用户添加</el-breadcrumb-item>
                <el-breadcrumb-item v-if="!isNew">用户编辑</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <el-form :inline="false" :model="form" :rules="rules" ref="ruleForm" size="mini" label-width="130px">
            <div class="info-box main-info clearfix">
                <div class="title">用户主要信息</div>
                <div class="left">
                    <el-form-item label="用户名:" prop="uname">
                        <el-input v-model="form.uname" placeholder="请输入用户名称" auto-complete="off" :disabled="!isNew"></el-input>
                    </el-form-item>
                    <el-form-item label="密码" prop="upwd" v-if="isNew">
                        <el-input type="password" placeholder="请输入密码" v-model="form.upwd"
                                  auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="昵称:" prop="unickname">
                        <el-input v-model="form.unickname" placeholder="请输入昵称" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="用户头像:" prop="uicon">
                        <el-input v-model="form.uicon" placeholder="请输入头像图片路径" auto-complete="off"></el-input>
                    </el-form-item>
                </div>
                <div class="right">
                    <el-form-item label="手机号码:" prop="tel">
                        <el-input v-model="form.tel" placeholder="请输入手机号码" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="确认密码" prop="checkUpwd" v-if="isNew">
                        <el-input type="password" placeholder="请再次输入密码" v-model="form.checkUpwd"
                                  auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="电子邮箱:" prop="mail">
                        <el-input v-model="form.mail" placeholder="请输入电子邮箱" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="备注信息:" prop="ucomment">
                        <el-input type="textarea" v-model="form.ucomment" placeholder="请输入备注信息"
                                  auto-complete="off"></el-input>
                    </el-form-item>
                </div>
            </div>
            <div class="info-box other-info clearfix">
                <div class="title">用户其他信息</div>
                <div class="left">
                    <el-form-item label="用户类型：" prop="utype">
                        <el-select v-model='form.utype' placeholder="请选择用户类型" style="width: 100%;">
                            <el-option v-for="item in roleList"
                                       :key="item.roleid"
                                       :label="item.rolename"
                                       :value="item.roleid">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="姓名:" prop="name">
                        <el-input v-model="form.name" placeholder="请输入姓名" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="出生日期" prop="birthday">
                        <el-date-picker value-format="yyyy-MM-dd" type="date" placeholder="选择日期" v-model="form.birthday"
                                        style="width: 100%;"></el-date-picker>
                    </el-form-item>
                    <el-form-item label="所在区域:" prop="province">
                        <el-select v-model='form.province' placeholder="请选择工作单位/学校所在区域" style="width: 100%;">
                            <el-option value="北京市" label='北京市'>北京市</el-option>
                            <el-option value="天津市" label='天津市'>天津市</el-option>
                            <el-option value="河北省" label='河北省'>河北省</el-option>
                            <el-option value="山西省" label='山西省'>山西省</el-option>
                            <el-option value="内蒙古自治区" label='内蒙古自治区'>内蒙古自治区</el-option>
                            <el-option value="辽宁省" label='辽宁省'>辽宁省</el-option>
                            <el-option value="吉林省" label='吉林省'>吉林省</el-option>
                            <el-option value="黑龙江" label='黑龙江'>黑龙江</el-option>
                            <el-option value="上海市" label='上海市'>上海市</el-option>
                            <el-option value="江苏省" label='江苏省'>江苏省</el-option>
                            <el-option value="浙江省" label='浙江省'>浙江省</el-option>
                            <el-option value="安徽省" label='安徽省'>安徽省</el-option>
                            <el-option value="福建省" label='福建省'>福建省</el-option>
                            <el-option value="江西省" label='江西省'>江西省</el-option>
                            <el-option value="山东省" label='山东省'>山东省</el-option>
                            <el-option value="河南省" label='河南省'>河南省</el-option>
                            <el-option value="湖北省" label='湖北省'>湖北省</el-option>
                            <el-option value="湖南省" label='湖南省'>湖南省</el-option>
                            <el-option value="广东省" label='广东省'>广东省</el-option>
                            <el-option value="广西壮族自治区" label='广西壮族自治区'>广西壮族自治区</el-option>
                            <el-option value="海南省" label='海南省'>海南省</el-option>
                            <el-option value="重庆市" label='重庆市'>重庆市</el-option>
                            <el-option value="四川省" label='四川省'>四川省</el-option>
                            <el-option value="贵州省" label='贵州省'>贵州省</el-option>
                            <el-option value="云南省" label='云南省'>云南省</el-option>
                            <el-option value="西藏自治区" label='西藏自治区'>西藏自治区</el-option>
                            <el-option value="陕西省" label='陕西省'>陕西省</el-option>
                            <el-option value="甘肃省" label='甘肃省'>甘肃省</el-option>
                            <el-option value="青海省" label='青海省'>青海省</el-option>
                            <el-option value="宁夏回族自治区" label='宁夏回族自治区'>宁夏回族自治区</el-option>
                            <el-option value="新疆维吾尔自治区" label='新疆维吾尔自治区'>新疆维吾尔自治区</el-option>
                            <el-option value="台湾省" label='台湾省'>台湾省</el-option>
                            <el-option value="香港特别行政区" label='香港特别行政区'>香港特别行政区</el-option>
                            <el-option value="澳门特别行政区" label='澳门特别行政区'>澳门特别行政区</el-option>

                        </el-select>
                    </el-form-item>
                    <el-form-item label="党派:" prop="polity">
                        <el-select v-model='form.polity' placeholder="请选择党派" style="width: 100%;">
                            <el-option value="polity1" label='中共党员'>中共党员</el-option>
                            <el-option value="polity10" label='民革成员'>民革成员</el-option>
                            <el-option value="polity11" label='民盟成员'>民盟成员</el-option>
                            <el-option value="polity2" label='民建成员'>民建成员</el-option>
                            <el-option value="polity3" label='民进成员'>民进成员</el-option>
                            <el-option value="polity4" label='农工党党员'>农工党党员</el-option>
                            <el-option value="polity5" label='致公党党员'>致公党党员</el-option>
                            <el-option value="polity6" label='九三学社成员'>九三学社成员</el-option>
                            <el-option value="polity7" label='台盟成员'>台盟成员</el-option>
                            <el-option value="polity8" label='无党派民主人士'>无党派民主人士</el-option>
                            <el-option value="polity9" label='群众'>群众</el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="证件号码:" prop="credentialsno">
                        <el-input v-model="form.credentialsno" placeholder="请输入证件号码" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="最高毕业院校:" prop="graduatedschool">
                        <el-input v-model="form.graduatedschool" placeholder="请输入最高毕业院校" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="工作单位:" prop="company">
                        <el-input v-model="form.company" placeholder="请输入工作单位" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="单位职务:" prop="jobtitle">
                        <el-input v-model="form.jobtitle" placeholder="请输入单位职务" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="通讯地址:" prop="addr">
                        <el-input v-model="form.addr" placeholder="请输入通讯地址" auto-complete="off"></el-input>
                    </el-form-item>
                </div>
                <div class="right">
                    <el-form-item label="是否有效：" prop="status">
                        <el-select v-model='form.status' placeholder="请选择用户状态" style="width: 100%;">
                            <el-option value="1" label='是'>是</el-option>
                            <el-option value="0" label='否'>否</el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="性别" prop="sex">
                        <el-radio-group v-model="form.sex">
                            <el-radio label="1">男</el-radio>
                            <el-radio label="2">女</el-radio>
                        </el-radio-group>
                    </el-form-item>
                    <el-form-item label="籍贯:" prop="nativeplace">
                        <el-input v-model="form.nativeplace" placeholder="请输入籍贯" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="民族:" prop="people">
                        <el-select v-model='form.people' placeholder="请选择民族" style="width: 100%;">
                            <el-option value="100" label='汉族'>汉族</el-option>
                            <el-option value="101" label='壮族'>壮族</el-option>
                            <el-option value="102" label='满族'>满族</el-option>
                            <el-option value="103" label='回族'>回族</el-option>
                            <el-option value="104" label='苗族'>苗族</el-option>
                            <el-option value="105" label='维吾尔族'>维吾尔族</el-option>
                            <el-option value="106" label='土家族'>土家族</el-option>
                            <el-option value="107" label='彝族'>彝族</el-option>
                            <el-option value="108" label='蒙古族'>蒙古族</el-option>
                            <el-option value="109" label='藏族'>藏族</el-option>
                            <el-option value="110" label='布依族'>布依族</el-option>
                            <el-option value="111" label='侗族'>侗族</el-option>
                            <el-option value="112" label='瑶族'>瑶族</el-option>
                            <el-option value="113" label='朝鲜族'>朝鲜族</el-option>
                            <el-option value="114" label='白族'>白族</el-option>
                            <el-option value="115" label='哈尼族'>哈尼族</el-option>
                            <el-option value="116" label='哈萨克族'>哈萨克族</el-option>
                            <el-option value="117" label='黎族'>黎族</el-option>
                            <el-option value="118" label='傣族'>傣族</el-option>
                            <el-option value="119" label='畲族'>畲族</el-option>
                            <el-option value="120" label='傈僳族'>傈僳族</el-option>
                            <el-option value="121" label='仡佬族'>仡佬族</el-option>
                            <el-option value="122" label='东乡族'>东乡族</el-option>
                            <el-option value="123" label='高山族'>高山族</el-option>
                            <el-option value="124" label='拉祜族'>拉祜族</el-option>
                            <el-option value="125" label='水族'>水族</el-option>
                            <el-option value="126" label='佤族'>佤族</el-option>
                            <el-option value="127" label='纳西族'>纳西族</el-option>
                            <el-option value="128" label='羌族'>羌族</el-option>
                            <el-option value="129" label='土族'>土族</el-option>
                            <el-option value="130" label='仫佬族'>仫佬族</el-option>
                            <el-option value="131" label='锡伯族'>锡伯族</el-option>
                            <el-option value="132" label='柯尔克孜族'>柯尔克孜族</el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="证件类型:" prop="credentialstype">
                        <el-select v-model='form.credentialstype' placeholder="请选择证件类型" style="width: 100%;">
                            <el-option value="居民身份证" label='居民身份证'>居民身份证</el-option>
                            <el-option value="港澳通行证" label='港澳通行证'>港澳通行证</el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="最高学历:" prop="education">
                        <el-select v-model='form.education' placeholder="请选择最高学历" style="width: 100%;">
                            <el-option value="edu4" label='博士研究生'>博士研究生</el-option>
                            <el-option value="edu3" label='硕士研究生'>硕士研究生</el-option>
                            <el-option value="edu2" label='大学本科'>大学本科</el-option>
                            <el-option value="edu1" label='大学专科'>大学专科</el-option>
                            <el-option value="edu0" label='其他'>其他</el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="专业:" prop="techbackground">
                        <el-input v-model="form.techbackground" placeholder="请输入专业" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="专业技术职称:" prop="techtitle">
                        <el-select v-model='form.techtitle' placeholder="请选择专业技术职称" style="width: 100%;">
                            <el-option value="title0" label='正高级'>正高级</el-option>
                            <el-option value="title1" label='副高级'>副高级</el-option>
                            <el-option value="title2" label='中级'>中级</el-option>
                            <el-option value="title3" label='初级'>初级</el-option>
                            <el-option value="title4" label='无'>无</el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="邮政编码:" prop="zipcode">
                        <el-input v-model="form.zipcode" placeholder="请输入邮政编码" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="QQ:" prop="qq">
                        <el-input v-model="form.qq" placeholder="请输入QQ号码" auto-complete="off"></el-input>
                    </el-form-item>
                </div>
            </div>
        </el-form>
        <el-form :inline="false" :model="form2" size="mini" label-width="130px" disabled>
            <div class="info-box vip-info">
                <div class="title">会员信息 <span style="color:#666;font-size: 12px;">(会员信息修改请到会员管理)</span></div>
                <div class="left">
                    <el-form-item label="会员状态:" prop="cardstatus">
                        <el-select v-model='form2.cardstatus' placeholder="" style="width: 100%;">
                            <el-option value="0" label='未提交申请'>未提交申请</el-option>
                            <el-option value="1" label='已提交申请,待初审'>已提交申请,待初审</el-option>
                            <el-option value="2" label='初审不通过'>初审不通过</el-option>
                            <el-option value="3" label='已通过初审,待终审'>已通过初审,待终审</el-option>
                            <el-option value="4" label='终审不通过'>终审不通过</el-option>
                            <el-option value="5" label='已通过终审,待缴费'>已通过终审,待缴费</el-option>
                            <el-option value="6" label='正常缴费'>正常缴费</el-option>
                            <el-option value="7" label='老会员,未续费'>老会员,未续费</el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="专业委员会:" prop="committee">
                        <el-select v-model='form2.committee' placeholder="" style="width: 100%;">
                            <el-option value="心理健康专业委员会" label='心理健康专业委员会'>心理健康专业委员会</el-option>
                            <el-option value="心理咨询与治疗专业委员会" label='心理咨询与治疗专业委员会'>心理咨询与治疗专业委员会</el-option>
                            <el-option value="婴幼儿心理与学前教育专业委员会" label='婴幼儿心理与学前教育专业委员会'>婴幼儿心理与学前教育专业委员会</el-option>
                            <el-option value="精神分析专业委员会" label='精神分析专业委员会'>精神分析专业委员会</el-option>
                            <el-option value="临床心理专业委员会" label='临床心理专业委员会'>临床心理专业委员会</el-option>
                            <el-option value="员工心理援助专业委员会" label='员工心理援助专业委员会'>员工心理援助专业委员会</el-option>
                            <el-option value="儿童、青少年心理援助专业委员会" label='儿童、青少年心理援助专业委员会'>儿童、青少年心理援助专业委员会</el-option>
                            <el-option value="沙盘心理技术专业委员会" label='沙盘心理技术专业委员会'>沙盘心理技术专业委员会</el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="申请年限类别:" prop="applytype">
                        <el-select v-model='form2.applytype' placeholder="" style="width: 100%;">
                            <el-option value="0" label='四年制/400元'>四年制/400元</el-option>
                            <el-option value="1" label='终身制/1500元'>终身制/1500元</el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="入会期限:" prop="duration" v-if="!isNew">
                        <el-date-picker style="width: 100%;"
                                        v-model="form2.duration"
                                        value-format="yyyy-MM-dd"
                                        type="daterange"
                                        range-separator="至"
                                        start-placeholder="开始日期"
                                        end-placeholder="结束日期">
                        </el-date-picker>
                    </el-form-item>
                </div>
                <div class="right">
                    <el-form-item label="审核原因:" prop="reason">
                        <el-input v-model="form2.reason" placeholder=""></el-input>
                    </el-form-item>
                    <el-form-item label="会员编号:" prop="cardno">
                        <el-input v-if="form2.cardstatus==6" v-model="form2.cardno" placeholder=""></el-input>
                        <el-input v-if="form2.cardstatus!=6" placeholder="该用户暂不是会员"></el-input>
                    </el-form-item>
                    <el-form-item label="会员创建时间:" prop="creattime" v-if="!isNew">
                        <el-input v-model="$moment(form2.creattime).format('YYYY-MM-DD HH:mm:ss')"
                                  placeholder=""></el-input>
                    </el-form-item>
                    <el-form-item label="上次修改时间:" prop="updatetime" v-if="!isNew">
                        <el-input v-model="$moment(form2.updatetime).format('YYYY-MM-DD HH:mm:ss')"
                                  placeholder=""></el-input>
                    </el-form-item>

                </div>
            </div>
        </el-form>
        <div class="fixed-btn">
            <el-button size="mini" type="primary" @click="submitForm('ruleForm')">确定</el-button>
            <el-button size="mini" @click="goBack">取消</el-button>
        </div>


    </div>
</template>


<script>
  import md5 from '../../../public/js/md5.min.js'

  export default {
    data: function () {
      var validateUpwd = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入密码'));
        } else {
          if (this.form.checkUpwd !== '') {
            this.$refs.ruleForm.validateField('checkUpwd');
          }
          callback();
        }
      };
      var validateUpwd2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请再次输入密码'));
        } else if (value !== this.form.upwd) {
          callback(new Error('两次输入密码不一致!'));
        } else {
          callback();
        }
      };
      return {
        isNew: false,
        form: {
          uuid: '',  //用户编码
          uname: '',  //用户名
          utype: '',  //用户类型
          name: '',  //姓名
          unickname: '',  //昵称
          valid: '',  //
          sex: '',  //性别
          nativeplace: '',  //籍贯
          birthday: '',  //生日
          education: '',  //学历
          credentialstype: '',  //证件类型
          credentialsno: '',  //证件号码
          company: '',  //工作单位
          techtitle: '',  //专业技术职称
          jobtitle: '',  //单位职务
          addr: '',  //通讯地址
          zipcode: '',  //邮政编码
          upwd: '',  //密码
          ucomment: '',  //备注信息
          status: '1',  //状态
          uicon: '',  //用户头像
          mail: '',  //邮箱
          tel: '',  //手机号码
          qq: '',  //QQ
          techbackground: '',  //专业背景
          achievement: '',  //主要成就

          people: '',  //民族
          polity: '',   //党派
          graduatedschool: '',   //最高毕业院校
          province: '',   //所在区域
          eduexperience: '',  //教育经历
          workexperience: '',  //工作经历
        },
        form2: {
          uuid: '',  //用户编码
          uname: '',  //用户名
          cardstatus: '0',  //会员状态
          applytype: '',  //申请年限类型
          cardno: '',  //会员编号
          committee: '',  //专业委员会
          duration: '',  //入会期限
          creattime: '',  //添加时间
          updatetime: '',  //更新时间
        },
        rules: {
          uname: [
            {required: true, message: '请输入用户名', trigger: 'blur'}
          ],
          utype: [
            {required: true, message: '请选择用户类型', trigger: 'blur'}
          ],
          upwd: [
            {required: true, validator: validateUpwd, trigger: 'blur'}
          ],
          checkUpwd: [
            {required: true, validator: validateUpwd2, trigger: 'blur'}
          ]
        },
        roleList: []
      }
    },
    methods: {
      //页面初始化
      getUser(id) {
        var self = this
        self.$axios.post('/users/getuserinfo', {
          uuid: id
        }).then(function (res) {
          if (res.data.code == 0) {
            self.form = res.data.data

            self.$axios.post('/vip/getvipinfo', {
              uuid: id
            }).then(function (res) {
              if (res.data.code == 0) {
                self.form2 = res.data.data
                if (self.form2.duration) {
                  self.form2.duration = self.form2.duration.split(',')
                }
              } else {
                self.$message.error(res.data.message);
              }
            }).catch((err) => {
              self.$message.error('获取会员信息失败，请稍后再试！');
            })
          } else {
            self.$message.error(res.data.message);
          }
        }).catch((err) => {
          self.$message.error('获取用户信息失败，请稍后再试！');
        })
      },
      getRoleList(fn) {
        let self = this
        let params = {
          skipnum: 1,
          pagesize: 999
        }
        self.$axios.post('/role/getrolelist', params)
          .then(function (response) {
            if (response.data.code == 0) {
              self.roleList = response.data.data;
              if (fn) fn()
            } else {
              self.$message.error(response.data.message);
            }
          }).catch(function (error) {
          throw error;
          self.$message.error('获取用户类型列表失败，请稍后再试！');
        });
      },
      submitForm(ruleForm) {
        var self = this;
        self.$refs[ruleForm].validate((valid) => {
          if (valid) {

            if (self.$route.path == '/users_add/') {      //新增用户
              // console.log(self.form);
              self.form.upwd = md5(self.form.upwd)
              self.$axios.post('/users/add', self.form).then(res => {
                if (res.data.code == 0) {
                  self.form2.uuid = res.data.data.uuid;
                  self.form2.uname = res.data.data.uname;
                  self.$axios.post('/vip/add', self.form2).then(res => {
                    if (res.data.code == 0) {
                      self.goBack()
                    } else {
                      self.$message.error(res.data.message);
                    }
                  }).catch(err => {
                    self.$message.error('同步创建会员信息失败，请稍后再试！');
                  })
                } else {
                  self.$message.error(res.data.message);
                }
              }).catch(err => {
                self.$message.error('新增用户失败，请稍后再试！');
              })

            } else {              //编辑用户
              self.form.upwd = ''
              self.$axios.post('/users/edit', self.form)
                .then(function (res) {
                  if (res.data.code == 0) {
                    self.goBack()
                  } else {
                    self.$message.error(res.data.message);
                  }
                }).catch(function (err) {
                self.$message.error('修改用户信息失败，请稍后再试！');
              })
            }
          } else {
            this.$message({
              message: '信息有误或者不完整，请重试！',
              type: 'warning'
            });
            return false;
          }
        })
      },
      goBack() {
        this.$router.go(-1);
      },
    },
    created() {
      if (this.$route.path == '/users_add/') { //新增
        this.isNew = true;
        this.getRoleList()
      } else {        //编辑
        this.isNew = false;
        this.getRoleList()
        this.getUser(this.$route.query.uuid)
      }
    }
  }
</script>

<style scoped>
    .user-form {
        width: 90%;
    }

    .el-form {
        padding-top: 10px;
    }

    .fixed-btn {
        position: fixed;
        z-index: 9999999;
        padding: 10px 30px;
        text-align: right;
        right: 0;
        bottom: 0;
        background: none;
        margin-bottom: 0;
    }

    .info-box {
        margin-top: -10px;
    }

    .info-box::after {
        display: block;
        content: '';
        clear: both;
        height: 0;
    }

    .info-box .title {
        margin: 10px 0;
        padding-bottom: 10px;
        border-bottom: 1px solid #dcdfe6;
    }

    .info-box .left,
    .info-box .right {
        width: 50%;
        padding: 10px;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
    }

    .info-box .left {
        float: left;
    }

    .info-box .right {
        float: right;
    }
</style>
