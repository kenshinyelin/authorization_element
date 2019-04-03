<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-menu"></i> 内容管理</el-breadcrumb-item>
                <el-breadcrumb-item>栏目管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="handle-box">
            <el-button type="primary" size="mini" icon="" @click="addroot">添加栏目</el-button>
        </div>

        <el-tree :data="items" :props="defaultProps" :expand-on-click-node="false" default-expand-all>
            <span class="custom-tree-node" slot-scope="{ node, data }" style="float: right">
              <span>{{ node.label }}</span>
              <span>
                <el-tag size="mini" v-if="data.showflag==1">显示</el-tag>
                <el-tag size="mini" type="danger" v-if="data.showflag==0">不显示</el-tag>
              </span>
              <span>
                <el-button type="text" size="mini" @click="add(node,data)">新增</el-button>
                <el-button type="text" size="mini" @click="edit(node,data)">修改</el-button>
                <el-button type="text" size="mini" @click="() => deleteRow(data)">删除</el-button>
              </span>
            </span>
        </el-tree>
        <!--新增弹窗-->
        <el-dialog title="新增栏目" :visible.sync="addFormVisible" width="30%">
            <el-form :model="form" size="mini" :rules="rules" ref="ruleForm" label-width="120px">
                <el-form-item label="栏目名称:" prop="catname">
                    <el-input v-model="form.catname" placeholder="请输入栏目名称" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="栏目url:" prop="caturl">
                    <el-input v-model="form.caturl" placeholder="请输入栏目url" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="icon:" prop="iconclass">
                    <el-input v-model="form.iconclass" placeholder="请输入icon类名" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="icon颜色" prop="iconcolor">
                    <el-input v-model="form.iconcolor" placeholder="请输入icon颜色" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="父级对象:">
                    <el-input v-model="catname" auto-complete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="显示" prop="showflag">
                    <el-switch active-value="1" inactive-value="0" v-model="form.showflag"></el-switch>
                </el-form-item>
                <el-form-item label="类型">
                    <el-select v-model="form.cattype" disabled placeholder="请选择栏目类型">
                        <el-option label="普通" value="N"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="关键字:">
                    <el-input v-model="form.keyword" placeholder="关键字(以中文标点的，隔开)" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="排序:">
                    <el-input-number v-model="form.sortid" :min="1" :max="100" label="描述文字"></el-input-number>
                </el-form-item>
                <el-form-item label="栏目描述:">
                    <el-input type="textarea"
                              v-model="form.catcomment"
                              placeholder="请输入栏目描述"
                              auto-complete="off">
                    </el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="addFormVisible = false;resetForm()">取 消</el-button>
                <el-button type="primary" @click="addConfirm('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>
        <!-- 编辑弹窗 -->
        <el-dialog title="修改栏目" size="tiny" :visible.sync="editFormVisible" width="30%">
            <el-form :model="form" size="mini" :rules="rules" ref="ruleForm" label-width="120px">
                <el-form-item label="栏目名称:" prop="catname">
                    <el-input v-model="form.catname" placeholder="请输入栏目名称" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="栏目url:" prop="caturl">
                    <el-input v-model="form.caturl" placeholder="请输入栏目url" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="icon:" prop="iconclass">
                    <el-input v-model="form.iconclass" placeholder="请输入icon类名" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="icon颜色" prop="iconcolor">
                    <el-input v-model="form.iconcolor" placeholder="请输入icon颜色" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="显示" prop="showflag">
                    <el-switch active-value="1" inactive-value="0" v-model="form.showflag"></el-switch>
                </el-form-item>
                <el-form-item label="类型">
                    <el-select v-model="form.cattype" disabled placeholder="请选择栏目类型">
                        <el-option label="普通" value="N"></el-option>
                        <el-option label="ROOT" value="O"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="关键字:">
                    <el-input v-model="form.keyword" placeholder="关键字(以中文标点的，隔开)" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="排序:">
                    <el-input-number v-model="form.sortid" :min="1" :max="100" label="描述文字"></el-input-number>
                </el-form-item>
                <el-form-item label="栏目描述:" prop="catcomment">
                    <el-input type="textarea"
                              v-model="form.catcomment"
                              placeholder="请输入栏目描述"
                              auto-complete="off">
                    </el-input>
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
          label: 'catname'
        },
        addFormVisible: false,
        editFormVisible: false,
        catname: '',
        form: {
          catid: '',        //栏目id
          catname: '',      //栏目名称
          cattype: 'N',    //栏目类型
          keyword: '',      //关键字
          iconclass:"",   // icon类名
          iconcolor:"",   // icon颜色
          catcomment: '',  //栏目描述
          caturl: '',      //栏目url
          parentid: '',     //父级id
          sortid: 1,      //排序编号
          showflag: '1'      //是否显示
        },
        rules: {
          catname: [{required: true, message: '请输入名称', trigger: 'blur'}],
          caturl: [{required: true, message: '请输入栏目url', trigger: 'blur'}],
        }
      };
    },
    methods: {
      findrecord() {
        const self = this
        this.$axios.post('/cat/getcatlist', {parentid: 'ROOT'})
          .then(function (response) {
            // console.log(response.data);
            self.items = response.data.data
          })
          .catch(function (error) {
            console.log(error);
          });
      },
      deleteRow(data) {
        // console.log(data.children.length);
        if (data.children.length > 0) {
          this.$message.error('此栏目还有子节点,不能直接删除!!!');
        } else {
          this.$confirm("确定删除此记录吗?", "提示", {type: 'warning'})
            .then(() => {
              this.$axios.post('/cat/del', {catid: data.catid})
                .then((res) => {
                  if (res.data.code == 0) {
                    this.$message.info(res.data.message);
                    this.findrecord()
                  } else {
                    this.$message.error(res.data.message);
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
        this.form.parentid = data.catid;
        this.form.sortid = data.children.length * 1 + 1;
        this.catname = data.catname;
      },
      addroot() {
        this.addFormVisible = true;
        this.form.parentid = 'ROOT';
        this.form.sortid = this.items.length * 1 + 1;
        this.catname = 'ROOT';
      },
      addConfirm(ruleForm) {
        var self = this;
        self.$refs[ruleForm].validate((valid) => {
          if (valid) {
            self.form.catid = 'cat' + (Math.floor(Math.random() * 10000000000))

            this.$axios.post('/cat/add', self.form).then(res => {
              if (res.data.code == 0) {
                self.$message.info(res.data.message);
                self.addFormVisible = false;
                self.findrecord()
                self.resetForm()
              } else {
                self.$message.error(res.data.message);
              }
            }).catch(err => {
              self.$message.error('请求服务器失败，请稍后再试！');
            })
          } else {
            self.$message({
              message: '信息有误或者不完整，请重试。',
              type: 'warning'
            });
            return false;
          }
        });
      },
      edit(node, data) {
        this.editFormVisible = true;
        this.form.catid = data.catid;
        this.form.parentid = data.parentid;
        this.form.keyword = data.keyword;
        this.form.sortid = data.sortid;
        this.form.cattype = data.cattype;
        this.form.caturl = data.caturl;
        this.form.showflag = data.showflag;
        this.form.catname = data.catname;
        this.form.iconclass = data.iconclass;
        this.form.catcomment = data.catcomment;
        this.form.iconcolor=data.iconcolor;
      },
      editConfirm(ruleForm) {
        if (this.form.parentid != 'ROOT' && this.form.showflag == 0) {
          this.$message.error('二级栏目只能为显示状态,请直接删除或设置一级栏目隐藏！');
          return
        }
        this.$refs[ruleForm].validate((valid) => {
          if (valid) {
            this.$axios.post('/cat/edit', this.form).then((res) => {
              if (res.data.code == 0) {
                this.$message.info(res.data.message);
                this.editFormVisible = false;
                this.findrecord()
                this.resetForm()
              } else {
                this.$message.error(res.data.message);
              }
            }).catch((err) => {
              this.$message.error('请求服务器失败，请稍后再试！');
            })
          } else {
            return false;
          }
        })
      },
      resetForm() {
        this.form = {
          catid: '',        //栏目id
          catname: '',      //栏目名称
          caturl: '',       //栏目url
          cattype: 'N',     //栏目类型
          keyword: '',      //关键字
          catcomment: '',   //栏目描述
          parentid: '',     //父级id
          sortid: 1,      //排序编号
          iconclass:'',
          iconcolor:'',
          showflag: '1'     //是否显示
        }
      },
    },
    created() {
      this.findrecord()
    }
  };
</script>

<style scoped>
    .handle-box {
        margin-bottom: 10px;
    }

    .custom-tree-node {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: space-between;
        font-size: 14px;
        padding-right: 8px;
    }
</style>