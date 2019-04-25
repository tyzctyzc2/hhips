<template>
  <div id="kkk" class="fit">
    <h1>{{this.$route.query.sourcename}}</h1>
    <h1>全部：{{this.allProblemCount}}</h1>
    <h1>完成：{{this.passProblemCount}} ({{passProblemPercentage}}%)</h1>
    <h1>错误：{{this.wrongProblemCount}} ({{wrongProblemPercentage}}%)</h1>
    <table>
        <tr>
            <th>序号</th>
            <th>名称</th>
            <th>总数</th>
            <th>完成</th>
            <th>错误</th>
            <th>未做</th>
        </tr>
      <tr v-for="(item, index) in allChapters" :key="index">
        <td>
          <div>{{item.sourcechapterindex}}</div>
        </td>
        <td>
          <div>{{item.sourcechaptername}}</div>
        </td>
        <td>
          <div>{{item.chapterproblemcount}}</div>
        </td>
        <td>
          <div>{{item.problemDoneCount}}</div>
        </td>
        <td>
          <div>{{item.problemWrongCount}}</div>
        </td>
        <td>
          <div>{{item.problemBlankCount}}</div>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
import axios from 'axios'
var scrollY = 0

export default {
  name: 'PartList',
  data () {
    return {
      msg: 'Found Problem',
      inSelectMode: false,
      startSelect: null,
      allChapters: [],
      allProblemCount: 0,
      passProblemCount: 0,
      passProblemPercentage: 0,
      wrongProblemCount: 0,
      wrongProblemPercentage: 0,
      chapter: null,
      problemModule: [{id: 1, name: '计算'},
        {id: 2, name: '计数'},
        {id: 3, name: '应用题'},
        {id: 4, name: '几何'},
        {id: 5, name: '逻辑'},
        {id: 6, name: '数论'}],
      problemLevel: [{id: 1, name: '1'},
        {id: 2, name: '2'},
        {id: 3, name: '3'},
        {id: 4, name: '4'}],
      pickedModule: '1',
      pickedLevel: '1',
      allIndex: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35',
        'L1', 'L1L', 'L2', 'L2L', 'L3', 'L3L', 'L4', 'L4L', 'L5', 'L5L', 'L6', 'L6L', 'L7', 'L7L', 'L8', 'L8L',
        'Z01', 'Z02', 'Z03', 'Z04', 'Z05', 'Z06', 'Z07', 'Z08', 'Z09', 'Z10']
    }
  },
  watch: {
    pickedModule: function (val) {
      for (var i = 0; i < this.allProblems.length; i++) {
        this.allProblems[i].module = val
      }
    },
    pickedLevel: function (val) {
      for (var i = 0; i < this.allProblems.length; i++) {
        this.allProblems[i].level = val
      }
    },
    chapter: function (val) {
      for (var i = 0; i < this.allProblems.length; i++) {
        this.allProblems[i].chapter = val
      }
    }
  },
  ready: function () {
    console.log('ready, set scroll to ' + scrollY)
    window.scrollTo(0, scrollY)
  },
  methods: {
    getSummary () {
      console.log(this.allProblems)
      axios.get(`http://localhost:8080/hhipsair/source/summary?id=` + this.$route.query.sourceid, this.allProblems)
        .then(response => {
          console.log(response.data)
          this.allChapters = response.data
          for (var i = 0; i < this.allChapters.length; i++) {
            this.allProblemCount = this.allProblemCount + this.allChapters[i].chapterproblemcount
            this.passProblemCount = this.passProblemCount + this.allChapters[i].problemDoneCount
            this.wrongProblemCount = this.wrongProblemCount + this.allChapters[i].problemWrongCount
          }
          this.passProblemPercentage = Math.ceil(this.passProblemCount * 100 / this.allProblemCount)
          this.wrongProblemPercentage = Math.ceil(this.wrongProblemCount * 100 / this.allProblemCount)
        })
        .catch(e => {
          console.log(e)
        })
    },
    sendDelete (deleteData) {
      console.log('send delete ')
      console.log(deleteData)
      scrollY = window.scrollY
      axios.post(`http://localhost:8080/hhipsair/auto/delete`, deleteData)
        .then(response => {
          this.loadImage()
        })
        .catch(e => {
          console.log(e)
        })
    }
  },
  mounted: function () {
    console.log('mounted called')
    this.getSummary()
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
fit {
  width:100%;
}
.sameLine {
  display: inline-flex;
}
.fixWidth {
  width: 60px;
}
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
table{
    width:100%;
    border-collapse:collapse;
}
td {
  padding:7px; border:#4e95f4 1px solid;
}
tr:nth-child(odd){
    background: #E0ECF8;
}
tr:nth-child(even){
    background: #FCFCFD;
}
tr:hover {
    background-color: #ffff99;
}
img {
    max-width: 100%;
    max-height: 100vh;
    margin: auto;
}
</style>
