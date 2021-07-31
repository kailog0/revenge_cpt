<template>
    <div class="confirm-main-box">
        <div v-if="success_message">
            <p>{{ success_message }} </p>
        </div>
        <div v-if="error_messages.length">
            <p v-for="(error_message, index) in error_messages" :key="index">{{ error_message }} </p>
        </div>
        <div class="confirm-sub-box">
            <input class="confirm-input" v-model="url">
            <button class="confirm-button" :disabled="is_button_inactive" @click="confirm_url">登録</button>
        </div>
    </div>
</template>

<script>
export default {
    data: function() {
        return {
            url: "",
            error_messages: [],
            success_message:  '',
            base_url:'/tasks',
            is_button_inactive: false
        }
    },
    methods: {
        confirm_url: function() {
        let url = this.url
        const self = this
        const params = {'url': this.url}
        this.reset_message()
        this.is_button_inactive = true
        axios
            .post(this.base_url, params)
            .then(function(response) {
                self.success_message = response.data.message
                self.url = ''
                setTimeout(function() {self.success_message = ''}, 1500)
            })
            .catch(function(error) {
                error.response.data.messages.forEach(function(message) {
                    self.error_messages.push(message)
                })
            })
            .finally(function() {
                setTimeout(function() {self.is_button_inactive = false}, 1500)
            })
        },
        reset_message: function() {
            this.success_message = ''
            this. error_messages = []
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
    .confirm-button:disabled {
        background-color: rgb(100, 100, 100);
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
