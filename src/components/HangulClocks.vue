<template>
  <v-container>
    <v-layout text-xs-center wrap >

      <v-flex
        xs12 sm12 md6 lg6 xl4
        pa-2
        v-for="(clk, i) in hangulclocks" :key="i">
        <v-card>
          <v-img
            :src="`${clk.image}`"
            aspect-ratio="2.75"
          ></v-img>

          <v-card-title primary-title>
            <div>
              <h3 class="headline mb-0"><b>{{ clk.title }}</b> - {{ clk.author }}</h3>
              <!-- <pre>{{ clk.author }}</pre> -->
            </div>
          </v-card-title>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" fab small dark :href="`${clk.href}`" target="_blank">
              <v-icon>home</v-icon>
            </v-btn>

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
          title: '한글시계 design based on attiny4313a.',
          author: "cakeng",
          image: require('../assets/hangulclock_cakeng.jpg'),
          href: 'https://github.com/cakeng/HangulClock'
        },
        {
          title: '너가 있어 아름다운 오늘, 한글시계',
          author: "이상훈",
          image: require('../assets/hangulclock_sanghunlee.png'),
          href: 'https://hangulclock.today/'
        },
        {
          title: '한글시계 for Android',
          author: '이준희',
          image: require('../assets/hangulclock_junheelee.png'),
          href: 'https://play.google.com/store/apps/details?id=com.leejoonhee.hangulclockforandroid'
        },
        {
          title: '세운(시) 여러분(계)',
          author: 'Space_바421',
          image: require('../assets/hangulclock_sewoon.webp'),
          href: 'http://yovisong.wixsite.com/spaceba4/2016-11-homo-laborans'
        },
        {
          title: '한글시계 - 한글로 흐르는 시간의 아름다움',
          author: '대디스랩x이카루스',
          image: require('../assets/hangulclock_dlab.jpg'),
          href: 'https://www.wadiz.kr/web/campaign/detail/1240'
        },
        {
          title: '한글시계 만들기',
          author: "만들마루",
          image: require('../assets/hangulclock_mandulmaru.jpeg'),
          href: 'https://blog.naver.com/mandulmaru/221413981408'
        },
        {
          title: '한글 시계 만들기',
          author: "kocoafab",
          image: require('../assets/hangulclock_kocoafab.jpg'),
          href: 'https://kocoafab.cc/make/view/508'
        },
        {
          title: '한글시계(HangulClock)',
          author: "이호민",
          image: require('../assets/hangulclock_hominlee.jpg'),
          href: 'https://github.com/suapapa/hangulclock'
        }
    ]
    })
  }
</script>

<style>

</style>
