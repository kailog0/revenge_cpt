<template>
    <div>
        <div v-if="error_messages.length">
            <p v-for="(error_message, index) in error_messages" :key="index">{{ error_message }} </p>
        </div>
        <div>
            <input v-model="url">
            <button @click="confirm_url">確認</button>
        </div>
    </div>
</template>

<script>
export default {
    data: function() {
        return {
        url: "",
        error_messages: []
        }
    },
    methods: {
        confirm_url: function() {
        let url = this.url
        const self = this
        const params = {'url': this.url}
        axios
            .post('http://localhost:3000/tasks', params)
            .then(function(response) {
            console.log(response.data.message)
            })
            .catch(function(error) {
            console.log(error.response)
            console.log(error.status)
            error.response.data.messages.forEach(function(message) {
                self.error_messages.push(message)
                console.log(message)
            })
            })
            .catch(function(error) {
            console.log(error)
            })
            .finally(function(response) {
            })
        }
    }
}
</script>

