<template>
  <v-app>
    <v-toolbar app>
      <v-toolbar-title class="headline">
        <span>HangulClocks </span>
        <span class="font-weight-light">여러 분들의 한글시계</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn
        flat
        href="https://github.com/suapapa/site-hangulclocks/issues/new"
        target="_blank"
      >
        <span class="mr-2">등록요청</span>
      </v-btn>
    </v-toolbar>

    <v-content>
      <HangulClocks/>
    </v-content>

    <v-footer class="pa-3">
      <v-spacer></v-spacer>
      <div>
        &copy; {{ new Date().getFullYear() }}
        Homin Lee &lt;ff4500@gmail.com&gt; All rigihts reserved.
        각 시계의 사진은 각 저작자의 소유 입니다.
      </div>
    </v-footer>
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
