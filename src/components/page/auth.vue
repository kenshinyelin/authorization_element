<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-menu"></i> 系统管理</el-breadcrumb-item>
                <el-breadcrumb-item>权限管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="handle-box">
            <el-button type="primary" size="mini" icon="search" @click="addroot()">添加权限</el-button>
        </div>

        <el-tree :data="items" :props="defaultProps" :expand-on-click-node="false" default-expand-all>
    <span class="custom-tree-node" slot-scope="{ node, data }" style="float: right">

      <span>{{ node.label }}</span>
        <span>
          <el-button type="text"
                     size="mini"
                     @click="add(node,data)">
            新增
          </el-button>
          <el-button type="text"
                     size="mini"
                     @click="edit(node,data)">
            修改
          </el-button>
          <el-button type="text"
                     size="mini"
                     @click="() => deleteRow(data)">
            删除
          </el-button>
        </span>


      </span>
        </el-tree>
        <!--新增弹窗-->
        <el-dialog title="新增权限" :visible.sync="addFormVisible" size="tiny">
            <el-form :model="form" :rules="rules" ref="ruleForm">

                <el-form-item label="父级对象:" :label-width="formLabelWidth">
                    <el-input v-model="authname" auto-complete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="权限类型" :label-width="formLabelWidth" prop="authtype">
                    <el-select v-model="form.authtype" placeholder="请选择权限类型">
                        <el-option label="基础菜单" value="M"></el-option>
                        <el-option label="操作和功能" value="F"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="权限名称:" :label-width="formLabelWidth" prop="authname">
                    <el-input v-model="form.authname" placeholder="请输入权限名称" auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="权限地址:" :label-width="formLabelWidth" prop="authurl">
                    <el-input v-model="form.authurl" placeholder="权限地址" auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="排序:" :label-width="formLabelWidth">
                    <el-input-number v-model="form.sortid" :min="1" :max="10" label="描述文字"></el-input-number>
                </el-form-item>

                <el-form-item label="权限描述:" :label-width="formLabelWidth" prop="authcomment">
                    <el-input v-model="form.authcomment" placeholder="请输入权限描述" auto-complete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="addFormVisible = false;resetForm()">取 消</el-button>
                <el-button type="primary" @click="addConfirm('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>
        <!-- 编辑弹窗 -->
        <el-dialog title="编辑权限" size="tiny" :visible.sync="editFormVisible">
            <el-form :model="form" :rules="rules" ref="ruleForm">

                <el-form-item label="父级对象:" :label-width="formLabelWidth">
                    <el-input v-model="form.parentid" auto-complete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="权限类型" :label-width="formLabelWidth" prop="authtype">
                    <el-select v-model="form.authtype" placeholder="请选择权限类型">
                        <el-option label="基础菜单" value="M"></el-option>
                        <el-option label="操作和功能" value="F"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="权限名称:" :label-width="formLabelWidth" prop="authname">
                    <el-input v-model="form.authname" placeholder="请输入权限名称" auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="权限地址:" :label-width="formLabelWidth" prop="authurl">
                    <el-input v-model="form.authurl" placeholder="权限地址" auto-complete="off"></el-input>
                </el-form-item>

                <el-form-item label="排序:" :label-width="formLabelWidth">
                    <el-input-number v-model="form.sortid" :min="1" :max="10" label="描述文字"></el-input-number>
                </el-form-item>

                <el-form-item label="权限描述:" :label-width="formLabelWidth" prop="authcomment">
                    <el-input v-model="form.authcomment" placeholder="请输入权限描述" auto-complete="off"></el-input>
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
    data() {
      return {
        items: [],
        defaultProps: {
          children: 'children',
          label: 'authname'
        },
        addFormVisible: false,
        editFormVisible: false,
        formLabelWidth: '120px',
        authname: '',
        authtype: '',
        form: {
          authid: '',
          authname: '',
          authtype: '',
          authurl: '',
          sortid: '1',
          status: '1',
          parentid: '',
          authflag: '1',
          authcomment: ''
        },
        rules: {
          authtype: [
            {required: true, message: '请选择权限类型', trigger: 'blur'}
          ],
          authname: [
            {required: true, message: '请输入权限名称', trigger: 'blur'}
          ],
          authurl: [
            {required: true, message: '请输入url', trigger: 'blur'}
          ],
          authcomment: [
            {required: true, message: '请输入描述', trigger: 'blur'}
          ]
        }
      };
    },
    methods: {
      findrecord(data) {
        const self = this
        this.$axios.post('/auth/getauthlist', {parentid: 'ROOT'})
          .then(function (response) {
            self.items = response.data.data

          })
          .catch(function (error) {
            console.log(error);
          });
      }
      ,
      deleteRow(data) {
        if (data.children.length > 0) {
          this.$message.info('该记录有叶子节点，不能直接删除!');
        }
        else {
          this.$confirm("确定删除此记录吗?", "提示", {type: 'warning'})
            .then(() => {
              this.$axios.post('/auth/del', {authid: data.authid})
                .then((res) => {
                  if (res.data.code == 0) {
                    this.$message.info('您已成功删除该记录!');
                    this.findrecord()
                  }
                  else {
                    this.$message.error('请求服务器失败，请稍后再试！');
                  }
                }).catch(err => {
                this.$message.error('请求服务器失败，请稍后再试！');
              })

            }).catch(() => {
            this.$message.info('已取消该删除操作!');
          })
        }

      },
      add(node, data) {
        this.addFormVisible = true;
        this.form.authid = data.authid;
        this.form.parentid = data.authid;
        this.authname = data.authname;
      },
      addroot() {
        this.addFormVisible = true;
        this.form.parentid = 'ROOT';
        this.authname = 'ROOT';

      },
      addConfirm(ruleForm) {
        this.$refs[ruleForm].validate((valid) => {
          if (valid) {
            this.$axios.post('/auth/add', this.form).then(res => {
              if (res.data.code == 0) {

                this.addFormVisible = false;
                this.$message.info('新增权限成功！');
                this.findrecord()
                this.resetForm()
              }
              else if (res.data.message == "user exist") {
                this.$message("该权限已存在！")
              }
              else if (res.data.message == "no authorize") {
                this.$message.error("对不起,你暂无权限执行该操作！")
              }
              else {
                this.$message.error('新增权限失败，请稍后再试！');
              }
            }).catch(err => {
              this.$message.error('新增权限失败，请稍后再试！');
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
      edit(node, data) {
        this.editFormVisible = true;
        this.form.authid = data.authid;
        this.form.authtype = data.authtype;
        this.form.authurl = data.authurl;
        this.form.authname = data.authname;
        this.form.parentid = data.parentid;
        this.form.sortid = data.sortid;
        this.form.authcomment = data.authcomment;
      },
      editConfirm(ruleForm) {
        this.$refs[ruleForm].validate((valid) => {
          if (valid) {
            let url = '/auth/edit';
            this.$axios.post(url, this.form).then((res) => {
              if (res.data.code == 0) {
                this.editFormVisible = false;
                this.$message.info('修改信息成功！');
                this.findrecord()
                this.resetForm()
              }
              else {
                this.$message.error('修改信息失败，请稍后再试！');
              }
            }).catch((err) => {
              this.$message.error('修改信息失败，请稍后再试！');
            })
          } else {
            return false;
          }
        })
      },
      resetForm() {
        this.form = {
          authid: '',
          authname: '',
          authtype: '',
          authurl: '',
          sortid: '1',
          status: '1',
          parentid: '',
          authflag: '1',
          authcomment: ''
        }
      },
    },
    beforeMount() {
      //获取菜单
      this.findrecord()
    }
  };
</script>

<style>
    .custom-tree-node {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: space-between;
        font-size: 14px;
        padding-right: 8px;
    }
</style>