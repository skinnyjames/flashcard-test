<template>
  <h3>Available Decks</h3>
  <div class="deck" v-for="deck in decks" :key="deck.id">
    <h5>{{ deck.title }}</h5>
    <div class="deck-actions">
      <button>Start</button>
      <button>Edit</button>
      <button>Delete</button>
    </div>
  </div>
  <div v-if="decks.length === 0">You have no decks made, why don't you <router-link to="/new">make one?</router-link></div>
</template>

<script>
import { onMounted, ref } from "vue"

let decks = ref([])

export default {
  setup() {
    onMounted(async() => {
      const res = await fetch("/decks")
      decks = await res.json()

    })
    return {
      decks
    }
  }

}
</script>