<template>
  <div id="kkk" class="fit">
    <h1 class="bottomArea">{{ msg }}
      <button v-on:click="doAutoMerge()">智能合并</button>
      <button v-on:click="mergePicked()">合并选中</button>
      <button v-on:click="deletePicked()">删除选中</button>
      <button v-on:click="keepPicked()">保留选中</button>
      <button class="right" v-on:click="submit()">Submit</button>
      <div class="right">&nbsp;&nbsp;</div>
      <button class="right" v-on:click="update()">Update</button>
      <div class="right">&nbsp;&nbsp;</div>
      <div class="right">{{chapter}}</div>
    </h1>
    <div id="app">
      <input type="checkbox" v-model="answerFlag" name="checkbox" />
      <input type="file" multiple="multiple" :name="uploadFieldName" @change="filesChange($event.target.files); "
              accept="any/*" class="input-file">
      <router-view/>
    </div>
    <div class="sameLine">
      <div v-for="index in allIndex" v-bind:value="index" v-bind:key="index">
        <button v-on:click="startFrom(index, 1)">{{index}}</button>
      </div>
    </div>
    <div>--------------------------------------------------------------</div>
    <div class="sameLine">
      <div v-for="index in allIndexB" v-bind:value="index" v-bind:key="index">
        <button v-on:click="startFrom(index, 2)">{{index}}</button>
        <button v-on:click="removeIndex(index, 2)">X</button>
      </div>
    </div>
    <div>--------------------------------------------------------------</div>
    <div class="sameLine">
      <div v-for="index in allIndexC" v-bind:value="index" v-bind:key="index">
        <button v-on:click="startFrom(index, 3)">{{index}}</button>
      </div>
    </div>
    <div>--------------------------------------------------------------</div>
    <div class="sameLine">
      <div v-for="index in allIndexD" v-bind:value="index" v-bind:key="index">
        <button v-on:click="startFrom(index, 4)">{{index}}</button>
      </div>
    </div>
    <div>--------------------------------------------------------------</div>
    <div class="sameLine">
      <div v-for="index in allIndexE" v-bind:value="index" v-bind:key="index">
        <button v-on:click="startFrom(index, 5)">{{index}}</button>
      </div>
    </div>
    <div>--------------------------------------------------------------</div>
    <div class="sameLine">
      <div v-for="index in allIndexF" v-bind:value="index" v-bind:key="index">
        <button v-on:click="startFrom(index, 6)">{{index}}</button>
      </div>
    </div>
    <table>
      <tr>
        <td>
          <button v-on:click="submit()">Submit</button>
        </td>
        <td>
          <button v-on:click="update()">Update</button>
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
          <button v-on:click="levelUp(index)">level↑{{item.level}}</button>
        </td>
        <td class="fixWidth">
          <input type="checkbox" v-model="item.picked" name="checkbox" />
        </td>
        <td>
          <button v-on:click="deleteUp(index)">↑Del</button>
        </td>
        <td>
          <button v-on:click="deleteBelow(index)">↓Del</button>
        </td>
        <td @mousedown="mouseDown(index)" @mouseup="mouseUp(index)" @mouseover="mouseOver(index)">
          <img v-bind:src="item.img"/>
        </td>
      </tr>
    </table>
    <div>--------------------------------------------------------------</div>
    <div>--------------------------------------------------------------</div>
  </div>
</template>

<script>
import axios from 'axios'
var scrollY = 0
var loadedFiles
var totalFileCount
var fileLoaded
var url

