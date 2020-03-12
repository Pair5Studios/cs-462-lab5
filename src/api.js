import axios from 'axios';

export default class api {
	static query_url = "http://www.pair5.software:8080/sky/cloud/7eGkeCmgd6w8x5oWgBH7fu/"
	static event_url = "http://www.pair5.software:8080/sky/event/7eGkeCmgd6w8x5oWgBH7fu/log-vue-api/"

	static async getTemperatures(){
		try {
			let res = await axios.get(api.query_url + "temperature_store/temperatures")
			return res.data
		}catch(e){
			console.error(e)
		}
	}

	static async getViolations(){
		try {
			let res = await axios.get(api.query_url + "temperature_store/threshold_violations")
			return res.data
		}catch(e){
			console.error(e)
		}
	}


	static async getSettings(){
		try {
			let res = await axios.get(api.query_url + "sensor_profile/get_settings")
			return res.data
		}catch(e){
			console.error(e)
		}
	}

	static async saveSettings(name, location, threshold, phone){
		try {
			let res = await axios({
				method: "post",
				url: api.event_url + "sensor/profile_updated",
				data: {
					name,
					location,
					threshold,
					phone
				}
			})
			return res.data
		}catch(e){
			console.error(e)
		}
	}
}
