<template>
<section>
	<p id="CurrentTitle">Temperature Profile:</p>
	<p>Sensor Name</p>
	<input v-model="name" placeholder="Sensor Name" />
	<br /><br />

	<p>Sensor Location</p>
	<input v-model="location" placeholder="Sensor Location" />
	<br /><br />

	<p>High-Temperature Threshold</p>
	<input v-model="threshold" placeholder="High-Temperature Threshold" />
	<br /><br />

	<p>Notify Phone Number (SMS)</p>
	<input v-model="phone" placeholder="Notify Phone Number" />
	<br /><br />

	<button @click="save">Save Settings</button>

</section>
</template>

<script>
import api from '@/api.js'

export default {
	name: "settings",

	data(){
		return {
			name: "",
			location: "",
			threshold: "",
			phone: "",
		}
	},

	async mounted(){
		let obj = await api.getSettings()
		this.name = obj.name
		this.location = obj.location
		this.threshold = obj.threshold
		this.phone = obj.phone
	},

	methods: {
		save() {
			let obj = {
				"name": this.name,
				"location": this.location,
				"threshold": this.threshold,
				"phone": this.phone
			}
			api.saveSettings(this.name, this.location, this.threshold, this.phone)
		}
	}
}
</script>
