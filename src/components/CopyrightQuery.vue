<template>
  <div>
    <el-form label-width="120px">
      <el-form-item label="Copyright Key">
        <el-input id="key" v-model="key"/>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit" id="query">Query</el-button>
        <el-button>Cancel</el-button>
      </el-form-item>
    </el-form>
    {{copyrightRes}}
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="Key" label="Key" width="180" v-for='(item,i) in copyrightRes' :key="i" />
      <!-- eslint-disable-next-line
      <template slot-scope="scope">
                  <span>{{scope.row[index]}}</span>
                </template> -->
                
        <!-- {{ row.status == item.value? item.label: "" }} -->
      <el-table-column prop="Value" label="Value" width="180" />

    </el-table>
  </div>
</template>

<script>

export default {
  data() {
    return {
      key:"",
      copyrightRes:[]
    }
  },
  methods: {
    async onSubmit() {
      const Web3 = require('web3')
      if (typeof window.ethereum !== 'undefined') {
  console.log('Ethereum Provider is existed!')
  if (window.ethereum.isMetaMask) {
    console.log('This is MetaMask!')
  }
}

 const web3 = new Web3(new Web3.providers.HttpProvider('https://matic-mumbai.chainstacklabs.com'))
      const ABI = require('../util/copyright.json')
      const contractAddress = '0x90A9a53Db94F58a2F3a603b48e32434F8Ce359c4'
      const copyright = new web3.eth.Contract(ABI, contractAddress)

this.copyrightRes = await copyright.methods.copyrightQuery(this.key).call()
  console.log('query =', this.copyrightRes.values)
    }
  }
}
</script>
