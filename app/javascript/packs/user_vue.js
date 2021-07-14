import Vue from 'vue/dist/vue.esm'
import TableComponent from '../src/table_component.vue'
import ConfirmUrlComponent from '../src/confirm_url.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    components: { 
        TableComponent,
	ConfirmUrlComponent,    
    }
  })
})

