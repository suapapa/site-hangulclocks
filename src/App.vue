<template>
  <v-app>
    <v-toolbar app>
      <v-toolbar-title class="headline">
        <span>HangulClocks</span>
        <span class="font-weight-light">여러 분들의 한글시계들</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <!--
      <v-btn
        flat
        href="https://github.com/vuetifyjs/vuetify/releases/latest"
        target="_blank"
      >
        <span class="mr-2">Latest Release</span>
      </v-btn>
      -->
    </v-toolbar>

    <v-content>
      <HangulClocks/>
    </v-content>
  </v-app>
</template>

<script>
import HangulClocks from './components/HangulClocks'

export default {
  name: 'App',
  components: {
    HangulClocks
  },
  data () {
    return {
      //
    }
  }
}
</script>
