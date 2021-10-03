<template>
  <h3>Available Decks</h3>
  <router-link to="/new">New Deck</router-link>
  <div class="deck" v-for="deck in decks" :key="deck.id">
    <h5>{{ deck.title }}</h5>
    <div class="deck-actions">
      <router-link :to="`/play/${deck.id}`">Start</router-link>
      <router-link :to="`/edit/${deck.id}`">Edit</router-link>
      <button @click="deleteDeck(deck.id)">Delete</button>
    </div>
  </div>
  <div v-if="decks.length === 0">You have no decks made, why don't you <router-link to="/new">make one?</router-link></div>
</template>

<script>
import { onMounted, ref } from "vue"
let decks = ref([])

const deleteDeck = async(id) => {
  await fetch(`/decks/${id}`, { method: "DELETE" })
  decks.value = decks.value.filter(deck => deck.id !== id)
}

export default {
  setup() {

    onMounted(async() => {
      const res = await fetch("/decks")
      decks.value = await res.json()
    })
    return {
      decks,
      deleteDeck
    }
  }

}
</script>
<style scoped>
.deck-actions a, .deck-actions button {
  margin: 0px 10px;
}
</style>