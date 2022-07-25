<template>
  <div class="common-layout">
    <el-container class="container">
      <el-header class="header">Header</el-header>
      <el-container>
        <el-aside width="18%" class="aside">
          <el-menu>
            <el-submenu index="1">
              <template #title>
                <i class="el-icon-location"></i>
                <span>导航一</span>
              </template>
              <el-menu-item index="1-1">菜单1</el-menu-item>
              <el-menu-item index="1-2">菜单2</el-menu-item>
              <el-menu-item index="1-3">菜单3</el-menu-item>
            </el-submenu>
            <el-submenu index="2">
              <template #title>
                <i class="el-icon-location"></i>
                <span>导航二</span>
              </template>
            </el-submenu>
            <el-submenu index="3">
              <template #title>
                <i class="el-icon-location"></i>
                <span>导航三</span>
              </template>
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
