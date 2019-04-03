<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-menu"></i> 轮播图管理</el-breadcrumb-item>
                <!--<el-breadcrumb-item>用户管理</el-breadcrumb-item>-->
            </el-breadcrumb>
        </div>
        <div class="handle-box">

            <el-input  placeholder="服务器名称" class="handle-input mr10" v-model="name"></el-input>
            <el-button type="primary" icon="search" @click="search" >查询</el-button>
            <el-button type="primary" icon="search" @click="addFormVisible = true">添加轮播图</el-button>

        </div>
        <el-table   :data="tableData" border style="width: 100%" ref="multipleTable" >

            <el-table-column prop="name" label="轮播图名称" width="150"></el-table-column>
            <el-table-column prop="comment" label="备注" width="150"></el-table-column>
            <el-table-column prop="imageurl" label="图片地址" width="" :show-overflow-tooltip="true"></el-table-column>
            <el-table-column prop="pageurl" label="页面地址" width="" :show-overflow-tooltip="true"></el-table-column>
            <el-table-column prop="register_time" label="添加时间" width="200">
                <template slot-scope="scope">
                    <span>{{scope.row.register_time?$moment(scope.row.register_time).format('YYYY-MM-DD HH:mm:ss'):''}}</span>
                </template>
            </el-table-column>


            <el-table-column label="操作" width="250" fixed="right">
                <template slot-scope="scope">
                    <el-button @click="editRecord(scope.$index, scope.row)"
                               size="small" >编辑 </el-button>
                    <el-button @click="deleteRow(scope.row._id)" type="danger"
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

        <!--新增轮播图弹窗-->
        <el-dialog title="新增轮播图" :visible.sync="addFormVisible" size="tiny">
            <el-form :model="form" :rules="rules" ref="ruleForm">
                <el-form-item label="轮播图名称:" :label-width="formLabelWidth" prop="name">
                    <el-input v-model="form.name" placeholder="请输入轮播图名称"  auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="备注:" :label-width="formLabelWidth" prop="comment">
                    <el-input v-model="form.comment" placeholder="请输入服务器地址" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="图片地址:" :label-width="formLabelWidth" prop="imageurl">
                    <el-input v-model="form.imageurl" placeholder="请输入图片地址" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="页面地址:" :label-width="formLabelWidth" prop="pageurl">
                    <el-input v-model="form.pageurl" placeholder="请输入页面地址" auto-complete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="addFormVisible = false;resetForm()">取 消</el-button>
                <el-button type="primary" @click="addRecord('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>
        <!-- 编辑轮播图弹窗 -->
        <el-dialog title="编辑轮播图名称" size="tiny" :visible.sync="editFormVisible"  >
            <el-form :model="form" :rules="rules" ref="ruleForm">
                <el-form-item label="轮播图名称:" :label-width="formLabelWidth" prop="name">
                    <el-input v-model="form.name" placeholder="请输入轮播图名称"  auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="备注:" :label-width="formLabelWidth" prop="comment">
                    <el-input v-model="form.comment" placeholder="请输入服务器地址" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="图片地址:" :label-width="formLabelWidth" prop="imageurl">
                    <el-input v-model="form.imageurl" placeholder="请输入图片地址" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="页面地址:" :label-width="formLabelWidth" prop="pageurl">
                    <el-input v-model="form.pageurl" placeholder="请输入页面地址" auto-complete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="editFormVisible = false;resetForm()">取 消</el-button>
                <el-button type="primary" @click="editConfirm('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>
    </div>

</template>

<script>
    export default {
        data: function() {
            return {
                name:'',//查询输入框
                tabPosition: 'left',
                tableData:[],
                addFormVisible:false,
                editFormVisible:false,
                formLabelWidth: '120px',
                page:1,
                pagerow:10,
                pagination:1,
                cur_page:1,
                totalPage:1,
                form:{
                    name:'',
                    comment:'',
                    imageurl:'',
                    pageurl:''
                },
                rules: {
                    name:  [
                        {  required: true, message: '请输入服务器名称', trigger: 'blur' }
                    ]
                }
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

        },
        methods:{
            //查询
            search(){
                this.findByParam();
            },
            resetForm(){
                this.form={
                    name:'',
                    comment:'',
                    imageurl:'',
                    pageurl:''
                }
            },
            /*新增记录*/
            addRecord(ruleForm){
                this.$refs[ruleForm].validate((valid) => {
                    if (valid) {
                        this.$axios.post('/slide/add',this.form).then(res=>{
                            if(res.data.code ==0){
                                this.addFormVisible = false;
                                this.$message.info('新增轮播图成功！');
                                this.findrecord()
                                this.resetForm()
                            }
                            else if(res.data.code ==-2){
                                this.$message("该轮播图已存在！")
                            }
                            else{
                                this.$message.error('新增轮播图失败，请稍后再试！');
                            }
                        }).catch(err=>{
                            this.$message.error('新增轮播图失败，请稍后再试！');
                        })
                    }
                });
            },
            editRecord(index, row) {
                this.editFormVisible = true;
                this.form.slideid= row._id;
                this.form.name= row.name;
                this.form.comment= row.comment;
                this.form.imageurl= row.imageurl;
                this.form.pageurl= row.pageurl;

            },
            editConfirm(ruleForm){
                this.$refs[ruleForm].validate((valid) => {
                    if (valid) {
                        let url='/slide/update';
                        this.$axios.post(url, this.form).then((res)=>{
                            if(res.data.code == 0){
                                this.editFormVisible = false;
                                this.$message.info('更新信息成功！');
                                this.findrecord()
                                this.resetForm()
                            }
                            else{
                                this.$message.error('更新服务器信息失败，请稍后再试！');
                            }
                        }).catch((err)=>{
                            this.$message.error('更新服务器信息失败，请稍后再试！');
                        })
                    } else {
                        return false;
                    }
                })
            },
            deleteRow(id){
                this.$confirm("确定删除此记录吗?","提示",{type:'warning'})
                    .then(()=>{
                        this.$axios.post('/slide/del',{slideid:id})
                            .then((res)=>{
                                if(res.data.code == 0){
                                    this.$message.info('您已成功删除该记录!');
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
                if(self.name!=='')
                {
                    params.name=self.name
                }
                self.$axios.get('/slide/find',{params:params}).then(function (response) {
                    self.tableData=response.data.data
                    self.totalPage=response.data.rowcount
                })

            },
            //页面初始化
            findrecord(){
                let self=this
                self.$axios.get('/slide/find',{params:{skipnum:self.pagerow*(self.cur_page-1),pagesize:self.pagerow}}).then(function (response) {
                    self.tableData = response.data.data
                    self.totalPage = response.data.rowcount

                }).catch(function (error) {
                    console.log(error);
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
</style>
