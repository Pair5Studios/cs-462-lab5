<template>
  <div id="app">

    <div id="settings" @click="settingsMode = !settingsMode" class="icon-cog" />

    <section v-if="!settingsMode">
      <p id="CurrentTitle">Current Temperature:</p>
      <p id="CurrentTemp" v-if="temperatures.length > 0">{{temperatures[0].temperature}}&#176;F</p>
      <div id="divider" />

      <p id="RecentTitle">Recent Temperatures:</p>

      <div id="TemperatureTable">
        <div class="TemperatureRow"
             v-for="temp in temperatures"
             :key="temp.timestamp.valueOf()"
             :class="{'violation':temp.isViolation === true}">

          <span class="RecentTime">{{temp.timestamp}}:&nbsp;&nbsp;</span>
          <span class="RecentTemp"> {{temp.temperature}}&#176;F</span>
        </div>
      </div>
    </section>
    <section v-else>
      <settings />
    </section>

  </div>
</template>

<script>
import api from '@/api.js'

import settings from '@/components/settings'

export default {
  name: 'App',
  components: {
    settings,
  },

  data(){
    return {
      temperatures: [],
      settingsMode: false,
    }
  },

  mounted(){
    this.repeater(this)
  },

  methods: {
    async getTemps(){
      let temps = await api.getTemperatures()
      let violations = await api.getViolations()
      if(violations === null) violations = []
      this.temperatures = []
      // console.log("temperatures:", temps)
      // console.log("Violations:", violations)

      for(let item in temps){
        let current = temps[item]
        current.timestamp = new Date(current.timestamp)
        // console.log(item)
        // console.log(violations[item+""])
        if(violations[item+""] !== undefined) {
          current.isViolation = true
        }else current.isViolation = false
        this.temperatures.unshift(current)
      }
    },


    repeater(context){
      context.getTemps()
      setTimeout(context.repeater, 1000, context)
    }
  }
}
</script>

<style src="@/assets/icomoon/style.css" />

<style>
body {
  background-color: #eee;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}


#settings {
  content: "settings";
  position: absolute;
  left: 1em;
  top: 1em;
}


#CurrentTitle { font-size: 2em; }
#CurrentTemp {
  font-size: 8em;
  margin: 0;
  padding-bottom: 0;
}
#divider { margin: 4em; border-top: 2px darkgray solid; }


#RecentTitle { font-size: 2em; }
#TemperatureTable {
  display: flex;
  flex-direction: column;
  margin: 0 10vw;
}
  .TemperatureRow {
    padding: 0.25em 0;
  }
  .RecentTime {
    color: #555;
  }
  .RecentTemp {
    font-weight: bold;
  }
  .violation {
    background-color: pink;
  }
  .violation::after{
    content: " [VIOLATION]";
    color: red;
    text-align: right;
  }
</style>
