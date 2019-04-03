<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-menu"></i> 用户管理</el-breadcrumb-item>
                <el-breadcrumb-item>用户管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="handle-box">
            <div class="fr">
                <el-input placeholder="用户名" size="mini" class="handle-input" v-model="uname"></el-input>
                <el-input placeholder="手机号" size="mini" class="handle-input" v-model="phone"></el-input>
                <el-button type="primary" size="mini" icon="el-icon-search" @click="search">查询</el-button>
            </div>
            <el-button type="primary" size="mini" icon="" @click="addUserFormVisible = true">添加用户</el-button>
        </div>
        <el-table   :data="tableData" border style="width: 100%" ref="multipleTable" >
            <el-table-column prop="uname" label="用户名" width="150"></el-table-column>
            <el-table-column prop="phone" label="手机号码" width=""></el-table-column>
            <el-table-column prop="utypename" label="用户类型" width="100"></el-table-column>

            <el-table-column prop="unickname" label="昵称" width="150"></el-table-column>

            <el-table-column prop="register_time" label="注册时间" width="">
                <template slot-scope="scope">
                    <span>{{scope.row.register_time?$moment(scope.row.register_time).format('YYYY-MM-DD HH:mm:ss'):''}}</span>
                </template>
            </el-table-column>
            <el-table-column prop="dtl" label="最后登录时间" width="">
                <template slot-scope="scope">
                    <span>{{scope.row.dtl?$moment(scope.row.dtl).format('YYYY-MM-DD HH:mm:ss'):''}}</span>
                </template>
            </el-table-column>
            <el-table-column prop="status" label="状态" width="100">
                <template slot-scope="scope">
                    <el-tag close-transition type="danger" v-if="scope.row.status==0">禁用</el-tag>
                    <el-tag close-transition type="success" v-else-if="scope.row.status==1">可用</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="操作" width="250" fixed="right">
                <template slot-scope="scope">
                    <el-button @click="editUser(scope.$index, scope.row)"
                               size="small" >编辑 </el-button>
                    <el-button @click="resetPwd(scope.$index, scope.row)" size="mini">重置密码</el-button>
                    <el-button @click="deleteRow(scope.row.uuid)" type="danger"
                               size="small" >删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>
        <!--分页-->
        <div class="pagination"  style="float: left">
            <el-pagination
                    @current-change ="handleCurrentChange" background
                    layout="total, prev, pager, next, jumper"
                    :total="totalPage">
            </el-pagination>
        </div>

        <!--新增用户弹窗-->
        <el-dialog title="新增用户" :visible.sync="addUserFormVisible" size="tiny">
            <el-form :model="form" :rules="rules" ref="ruleForm">
                <el-form-item label="用户名:" :label-width="formLabelWidth" prop="uname">
                    <el-input v-model="form.uname" placeholder="请输入用户名"  auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="用户类型：" :label-width="formLabelWidth" prop="utype">
                    <el-select v-model='form.utype' placeholder="请选择" >
                        <el-option v-for="item in roleList"
                                   :key="item.roleid"
                                   :label="item.rolename"
                                   :value="item.roleid">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="手机号码:" :label-width="formLabelWidth" prop="phone">
                    <el-input v-model="form.phone" placeholder="请输入电话"  auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="用户昵称:" :label-width="formLabelWidth" prop="unickname">
                    <el-input v-model="form.unickname" placeholder="请输入用户名称" auto-complete="off"></el-input>
                </el-form-item>
                <!--<el-form-item label="密码:" :label-width="formLabelWidth" prop="upwd">
                    <el-input v-model="form.upwd" placeholder="请输入密码" auto-complete="off"></el-input>
                </el-form-item>-->
                <el-form-item label="用户状态：" :label-width="formLabelWidth" prop="status">
                    <el-select v-model='form.status' style='width:100%' placeholder="请选择用户状态" >
                        <el-option    value="1" label='可用'>可用</el-option>
                        <el-option    value="0" label='禁用'>禁用</el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="addUserFormVisible = false;resetForm()">取 消</el-button>
                <el-button type="primary" @click="addUser('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>
        <!-- 编辑用户弹窗 -->
        <el-dialog title="编辑用户信息" size="tiny" :visible.sync="editUserVisible"  >
            <el-form :model="form" :rules="rules" ref="ruleForm">
                <el-form-item label="用户名:" :label-width="formLabelWidth" prop="uname">
                    <el-input v-model="form.uname" placeholder="请输入用户名"  auto-complete="off" disabled></el-input>
                </el-form-item>
                <!--<el-form-item label="用户类型:" :label-width="formLabelWidth" prop="utype">
                    <el-input v-model="form.utype" placeholder="请输入用户类型"  auto-complete="off"></el-input>
                </el-form-item>-->
                <el-form-item label="用户类型：" :label-width="formLabelWidth" prop="utype" >
                    <el-select v-model='form.utype' placeholder="" >
                        <el-option v-for="item in roleList"
                                   :key="item.roleid"
                                   :label="item.rolename"
                                   :value="item.roleid">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="手机号码:" :label-width="formLabelWidth" prop="phone">
                    <el-input v-model="form.phone" placeholder="请输入电话"  auto-complete="off" ></el-input>
                </el-form-item>

                <el-form-item label="用户昵称:" :label-width="formLabelWidth" prop="unickname">
                    <el-input v-model="form.unickname" placeholder="请输入用户名称" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="用户状态：" :label-width="formLabelWidth" prop="status">
                    <el-select v-model='form.status' style='width:100%' placeholder="请选择用户状态" >
                        <el-option    value="1" label='可用'>可用</el-option>
                        <el-option    value="0" label='禁用'>禁用</el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="editUserVisible = false;resetForm()">取 消</el-button>
                <el-button type="primary" @click="editConfirm('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>
    </div>

