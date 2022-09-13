<template>
  <div style="margin: 20px">
    <el-form
      label-width="150px"
      :model="copyrightForm"
      label-position="top"
      ref="copyrightForm"
    >
      <!-- <el-form-item label="Your Copyright">
        <el-input id="copyrightdata" v-model="copyrightdata"/>
      </el-form-item> -->
      <el-form-item label="Uid">
        <el-input id="uid" v-model="uid" />
      </el-form-item>
      <!-- <el-form-item label="sign">
        <el-input id="thesign" v-model="thesign"/>
      </el-form-item> -->
      <el-form-item label="作品名称">
        <el-input id="name" v-model="copyrightForm.name" />
      </el-form-item>
      <el-form-item label="作品数据指纹">
        <el-upload
          class="upload-demo"
          drag
          multiple
          :show-file-list="true"
          :auto-upload="false"
          :on-change="onFrontImgChange"
        >
          <!-- <img v-if="persform.frontImg" :src='getimage(persform.frontImg)' class="avatar"> -->
          <!-- <img v-else src="" class="avatar"> -->
          <el-icon class="el-icon--upload"><upload-filled /></el-icon>
          <!-- <p style="margin:0" class="sp-99">上传文件</p> -->
          <div class="el-upload__text">
            将文件拖放到此处或 <em>点击上传</em>
          </div>
          <template #tip>
            <div class="el-upload__tip">
              数据指纹为：{{ copyrightForm.dataFinger }}
            </div>
          </template>
        </el-upload>
      </el-form-item>
      <el-form-item label="作品类别">
        <el-select
          v-model="copyrightForm.category"
          placeholder="请选择你的作品类别"
          style="display: block"
        >
          <el-option label="无" value="0" />
          <el-option label="符合作品特征的其他智力成果" value="1" />
          <el-option label="文字作品" value="2" />
          <el-option label="口述作品" value="3" />
          <el-option label="音乐、戏剧、曲艺、舞蹈、杂技艺术作品" value="4" />
          <el-option label="美术、建筑作品" value="5" />
          <el-option label="摄影作品" value="6" />
          <el-option label="视听作品" value="7" />
          <el-option
            label="工程设计图、产品设计图、地图、示意图等图形作品和模型作品"
            value="8"
          />
          <el-option label="计算机软件" value="9" />
        </el-select>
      </el-form-item>
      <el-form-item label="作品创作性质">
        <el-select
          v-model="copyrightForm.createType"
          placeholder="请选择你的作品创作性质"
          style="display: block"
        >
          <el-option label="无" value="0" />
          <el-option label="其他" value="1" />
          <el-option label="原创" value="2" />
          <el-option label="改编" value="3" />
          <el-option label="翻译" value="4" />
          <el-option label="汇编" value="5" />
          <el-option label="注释" value="6" />
          <el-option label="整理" value="7" />
        </el-select>
      </el-form-item>
      <el-form-item label="权利取得方式">
        <el-select
          v-model="copyrightForm.rightObtainType"
          placeholder="请选择你的权利取得方式"
          style="display: block"
        >
          <el-option label="无" value="0" />
          <el-option label="其他" value="1" />
          <el-option label="原始" value="2" />
          <el-option label="继承" value="3" />
          <el-option label="承受" value="4" />
        </el-select>
      </el-form-item>
      <el-form-item label="权利拥有方式">
        <el-select
          v-model="copyrightForm.rightOwnType"
          placeholder="请选择你的权利拥有方式"
          style="display: block"
        >
          <el-option label="无" value="0" />
          <el-option label="全部权利" value="1" />
          <el-option label="发表权" value="2" />
          <el-option label="署名权" value="3" />
          <el-option label="修改权" value="4" />
          <el-option label="复制权" value="5" />
          <el-option label="发行权" value="6" />
          <el-option label="出租权" value="7" />
          <el-option label="展览权" value="8" />
          <el-option label="表演权" value="9" />
          <el-option label="放映权" value="10" />
          <el-option label="广播权" value="11" />
          <el-option label="信息网络传播权" value="12" />
          <el-option label="摄制权" value="13" />
          <el-option label="改编权" value="14" />
          <el-option label="翻译权" value="15" />
          <el-option label="汇编权" value="16" />
          <el-option label="除以上权利外的其他权利" value="17" />
        </el-select>
      </el-form-item>
      <el-form-item label="著作权人类型">
        <el-select
          v-model="copyrightForm.authorType"
          placeholder="请选择你的著作权人类型"
          style="display: block"
        >
          <el-option label="无" value="0" />
          <el-option label="其他类型" value="1" />
          <el-option label="网络作家" value="2" />
          <el-option label="专职作家" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="著作权人名称">
        <el-input id="authorName" v-model="copyrightForm.authorName" />
      </el-form-item>
      <el-form-item label="用户地址">
        <el-input id="owner" v-model="copyrightForm.owner" />
      </el-form-item>
      <el-form-item label="作品完成时间">
        <el-date-picker
          v-model="copyrightForm.completionTime"
          placeholder="Pick a day"
          format="YYYY/MM/DD"
          value-format="x"
        />
      </el-form-item>
      <el-form-item label="作品存储地址及提取码">
        <el-input id="workUrl" v-model="copyrightForm.workUrl" />
      </el-form-item>
      <el-form-item label="版权局登记状态">
        <el-select
          v-model="copyrightForm.status"
          placeholder="请选择你的版权局登记状态"
          style="display: block"
        >
          <el-option label="无" value="0" />
          <el-option label="其他" value="1" />
          <el-option label="未登记" value="2" />
          <el-option label="审核中" value="3" />
          <el-option label="已登记" value="4" />
          <el-option label="审核失败" value="5" />
        </el-select>
      </el-form-item>
      <el-form-item label="登记版权局">
        <el-input
          id="copyrightOffice"
          v-model="copyrightForm.copyrightOffice"
        />
      </el-form-item>
      <el-form-item label="链上存证有效状态">
        <el-select
          v-model="copyrightForm.isStatus"
          placeholder="请选择你的链上存证有效状态"
          style="display: block"
        >
          <el-option label="无" value="0" />
          <el-option label="生效" value="1" />
          <el-option label="失效" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item label="扩展信息" prop="extendField">
        <el-input id="extendField" v-model="copyrightForm.extendField" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit" id="add">存证</el-button>
        <el-button @click="resetForm">重置</el-button>
      </el-form-item>
    </el-form>
    <p>txReceipt:{{ txReceipt }}</p>
    <p>copyrightForm:{{ copyrightForm }}</p>
    <p>copyrightData:{{ copyrightData }}</p>
    <p>thesign:{{ thesign }}</p>
    <p>thekey:{{ thekey }}</p>
  </div>
