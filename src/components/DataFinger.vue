

<template>
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
      Drop file here or <em>click to upload</em>
    </div>
    <template #tip>
      <div class="el-upload__tip">
        jpg/png files with a size less than 500kb
      </div>
    </template>
  </el-upload>

  <div class="el-upload__tip">数据指纹为：{{ md5 }}</div>
</template>

<script>
import SparkMD5 from 'spark-md5'

export default {
  data() {
    return {
      md5: ''
    }
  },
  methods: {
    onFrontImgChange: function (file, fileList) {
      //console.log(file)
      const _this = this
      var fileReader = new FileReader();
      //此处打印file可看到file下的raw为文件属性
      var dataFile = file.raw;
      let blobSlice = File.prototype.slice || File.prototype.mozSlice || File.prototype.webkitSlice
      var spark = new SparkMD5.ArrayBuffer();
      //获取文件二进制数据
      fileReader.readAsArrayBuffer(dataFile)

      //异步执行函数
      fileReader.onload = function (e) {
        spark.append(e.target.result);
        _this.md5 = spark.end()
        console.log(_this.md5)
        // this.md5 = md5
        //此处this指向发生改变，需提前声明const _this = this
        // _this.imgdata.md5 = md5; //此处是将文件的md5值放入imgdata中
        //上传图片，如手动上传可不在此处执行
        // _this.upload('frontImg')
      }
    },
    //文件上传触发函数
    upload: function (obj) {
      this.$refs[obj].submit();
    },

  }
}
</script>