export default {
  name: 'CutMain',
  data () {
    return {
      headers: {'access-token': '<your-token>'},
      filesUploaded: [],
      uploadFieldName: '',
      answerFlag: false,
      msg: 'Found Problem',
      inSelectMode: false,
      startSelect: null,
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
      allIndex: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'],
      allIndexB: ['L1', 'L1L', 'L2', 'L2L', 'L3', 'L3L', 'L4', 'L4L', 'L5', 'L5L', 'L6', 'L6L', 'L7', 'L7L', 'L8', 'L8L',
        'Z01', 'Z02', 'Z03', 'Z04', 'Z05', 'Z06', 'Z07', 'Z08', 'Z09', 'Z10'],
      allIndexC: ['X01', 'X02', 'X03', 'X04', 'X05', 'X06', 'X07', 'X08', 'X09', 'X10', 'X11', 'X12', 'X13', 'X14', 'X15', 'X16', 'X17'],
      allIndexD: ['T01', 'T02', 'T03', 'T04', 'T05', 'T06', 'T07', 'T08', 'T09', 'T10', 'T11', 'T12', 'T13', 'T14', 'T15', 'T16', 'T17'],
      allIndexE: ['C01', 'C02', 'C03', 'C04', 'C05', 'C06', 'C07', 'C08', 'C09', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17'],
      allIndexF: ['J01', 'J02', 'J03', 'J04', 'J05', 'J06', 'J07', 'J08', 'J09', 'J10']
    }
  },
  watch: {
    answerFlag: function (val) {
      localStorage.answerFlag = this.answerFlag
    },
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
    filesChange: function (fieldName) {
      console.log(fieldName)
      var myType = fieldName[0].type
      console.log(typeof (myType))
      if (myType.includes('pdf') === true) {
        this.processPdf(fieldName)
      } else {
        this.processPng(fieldName)
      }
    },
    loadOneFile: function (fileName, fileIndex) {
      var reader = new FileReader()
      reader.onload = function (readerEvt) {
        console.log(fileName.name + 'loaded' + fileIndex)
        loadedFiles[fileIndex] = readerEvt.target.result
        fileLoaded = fileLoaded + 1
        if (fileLoaded === totalFileCount) {
          console.log(loadedFiles)
          axios.post(url, loadedFiles)
            .then(response => {
              console.log(response)
              alert('done!')
            })
            .catch(e => {
              console.log(e)
            })
        }
      }
      reader.readAsDataURL(fileName)
    },
    processPng: function (fieldName) {
      totalFileCount = fieldName.length
      loadedFiles = []
      fileLoaded = 0
      console.log('process as png')
      console.log(fieldName.length)
      console.log(loadedFiles.length)
      for (var i = 0; i < fieldName.length; ++i) {
        this.loadOneFile(fieldName[i], i)
      }
    },
    processPdf: function (fieldName) {
      console.log('process as pdf')
      var reader = new FileReader()
      reader.onload = function (readerEvt) {
        alert(readerEvt.target.result)
        axios.post(`http://localhost:8080/hhipsair/auto/pdf`, reader.result)
          .then(response => {
            console.log(response)
            alert(response.data)
          })
          .catch(e => {
            console.log(e)
          })
      }
      reader.readAsDataURL(fieldName[0])
    },
    mouseDown (index) {
      console.log(index + 'mouse down')
      this.inSelectMode = true
      this.allProblems[index].picked = true
      console.log(this.allProblems)
    },
    mouseUp (index) {
      this.inSelectMode = false
    },
    mouseOver (index) {
      if (this.inSelectMode === false) {
        return
      }
      this.allProblems[index].picked = true
    },
    doAutoMerge () {
      console.log('auto merge')
      axios.post(`http://localhost:8080/hhipsair/auto/automerge`, null)
        .then(response => {
          console.log(response.data)
        })
        .catch(e => {
          console.log(e)
        })
    },
    submit () {
      localStorage.chapter = this.chapter
      localStorage.pickedModule = this.pickedModule
      localStorage.pickedLevel = this.pickedLevel
      console.log(this.allProblems)
      axios.post(`http://localhost:8080/hhipsair/auto/create`, this.allProblems)
        .then(response => {
          alert('done')
          console.log(response.data)
        })
        .catch(e => {
          console.log(e)
        })
    },
    update () {
      localStorage.chapter = this.chapter
      console.log(this.allProblems)
      axios.post(`http://localhost:8080/hhipsair/auto/update`, this.allProblems)
        .then(response => {
          alert('done')
          console.log(response.data)
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
          for (var i = 0; i < deleteData.length; ++i) {
            for (var j = 0; j < this.allProblems.length; j++) {
              if (this.allProblems[j].img === deleteData[i]) {
                this.allProblems.splice(j, 1)
                break
              }
            }
          }
        })
        .catch(e => {
          console.log(e)
        })
    },
    mergePicked () {
      scrollY = window.scrollY
      var data = []
      for (var i = 0; i < this.allProblems.length; i++) {
        if (this.allProblems[i].picked === true) {
          data.push(this.allProblems[i].img)
        }
      }
      if (data.length < 2) {
        return
      }
      axios.post(`http://localhost:8080/hhipsair/auto/merge`, data)
        .then(response => {
          console.log(response.data)
          this.loadImage()
        })
        .catch(e => {
          console.log(e)
        })
    },
    keepPicked () {
      var deleteData = []
      for (var i = 0; i < this.allProblems.length; i++) {
        if (this.allProblems[i].picked === false) {
          deleteData.push(this.allProblems[i].img)
        }
      }
      this.sendDelete(deleteData)
    },
    deletePicked () {
      var deleteData = []
      for (var i = 0; i < this.allProblems.length; i++) {
        if (this.allProblems[i].picked === true) {
          deleteData.push(this.allProblems[i].img)
        }
      }
      this.sendDelete(deleteData)
    },
    deleteUp (index) {
      var tmp = this.allProblems
      var deleteData = []
      for (var i = 0; i < tmp.length; i++) {
        if (i < index) {
          deleteData.push(tmp[i].img)
          continue
        } else {
          break
        }
      }
      this.sendDelete(deleteData)
    },
    deleteBelow (index) {
      var tmp = this.allProblems
      this.allProblems = []
      var newIndex = 0
      var deleteData = []
      for (var i = 0; i < tmp.length; i++) {
        if (i < index) {
          tmp[i].index = this.allIndex[newIndex]
          newIndex++
          this.allProblems.push(tmp[i])
        } else {
          deleteData.push(tmp[i].img)
        }
      }
      this.sendDelete(deleteData)
    },
    levelUp (index) {
      for (var i = 0; i < this.allProblems.length; i++) {
        if (i < index) {
          continue
        } else {
          this.allProblems[i].level = parseInt(this.allProblems[i].level) + 1
        }
      }
    },
    startFrom (index, from) {
      if (from === 1) {
        this.doStartFrom(index, this.allIndex)
      } else if (from === 2) {
        this.doStartFrom(index, this.allIndexB)
      } else if (from === 3) {
        this.doStartFrom(index, this.allIndexC)
      } else if (from === 4) {
        this.doStartFrom(index, this.allIndexD)
      } else if (from === 5) {
        this.doStartFrom(index, this.allIndexE)
      } else if (from === 6) {
        this.doStartFrom(index, this.allIndexF)
      }
    },
    doStartFrom (index, data) {
      var j = 0
      for (j = 0; j < data.length; ++j) {
        if (data[j] === index) {
          break
        }
      }
      for (var i = 0; i < this.allProblems.length; i++) {
        this.allProblems[i].index = data[j + i]
      }
    },
    removeIndex (index, from) {
      if (from === 1) {
        this.allIndex = this.doRemoveIndex(index, this.allIndex)
      } else {
        this.allIndexB = this.doRemoveIndex(index, this.allIndexB)
      }
    },
    doRemoveIndex (index, data) {
      var j = 0
      var newIndex = []
      for (j = 0; j < data.length; ++j) {
        if (data[j] === index) {
          continue
        } else {
          newIndex.push(data[j])
        }
      }
      return newIndex
    },
    loadImage () {
      console.log('~~~~~~~~~~~~~~~~~~~~~~~~~')
      this.allProblems = []
      axios.get(`http://localhost:8080/hhipsair/auto/list`)
        .then(response => {
          for (var i = 0; i < response.data.length; i++) {
            var cur = {}
            cur.img = response.data[i]
            if (this.allIndex[i] != null) {
              cur.index = this.allIndex[i]
            }
            cur.level = this.pickedLevel
            cur.picked = false
            cur.module = this.pickedModule
            this.allProblems.push(cur)
          }
          console.log('set scroll to ' + scrollY)
          window.scrollTo(0, scrollY)
        })
        .catch(e => {
          console.log(e)
        })
    },
    loadUrlCheckValue () {
      console.log('loadUrlCheckValue')
      if (localStorage.answerFlag !== undefined) {
        if (localStorage.answerFlag === 'true') {
          console.log('localStorage.answerFlag is true...')
          this.answerFlag = true
        } else {
          console.log('localStorage.answerFlag is NOT true...')
          this.answerFlag = false
        }
        console.log('localStorage.answerFlag')
        console.log(localStorage.answerFlag)
        if (this.answerFlag) {
          url = 'http://localhost:8080/hhipsair/auto/png'
        } else {
          url = 'http://localhost:8080/hhipsair/auto/png2pages'
        }
      }
    }
  },
  beforeMount: function () {
    this.loadImage()
    this.loadUrlCheckValue()
  },
  updated: function () {
    console.log('reset position')
    window.scrollTo(this.scrollY)
    for (var i = 0; i < this.allProblems.length; i++) {
      this.allProblems[i].chapter = this.chapter
    }
  },
  mounted: function () {
    console.log('mounted called')
    console.log(scrollY)
    if (localStorage.chapter !== undefined) {
      this.chapter = localStorage.chapter
    }
    if (localStorage.pickedLevel !== undefined) {
      this.pickedLevel = localStorage.pickedLevel
      for (var j = 0; j < this.allProblems.length; j++) {
        this.allProblems[j].level = this.pickedLevel
      }
    }
    if (localStorage.pickedModule !== undefined) {
      this.pickedModule = localStorage.pickedModule
      for (var k = 0; k < this.allProblems.length; k++) {
        this.allProblems[k].module = this.pickedModule
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
fit {
  width:100%;
}
.bottomArea {
  position: fixed;
  bottom: -20px;
  left: 0px;
  width: 100%;
  color: #CCC;
  background: #333;
  padding: 0px;
}
.sameLine {
  display: inline-flex;
}
.fixWidth {
  width: 60px;
}
.right {
  float: right;
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