</template>

<script>
const Web3 = require("web3");
import SparkMD5 from "spark-md5";
import { reactive, ref } from "vue";
import addjs from "../util/Web3.js";


export default {
  //   methods: {
  //   test () {
  //     // 调用外部js中的jsTest1()方法
  //     addjs.query()
  //   }
  // }
  data() {
    return {
      thekey: "", //2c4ebce016590054647313419
      copyrightdata: [
        "123123",
        "a",
        "1245",
        2,
        1,
        1,
        1,
        1,
        "Alice",
        "0x086816ED0dF2B68e292fcD67B852dd97B92f059D",
        1,
        "http",
        1,
        "office",
        1,
        "more",
      ],
      uid: "2c4ebce0",
      thesign:
        "0xcf91b07f7a9a0b623d8fbebe0ac8ebcabd543b180fc2502d8af5a98001bcb0997bb60958d987e89fdd0d08392f6d1f2b2276d1cef8b5f82df2c47ec3b02d0a331b",
      txReceipt: [],
      copyrightForm: {
        name: "test",
        dataFinger: "1",
        category: "1",
        createType: "1",
        rightObtainType: "1",
        rightOwnType: "1",
        authorType: "1",
        authorName: "test",
        owner: "0x80ec8696D724686adCC88fFF14Bde24A4d0e38De",
        completionTime: "1",
        workUrl: "test",
        status: "1",
        copyrightOffice: "test",
        isStatus: "1",
        extendField: "test",
      },
      copyrightData: [],
    };
  },
  // async created() {
  //   //  初始化 web3及账号
  //   await this.initWeb3Account()
  //    //  初始化合约实例
  //   await this.initContract()
  //    //  添加版权
  //   await this.addCopyright()
  // },

  methods: {
    resetForm() {
      this.copyrightForm = this.$options.data().copyrightForm
    },

    onFrontImgChange: function (file, fileList) {
      //console.log(file)
      const _this = this;
      var fileReader = new FileReader();
      //此处打印file可看到file下的raw为文件属性
      var dataFile = file.raw;
      let blobSlice =
        File.prototype.slice ||
        File.prototype.mozSlice ||
        File.prototype.webkitSlice;
      var spark = new SparkMD5.ArrayBuffer();
      //获取文件二进制数据
      fileReader.readAsArrayBuffer(dataFile);

      //异步执行函数
      fileReader.onload = function (e) {
        spark.append(e.target.result);
        _this.copyrightForm.dataFinger = spark.end();
        console.log(_this.copyrightForm.dataFinger);
        // this.md5 = md5
        //此处this指向发生改变，需提前声明const _this = this
        // _this.imgdata.md5 = md5; //此处是将文件的md5值放入imgdata中
        //上传图片，如手动上传可不在此处执行
        // _this.upload('frontImg')
      };
    },
    //文件上传触发函数
    upload: function (obj) {
      this.$refs[obj].submit();
    },

    async setArray() {
      for (let key in this.copyrightForm) {
        //for循环let key是对象里面的键，再通过,[]的形式this.objNum[item]去获取对象的value值
        // console.log('key',key);
        // console.log('value',this.copyrightForm[key]);
        this.copyrightData.push(this.copyrightForm[key]);
      }
      // this.data_formInput.keyword = ''//提交input之后置空
      // this.data_formInput.describe = ''
    },

    async setKey(uid) {
      const timestamp = new Date().getTime();
      const randomNum = Math.floor(Math.random() * 9000);
      console.log("key =", uid + timestamp + randomNum);
      return uid + timestamp + randomNum;
    },

    async onSubmit() {
      this.thekey = await this.setKey(this.uid);
      this.copyrightData.push(this.thekey);
      //把存证信息放入数组
      for (let key in this.copyrightForm) {
        this.copyrightData.push(this.copyrightForm[key]);
      }

      if (typeof window.ethereum !== "undefined") {
        console.log("Ethereum Provider is existed!");
        if (window.ethereum.isMetaMask) {
          console.log("This is MetaMask!");
        }
      }
      console.log(typeof this.copyrightdata);
      console.log(typeof this.uid);
      const Web3 = require("web3");
      window.addEventListener("load", function () {
        // 检查web3是否已经注入到(Mist/MetaMask)
        if (typeof web3 !== "undefined") {
          // 使用 Mist/MetaMask 的提供者
          web3js = new Web3(web3.currentProvider);
        } else {
          // 处理用户没安装的情况， 比如显示一个消息
          // 告诉他们要安装 MetaMask 来使用我们的应用
        }

        // 现在你可以启动你的应用并自由访问 Web3.js:
        startApp();
      });

      async function login() {
        if (typeof window.ethereum !== "undefined") {
          let addr = await ethereum.request({ method: "eth_requestAccounts" }); //授权连接钱包
          console.log("用户钱包地址:", addr[0]);
        } else {
          console.log("未安装钱包插件！");
        }
      }
      login();

      //监听钱包切换
      ethereum.on("accountsChanged", function (accounts) {
        console.log("钱包切换");
        window.location.reload();
      });
      //监听链网络改变
      ethereum.on("chainChanged", () => {
        console.log("链切换");
        window.location.reload();
      });
      if (window.web3) {
        const accounts = await ethereum.request({
          method: "eth_requestAccounts",
        });
        // const web3 = new Web3(new Web3.providers.HttpProvider('https://matic-mumbai.chainstacklabs.com'))
        const web3 = new Web3(window.ethereum);
        const ABI = require("../util/copyright.json");
        const contractAddress = "0x90A9a53Db94F58a2F3a603b48e32434F8Ce359c4";
        const copyright = new web3.eth.Contract(ABI, contractAddress);
        console.log(copyright);

        console.log(ethereum.selectedAddress); // 还未申请授权，值为null
        // const accounts = await ethereum.request({ method: 'eth_requestAccounts' })
        const account = accounts[0];
        web3.eth.defaultAccount = accounts[0];
        const add = await web3.eth.accounts[0];
        console.log(add);
        console.log(ethereum.selectedAddress);


        const signdata = await copyright.methods
          .getTheSigndata(this.copyrightData)
          .call();
        console.log(signdata);

        this.thesign = await web3.eth.sign(signdata, accounts[0]);

        console.log(this.thesign);


        const transactionParameters = {
          from: ethereum.selectedAddress,
          to: contractAddress,
          data: copyright.methods
            .copyrightAdd(this.copyrightData, this.uid, this.thesign)
            .encodeABI(),
          // chainId: '0x80001',
          gas: "0x6ddd0",
          value: "0x0",
          // gasPrice:'0x09184e72a000',
        };
        await ethereum
          .request({
            method: "eth_sendTransaction",
            params: [transactionParameters],
          })
          .then((txHash) => (this.txReceipt = txHash))
          .catch((error) => console.error);
      }
      console.log(this.txReceipt);
      this.copyrightData = [];
      // ElNotification({
      //   title: 'Prompt',
      //   message: 'This is a message that does not automatically close',
      //   duration: 0,
      // })
    },
  },
};

</script>

<style lang="scss" scoped></style>
