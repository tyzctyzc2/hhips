import Vue from 'vue'
import Router from 'vue-router'
import CutMain from '@/components/CutMain'
import PartList from '@/components/PartList'
import SourceSummary from '@/components/SourceSummary'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'CutMain',
      component: CutMain
    },
    {
      path: '/list',
      name: 'PartList',
      component: PartList
    },
    {
      path: '/sum',
      name: 'sum',
      component: SourceSummary
    }
  ]
})
