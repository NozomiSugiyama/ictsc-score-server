import Vue from 'vue'

// elvis operator
// RubyのSafe Navigation Operator(&.)
// ネストされた値を安全に取得する
// 子が存在しない時点でundefinedを返す
export function elvis(parent, childrens) {
  for (const child of childrens.split('.')) {
    if (parent === null || parent === undefined) {
      return parent
    }

    parent = parent[child]
  }

  return parent
}

// Vueのコンテキストに注入する(this.$elvis, $nuxt.elvis)
export default ({ app }, inject) => inject('elvis', elvis)

// template内で使えるようにする
Vue.mixin({
  // 引数を取るため、関数を戻り地にする
  computed: { elvis: () => elvis }
})
