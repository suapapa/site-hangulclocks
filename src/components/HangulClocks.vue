<template>
  <v-container>
    <v-layout text-xs-center wrap >

      <v-flex xs12 mb-5 v-for="(clk, i) in hangulclocks" :key="i">
        <v-card>
          <v-img
            :src="`${clk.image}`"
            aspect-ratio="2.75"
          ></v-img>

          <v-card-title primary-title>
            <div>
              <h3 class="headline mb-0">{{ clk.title }}</h3>
              <div>{{ clk.author }}</div>
            </div>
          </v-card-title>

          <v-card-actions>
            <v-btn flat color="orange">Site</v-btn>
          </v-card-actions>
        </v-card>
      </v-flex>

    </v-layout>
  </v-container>
</template>

<script>
  export default {
    data: () => ({
      ecosystem: [
        {
          text: 'vuetify-loader',
          href: 'https://github.com/vuetifyjs/vuetify-loader'
        },
        {
          text: 'github',
          href: 'https://github.com/vuetifyjs/vuetify'
        },
        {
          text: 'awesome-vuetify',
          href: 'https://github.com/vuetifyjs/awesome-vuetify'
        }
      ],
      hangulclocks: [
        {
          title: '너가 있어 아름다운 오늘, 한글시계',
          author: "이상훈",
          image: require('../assets/hangulclock_sanghunlee.png'),
          href: 'https://hangulclock.today/'
        },
        {
          title: '한글시계(HangulClock)',
          author: "이호민",
          image: require('../assets/hangulclock_hominlee.jpg'),
          href: 'https://github.com/suapapa/hangulclock'
        },
    ]
    })
  }
</script>

<style>

</style>
