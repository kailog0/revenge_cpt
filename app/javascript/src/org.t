<template>
    <table class="tasks-table">
        <tr><th class="tasks-table-th">No.</th><th class="tasks-table-th">task</th><th class="tasks-table-th"></th></tr>
        <tr v-for="(task, index) in tasks" :key="task.id">
        <td class="tasks-table-td" :class="'tasks-table-td-' + (index % 2 ? 'even' : 'odd')">{{ index + 1}}</td>
        <td class="tasks-table-td" :class="'tasks-table-td-' + (index % 2 ? 'even' : 'odd')"><a :href="task.url">{{  task.url }}</a></a></td>
        <td :class="'tasks-table-td-' + (index % 2 ? 'even' : 'odd')"><button class="tasks-table-button" @click="update_task(task)">AC</button></td>
        </tr>
    </table>
</template>

<script>
export default {
    props: {
        solved_status: Number,
        x_days_ago: Number,
    },
    data: function() {
        return {tasks: []}
    },
    methods: {
        update_task: function(task) {
        const self = this
        const params = {
            'id': task.id,
            'status': task.status + 1,
        }
        axios
            .put(
                `http://localhost:3000/tasks/${task.id}`,
                params
            )
            .then(function(response) {
            console.log(response.data.message)
            self.tasks = self.tasks.filter(target => target.id != task.id)
            })
            .catch(function(error) {
            console.log('更新失敗')
            console.log(error.response)
            })
            .finally(function() {
            console.log('put-finally')
            })
        },
        get_tasks: function() {
        const self = this
        const params = {
            solved_status: this.solved_status,
            x_days_ago: this.x_days_ago,
        }
        axios
            .get(
            `http://localhost:3000/tasks?solved_status=${this.solved_status}&x_days_ago=${this.x_days_ago}`,
            params
            )
            .then(function(response) {
            self.tasks = response.data
            })
        },
    },
    mounted: function() {
        this.get_tasks()
    },
}
</script>

<style scoped>
   .tasks-table {
	margin-top: 20px;
	width: 800px;	
    }
    .tasks-table-th {
	text-align: center;
	vertical-align: middle;
	background-color: #5cb85c; 
	border: 1px solid black;

    }
    .tasks-table > tr {
	height: 40px;
    }
    .tasks-table-tr-odd {
        color: blue;
    }
    .tasks-table-td {
	text-align: center;
	color: red;
	vertical-align: middle;
	border: 1px solid black;
    }
    .tasks-table-td-odd {
    	background-color: black;
    }
    .tasks-table-button {
	height: 28px;
	width: 36px;
	color: white;
	background-color: #5cb85c;
	border: 1px solid black;
	margin-top: 6px;
    }
</style>
