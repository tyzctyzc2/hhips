<template>
  <div id="kkk" class="fit">
    <h1>{{ msg }}</h1>
    <table>
      <tr>
        <td>
          <button v-on:click="submit()">Submit</button>
        </td>
        <td>
          <input type="text" v-model="chapter">
        </td>
        <td>
          <select v-model="pickedModule">
            <Option v-for="item in problemModule" v-bind:value="item.id" v-bind:key="item.id">
              {{ item.name }}
            </Option>
          </select>
          <span>Selected: {{ pickedModule }}</span>
        </td>
        <td>
          <select v-model="pickedLevel">
            <Option v-for="item in problemLevel" v-bind:value="item.id" v-bind:key="item.id">
              {{ item.name }}
            </Option>
          </select>
          <span>Selected: {{ pickedLevel }}</span>
        </td>
      </tr>
    </table>
    <table>
      <tr v-for="(item, index) in allProblems" :key="index">
        <td>
          <div>{{item.index}}</div>
        </td>
        <td>
          <select v-model="item.module">
            <Option v-for="item in problemModule" v-bind:value="item.id" v-bind:key="item.id">
              {{ item.name }}
            </Option>
          </select>
        </td>
        <td>
          <select v-model="item.level">
            <Option v-for="item in problemLevel" v-bind:value="item.id" v-bind:key="item.id">
              {{ item.name }}
            </Option>
          </select>
        </td>
        <td>
          <button v-on:click="removeImg(index)">Remove pic</button>
        </td>
        <td>
          <button v-on:click="mergeUp(index)">Merge up</button>
        </td>
        <td>
          <img v-bind:src="item.img"/>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'PartList',
  data () {
    return {
      msg: 'Found Problem',
      allProblems: [],
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
  methods: {
    submit () {
      console.log(this.allProblems)
      axios.post(`http://localhost:8080/hhipsair/auto/create`, this.allProblems)
        .then(response => {
          console.log(response.data)
        })
        .catch(e => {
          console.log(e)
        })
    },
    removeImg (index) {
      console.log('remove ' + index)
      console.log(this.allProblems)
      var tmp = this.allProblems
      this.allProblems = []
      var newIndex = 0
      for (var i = 0; i < tmp.length; i++) {
        if (i !== index) {
          tmp[i].index = this.allIndex[newIndex]
          newIndex++
          this.allProblems.push(tmp[i])
        }
      }
    },
    removeIndex (index) {
      console.log('remove ' + index)
    },
    mergeUp (index) {
      console.log('mergeUp ' + index)
      if (index === 0) {
        console.log('cannot merge the first pic')
        return
      }
      var data = []
      data.push(this.allProblems[index].img)
      data.push(this.allProblems[index - 1].img)
      axios.post(`http://localhost:8080/hhipsair/auto/merge`, data)
        .then(response => {
          console.log(response.data)
        })
        .catch(e => {
          console.log(e)
        })
    }
  },
  beforeMount: function () {
    console.log('~~~~~~~~~~~~~~~~~~~~~~~~~')
    axios.get(`http://localhost:8080/hhipsair/auto/list`)
      .then(response => {
        console.log(response.data)
        for (var i = 0; i < response.data.length; i++) {
          var cur = {}
          cur.img = response.data[i]
          if (this.allIndex[i] != null) {
            cur.index = this.allIndex[i]
          }
          cur.level = this.pickedLevel
          cur.module = this.pickedModule
          this.allProblems.push(cur)
        }
      })
      .catch(e => {
        console.log(e)
      })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
fit {
  width:100%;
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
