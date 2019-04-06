<template>
  <div id="app">
    <input type="checkbox" v-model="answerFlag" name="checkbox" />
    <input type="file" multiple="multiple" :name="uploadFieldName" @change="filesChange($event.target.files); "
            accept="any/*" class="input-file">
    <router-view/>
  </div>
</template>

<script>
import axios from 'axios'
var loadedFiles
var totalFileCount
var fileLoaded
var url

export default {
  name: 'App',
  data () {
    return {
      headers: {'access-token': '<your-token>'},
      filesUploaded: [],
      uploadFieldName: '',
      answerFlag: false
    }
  },
  problems: [],
  watch: {
    answerFlag: function (val) {
      localStorage.answerFlag = val
      console.log(val)
      if (val === false) {
        url = 'http://localhost:8080/hhipsair/auto/png'
      } else {
        url = 'http://localhost:8080/hhipsair/auto/png2pages'
      }
      console.log(url)
    }
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
    }
  },
  mounted: function () {
    if (localStorage.answerFlag !== undefined) {
      this.answerFlag = localStorage.answerFlag
      if (this.answerFlag) {
        url = 'http://localhost:8080/hhipsair/auto/png'
      } else {
        url = 'http://localhost:8080/hhipsair/auto/png2pages'
      }
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
