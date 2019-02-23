<template>
  <div id="app">
    <input type="file" multiple="multiple" :name="uploadFieldName" @change="filesChange($event.target.files); "
            accept="any/*" class="input-file">
    <router-view/>
  </div>
</template>

<script>
import axios from 'axios'
var loadedFiles
var totalFileCount

export default {
  name: 'App',
  data () {
    return {
      url: 'http://localhost:8080/hhipsair/auto/pdf',
      headers: {'access-token': '<your-token>'},
      filesUploaded: [],
      uploadFieldName: ''
    }
  },
  problems: [],
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
        console.log(fileName.name)
        loadedFiles[fileIndex] = readerEvt.target.result
        if (fileIndex === totalFileCount) {
          console.log(readerEvt.target.result)
          alert(readerEvt.target.result)
          axios.post(`http://localhost:808/auto/png`, loadedFiles)
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
      totalFileCount = fieldName.length - 1
      loadedFiles = []
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
        axios.post(`http://localhost:808/auto/pdf`, reader.result)
          .then(response => {
            console.log(response)
            alert('done!')
          })
          .catch(e => {
            console.log(e)
          })
      }
      reader.readAsDataURL(fieldName[0])
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
