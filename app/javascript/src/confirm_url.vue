<template>
    <div class="confirm-main-box">
        <div v-if="error_messages.length">
            <p v-for="(error_message, index) in error_messages" :key="index">{{ error_message }} </p>
        </div>
        <div class="confirm-sub-box">
            <input class="confirm-input" v-model="url">
            <button class="confirm-button" @click="confirm_url">確認</button>
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

<style scoped>
@media screen and (min-width: 801px) {
    .confirm-main-box {
        margin-top: 16px;
    }
    .confirm-sub-box {
	width: 760px;
	height: 40px;
        display: flex;
	justify-content: space-around;
        align-items: center;
    }
    .confirm-input {
	height: 32px;
	width: 640px;
        border: 1px solid black;
    }
    .confirm-button {
	font-size: 20px;
	height: 32px;
	width: 56px;
        margin-left: 4px;
	color: black;
	background-color: rgb(200, 200, 200);
	text-align: center;
        border: 1px solid black;
	border-bottom-left-radius: 5%;
	border-bottom-right-radius: 5%;
	border-top-left-radius: 5%;
	border-top-right-radius: 5%;
    }
}

@media screen and (max-width: 800px) and (min-width: 561px) {
    .confirm-main-box {
        margin-top: 16px;
    }
    .confirm-sub-box {
        width: 540px;
        height: 40px;
        display: flex;
        justify-content: space-around;
        align-items: center;
    }
    .confirm-input {
        height: 32px;
        width: 640px;
        border: 1px solid black;
    }
    .confirm-button {
        font-size: 20px;
        height: 32px;
        width: 56px;
        margin-left: 4px;
        color: black;
        background-color: rgb(200, 200, 200);
        text-align: center;
        border: 1px solid black;
        border-bottom-left-radius: 5%;
        border-bottom-right-radius: 5%;
        border-top-left-radius: 5%;
        border-top-right-radius: 5%;
    }
}

@media screen and (max-width: 560px) {
    .confirm-main-box {
        margin-top: 16px;
    }
    .confirm-sub-box {
        width: 360px;
        height: 32px;
        display: flex;
        justify-content: space-around;
        align-items: center;
        flex-direction: column;
    }
    .confirm-input {
        height: 32px;
        width: 360px;
        border: 1px solid black;
    }
    .confirm-button {
        font-size: 20px;
        height: 32px;
        width: 100%;
        margin-top: 4px;
        color: black;
        background-color: rgb(200, 200, 200);
        text-align: center;
        border: 1px solid black;
        border-bottom-left-radius: 5%;
        border-bottom-right-radius: 5%;
        border-top-left-radius: 5%;
        border-top-right-radius: 5%;
    }
}
</style>
