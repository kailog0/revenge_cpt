import Vue from 'vue/dist/vue.esm'
import TableComponent from '../src/table_component.vue'
import ConfirmUrlComponent from '../src/confirm_url.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    data: {
        show_component: [true, false, false, false, false, false]
    },
    methods: {
	    switchComponent: function(index) {
		if(this.show_component[index]) return
		for(let i = 0; i < this.show_component.length; i++) {
			if(i == index) Vue.set(this.show_component, i, true)
			else Vue.set(this.show_component, i, false)
		}
	    }
    },
    components: { 
        TableComponent,
	ConfirmUrlComponent,    
    }
  })
})

