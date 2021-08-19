<template>
  <div id="new-deck-container">
    <h4>New Deck</h4>
    <label for="title">Title</label>
    <input type="text" id="title" v-model="activeDeck" />
    <h5>Questions</h5>
    
  </div>
</template>
<script>
import { onMounted, ref } from "vue"

let activeDeck = ref({})
let questions = ref([])

export default {
  setup() {
    onMounted(async() => {
      const res = await fetch("/decks", { method: "POST" })
      activeDeck = await res.json()
    })
    return { 
      activeDeck,
      questions
    }
  }
}
</script>