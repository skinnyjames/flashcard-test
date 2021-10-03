<template>
  <div id="new-deck-container">
    <h4>New Deck</h4>
    <label for="title">Title</label>
    <input type="text" id="title" v-model="activeDeck.title" @keyup="saveTitle" />
    <h5>Questions</h5>
    <div v-for="(q, idx) in questions" :key="idx">
      <label :for="`question-${idx}`">Question {{idx}}</label>
      <input @keyup="saveQuestion(q.id)" type="text" :id="`question-${idx}`" v-model="q.text" />
      <label :for="`answer-${idx}`">Answer</label>
      <input @keyup="saveQuestion(q.id)" type="text" :id="`answer-${idx}`" v-model="q.answer" />
      <button @click="deleteQuestion(q.id)">delete question</button>
    </div>
    <button @click="newQuestion">New Question</button>
  </div>
</template>
<script>
import { onMounted, ref } from "vue"
import { debounce } from "../util"
import { useRoute } from 'vue-router'

let activeDeck = ref({ title: null, id: null })
let questions = ref([])

const saveTitle = debounce(async() => {
  await fetch(`/decks/${activeDeck.value.id}`, { method: "PUT", body: JSON.stringify(activeDeck.value) })
}, 250)

const newQuestion = async() => {
  const res = await fetch(`/decks/${activeDeck.value.id}/questions`, { method: "POST"})
  const question = await res.json()
  questions.value.push(question)
}

const deleteQuestion = async(id) => {
  await fetch(`/decks/${activeDeck.value.id}/questions/${id}`, { method: "DELETE"})
  questions.value = questions.value.filter(q => q.id !== id)
}

const saveQuestion = debounce(async(id) => {
  const q = questions.value.find(q => q.id === id)
  await fetch(`/decks/${activeDeck.value.id}/questions/${id}`, { method: "PUT", body: JSON.stringify(q)})
}, 250)

export default {
  setup() {
    const route = useRoute()

    onMounted(async() => {
      console.log(route.params)
      if (route.params.id === undefined) {
        const res = await fetch("/decks", { method: "POST" })
        activeDeck.value = await res.json()
        questions.value = []
      } else {
        const res = await fetch(`/decks/${route.params.id}`)
        const json = await res.json()
        activeDeck.value = { title: json.title, id: json.id }
        questions.value = json.questions
      }
    })
    return { 
      activeDeck,
      questions,
      saveTitle,
      newQuestion,
      deleteQuestion,
      saveQuestion
    }
  }
}
</script>