import Vue from 'vue/dist/vue.esm'
import axios from 'axios/dist/axios.min.js'

window.app = new Vue({
  el: '#app',
  data: {
    tax: 0,
    orderItems: []
  },
  methods: {
    addOrderItem() {
      this.orderItems.push({net_price: 0, quantity: 0})
    },
    // removeOrderItem(orderItem) {
    //   this.orderItems = this.orderItems.filter((item) => item != orderItem)
    // }
    postForm() {
      axios.post('/create', {
        tax: this.tax,
        orderItems: this.orderItems
      })
      .then(function (response) {
        window.location = "/index"
      })
      .catch(function (error) {
        console.log(error);
      });
    }
  }
})
