<template>
  <div class="common-layout">
    <el-container class="container">
      <el-header class="header">Header</el-header>
      <el-container>
        <el-aside width="18%" class="aside">
          <el-menu :router='true'>
            <el-submenu index="/copyright">
              <template #title>
                <i class="el-icon-location"></i>
                <span>版权服务</span>
              </template>
              <el-menu-item index="/copyright/add">版权存证</el-menu-item>
              <el-menu-item index="/copyright/update">版权更新</el-menu-item>
              <el-menu-item index="/copyright/query">版权查询</el-menu-item>
            </el-submenu>
            <el-submenu index="2">
              <template #title>
                <i class="el-icon-location"></i>
                <span>导航二</span>
              </template>
            </el-submenu>
            <el-submenu index="/other">
              <template #title>
                <i class="el-icon-location"></i>
                <span>其他服务</span>
              </template>
              <el-menu-item index="/other/datafinger">文件指纹</el-menu-item>
            </el-submenu>
            <el-submenu index="/user">
              <template #title>
                <i class="el-icon-location"></i>
                <span>用户中心</span>
              </template>
              <el-menu-item index="/user/admin">管理中心</el-menu-item>
            </el-submenu>
          </el-menu>
        </el-aside>
        <el-main>
          <!-- 路由占位符 -->
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'

export default {
  // name: 'App',
  // components: {
  //   HelloWorld
  // }
}
</script>

<style>
.container {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  height: 100%;
  background-color: rgb(255, 255, 255);
}

.header {
  background-color: rgb(255, 255, 255);
}

.aside {
  background-color: rgb(84, 92, 100);
}
</style>
