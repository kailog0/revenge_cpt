<template>
    <table>
        <tr><th>No.</th><th>task</th><th></th></tr>
        <tr v-for="(task, index) in tasks" :key="task.id">
        <td>{{ index + 1}}</td>
        <td><a :href="task.url">{{  task.url }}</a></a></td>
        <td><button @click="update_task(task)">AC</button></td>
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
