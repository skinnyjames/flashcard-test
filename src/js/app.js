/* eslint no-console:0 */

// Rails Unobtrusive JavaScript (UJS) is *required* for links in Lucky that use DELETE, POST and PUT.
// Though it says "Rails" it actually works with any framework.
require("@rails/ujs").start();

// Turbolinks is optional. Learn more: https://github.com/turbolinks/turbolinks/
require("turbolinks").start();

// If using Turbolinks, you can attach events to page load like this:
//
// document.addEventListener("turbolinks:load", function() {
//   ...
// })

const Vue = require('vue')
const VueRouter = require('vue-router')
import App from "./app.vue"
import Home from "./components/home.vue"
import NewDeck from "./components/new.vue"

const routes = [
  { path: "/", component: Home },
  { path: "/new", component: NewDeck }
]

const router = VueRouter.createRouter({ 
  routes,
  history: VueRouter.createWebHashHistory()
})

Vue.createApp(App).use(router).mount("#app")