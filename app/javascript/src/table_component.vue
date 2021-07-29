<template>
    <table class="tasks-table">
        <tr><th class="tasks-table-th">No.</th><th class="tasks-table-th">task</th><th class="tasks-table-th"></th></tr>
        <tr v-for="(task, index) in tasks" :key="task.id" :class="'tasks-table-tr-' + (index % 2 == 0 ? 'even' : 'odd')">
        <td class="tasks-table-td tasks-table-td-index">{{ index + 1}}</td>
        <td class="tasks-table-td"><a :href="task.url">{{  task.url }}</a></a></td>
        <td class="tasks-table-td tasks-table-td-button">
            <button v-if="type == 0" class="tasks-table-button" @click="update_task(task)">AC</button>
            <button v-else-if="type == 1" class="tasks-table-button" @click="update_task(task)">戻す</button>
            <button v-else-if="type == 2" class="tasks-table-button" @click="update_task(task)">削除</button>
        </td>
        </tr>
    </table>
</template>

<script>
export default {
    props: {
        solved_status: Number,
        from_x_days_ago: Number,
        to_y_days_ago: Number,
        type: Number,
    },
    data: function() {
        return {
            tasks: [],
            base_url: '/tasks/'
        }
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
                this.base_url + `${task.id}`,
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
            from_x_days_ago: this.from_x_days_ago,
            to_y_days_ago: this.to_y_days_ago,
        }
        axios
            .get(
                this.base_url + `?solved_status=${this.solved_status}&from_x_days_ago=${this.from_x_days_ago}&to_y_days_ago=${this.to_y_days_ago}` 
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
@media screen and (min-width: 801px) {
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
        text-align: center;
    }
    .tasks-table-td {
	vertical-align: middle;
	border: 1px solid black;
        word-break: break-all;
    }
    .tasks-table-tr-odd {
    	background-color: #ddd;
    }
    .tasks-table-td-index {
        width: 40px;
    }
    .tasks-table-td-button {
	width: 60px;
    }
    .tasks-table-button {
	height: 28px;
	width: 36px;
	color: white;
	background-color: #5cb85c;
	border: 1px solid black;
    }
}

@media screen and (max-width:800px) and (min-width:561px) {
   .tasks-table {
        margin-top: 20px;
        width: 540px;
    }
    .tasks-table-th {
        text-align: center;
        vertical-align: middle;
        background-color: #5cb85c;
        border: 1px solid black;

    }
    .tasks-table > tr {
        height: 40px;
        text-align: center;
    }
    .tasks-table-td {
        vertical-align: middle;
        border: 1px solid black;
        word-break: break-all;
    }
    .tasks-table-tr-odd {
        background-color: #ddd;
    }
    .tasks-table-td-index {
        width: 40px;
    }
    .tasks-table-td-button {
        width: 60px;
    }
    .tasks-table-button {
        height: 28px;
        width: 36px;
        color: white;
        background-color: #5cb85c;
        border: 1px solid black;
    }
}

@media screen and (max-width: 560px) {
   .tasks-table {
        margin-top: 24px;
        width: 360px;
    }
    .tasks-table-th {
        text-align: center;
        vertical-align: middle;
        background-color: #5cb85c;
        border: 1px solid black;

    }
    .tasks-table > tr {
        height: 40px;
        text-align: center;
    }
    .tasks-table-td {
        vertical-align: middle;
        border: 1px solid black;
        word-break: break-all;
    }
    .tasks-table-tr-odd {
        background-color: #ddd;
    }
    .tasks-table-td-index {
        width: 40px;
    }
    .tasks-table-td-button {
        width: 60px;
    }
    .tasks-table-button {
        height: 28px;
        width: 36px;
        color: white;
        background-color: #5cb85c;
        border: 1px solid black;
    }
}
</style>