</template>

<script>
    import md5 from '../../../public/js/md5.min.js'
    export default {
        data: function() {
            return {
                phone:'',//查询输入框
                uname:'',
                tabPosition: 'left',
                tableData:[],
                addUserFormVisible:false,
                editUserVisible:false,
                formLabelWidth: '120px',
                page:1,
                pagerow:10,
                pagination:1,
                cur_page:1,
                totalPage:1,
                form:{
                    uuid:'',
                    phone:'',
                    uname:'',
                    utype:'',
                    upwd:'',
                    unickname:'',
                    status:'1'
                },
                roleList: [],
                rules: {
                    uname:  [
                        {  required: true, message: '请输入用户名', trigger: 'blur' }
                    ]
                }
            }
        },

        computed:{
            onRoutes(){
                return this.$route.path.replace('/','');
            }
        },
        created(){
            //enter事件
            let self = this;
            document.onkeydown = function(e){
                let key = window.event.keyCode;
                if(key === 13){
                    self.search();
                }
            }
            this.findrecord()
            this.getRoleList()
        },
        methods:{
            //查询
            search(){
                this.findByParam();
            },
            resetForm(){
                this.form={
                    uuid:'',
                    phone:'',
                    uname:'',
                    utype:'',
                    upwd:'',
                    unickname:'',
                    status:'1'
                }
            },
            /*添加用户*/
            addUser(ruleForm){
                this.$refs[ruleForm].validate((valid) => {
                    if (valid) {
                        this.$axios.post('/users/add',this.form).then(res=>{
                            if(res.data.code ==0){
                                this.addUserFormVisible = false;
                                this.$message.info('新增用户信息成功！');
                                this.findrecord()
                                this.resetForm()
                            }
                            else if(res.data.code ==-2){
                                this.$message("该用户已存在！")
                            }
                            else{
                                this.$message.error('新增用户失败，请稍后再试！');
                            }
                        }).catch(err=>{
                            this.$message.error('新增用户失败，请稍后再试！');
                        })
                    } else {
                        this.$message({
                            message: '信息有误或者不完整，请重试。',
                            type: 'warning'
                        });
                        return false;
                    }
                });
            },
            editUser(index, row) {
                this.editUserVisible = true;
                this.form.uuid= row.uuid;
                this.form.phone= row.phone;
                this.form.utype= row.utype;
                this.form.uname= row.uname;
                this.form.unickname= row.unickname;
                this.form.status= row.status;
            },
            editConfirm(ruleForm){
                this.$refs[ruleForm].validate((valid) => {
                    if (valid) {
                        let url='/users/update';
                        this.$axios.post(url, this.form).then((res)=>{
                            if(res.data.code == 0){
                                this.editUserVisible = false;
                                this.$message.info('修改用户信息成功！');
                                this.findrecord()
                                this.resetForm()
                            }
                            else{
                                this.$message.error('修改用户信息失败，请稍后再试！');
                            }
                        }).catch((err)=>{
                            this.$message.error('修改用户信息失败，请稍后再试！');
                        })
                    } else {
                        return false;
                    }
                })
            },
            deleteRow(uuid){
                this.$confirm("确定删除此用户吗?","提示",{type:'warning'})
                    .then(()=>{
                        this.$axios.post('/users/del',{uuid:uuid})
                            .then((res)=>{
                                if(res.data.code == 0){
                                    this.$message.info('您已成功删除该用户!');
                                    this.findrecord()
                                }
                                else {
                                    this.$message.error('请求服务器失败，请稍后再试！');
                                }
                            }).catch(err=>{
                            this.$message.error('请求服务器失败，请稍后再试！');
                        })

                    }).catch(()=>{
                    this.$message.info('已取消该删除操作!');
                })
            },
            //取消按钮
            cancleOper(){
                this.addClsTypeVisible=false
                this.setCourseVisible=false
            },
            //确定按钮
            ensure(){
                if(this.flag==1){
                    this.addClsType()
                }else{
                    this.editClsType()
                }
            },
            getRoleList(fn) {
                let self = this
                let params = {
                    skipnum:0,
                    pagesize: 100
                }
                self.$axios.post('/role/getrolelist', params)
                    .then(function (response) {
                        if (response.data.code == 0) {
                            self.roleList = response.data.data;
                          //  if (fn) fn()
                        } else {
                            self.$message.error(response.data.message);
                        }
                    }).catch(function (error) {
                    throw error;
                    self.$message.error('获取用户类型列表失败，请稍后再试！');
                });
            },
            //重置密码
            resetPwd(index, row) {
                var self = this;
                self.$confirm("确定重置该用户密码吗?", "提示", {type: 'warning'})
                    .then(() => {
                        self.$axios.post('/users/reset', {
                            uuid: row.uuid,
                            upwd: md5('123456')
                        }).then(function (res) {
                            if (res.data.code == 0) {
                                self.$message.info(res.data.message);
                            } else {
                                self.$message.error(res.data.message);
                            }
                        }).catch(function (err) {
                            self.$message.error('请求服务器失败，请稍后再试！');
                        })
                    }).catch(() => {
                    self.$message.info('已取消重置密码操作!');
                })
            },
            //分页
            handleCurrentChange(val){
                this.cur_page = val;
                this.findByParam()
            },
            findByParam(){
                let self=this
                let params={
                    skipnum:self.pagerow*(self.cur_page-1),
                    pagesize:self.pagerow
                }
                if(self.phone!=='')
                {
                    params.phone=self.phone
                }

                self.$axios.post('/users/find',{params:params}).then(function (response) {
                    let newUserData=response.data.data
                    let roleList=self.roleList
                    newUserData.forEach(function (item,index){
                        for(let roleitem of roleList)
                        {
                            if(item.utype===roleitem.roleid)
                            {
                                item.utypename=roleitem.rolename
                            }
                        }
                    })
                    self.tableData=newUserData//response.data.data
                    self.totalPage=response.data.rowcount
                })

            },
            //页面初始化
            findrecord(){
                let self=this
                let roleparams = {
                    skipnum:0,
                    pagesize: 100
                }
                self.$axios.post('/role/getrolelist', roleparams)
                    .then(function (response) {
                        if (response.data.code == 0) {
                            self.roleList = response.data.data;
                        } else {
                            self.$message.error(response.data.message);
                        }
                        self.$axios.post('/users/find',{params:{skipnum:self.pagerow*(self.cur_page-1),pagesize:self.pagerow}}).then(function (response) {
                            let newUserData=response.data.data
                            let roleList=self.roleList
                            newUserData.forEach(function (item,index){
                                for(let roleitem of roleList)
                                {
                                    if(item.utype===roleitem.roleid)
                                    {
                                        item.utypename=roleitem.rolename
                                    }
                                }
                            })

                            self.tableData=newUserData//response.data.data
                            self.totalPage=response.data.rowcount

                        })
                    }).catch(function (error) {
                    throw error;
                    self.$message.error('获取用户类型列表失败，请稍后再试！');
                });


            }
        }
    }
</script>

<style scoped>
    .handle-box{
        margin-bottom: 20px;
    }
    .handle-select{
        width: 120px;
    }
    .handle-input{
        width: 300px;
        display: inline-block;
    }
    .el-checkbox{
        width: 120px;
    }
    .el-checkbox+.el-checkbox,.el-checkbox:first-child{
        margin:10px 20px;
    }

    .handle-box {
        margin-bottom: 20px;
    }

    .fr {
        float: right;
    }

    .handle-input {
        width: 200px;
        display: inline-block;
    }
</style>
