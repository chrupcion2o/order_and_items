import Vue from 'vue/dist/vue.esm'

window.app = new Vue({
  el: '#app',
  data: {
    tax: 0,
    orderItems: []
  },
  methods: {
    addOrderItem() {
      this.orderItems.push({net_price: 0, quantity: 0})
    }
    // removeOrderItem(orderItem) {
    //   this.orderItems = this.orderItems.filter((item) => item != orderItem)
    // }
  }
})
