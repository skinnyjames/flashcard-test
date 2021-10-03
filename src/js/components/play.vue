<template>
  <h1>{{ title }}</h1>
  <div id="container">
    <div v-if="currentQuestion" class="current-question">
      {{ currentQuestion.text }}
    </div>
    <div v-else>
      that's all the questions!
    </div>
    <div class="answers">
      <span @click="tryAnswer(answer.id)" class="answer" v-for="answer in answers" :key="answer.id">
        {{ answer.text }}
      </span>
    </div>
  </div>
</template>


<script>
import { onMounted, ref } from "vue"
import { useRoute } from "vue-router"
import { shuffle } from "./../util"

const title = ref('')
const questions = ref([])
const answers = ref([])
const currentQuestion = ref({})

const tryAnswer = (id) => {
  if (id === currentQuestion.value.id) {
    questions.value = questions.value.filter(q => q.id !== id)
    answers.value = answers.value.filter(a => a.id !== id)
    currentQuestion.value = questions.value[0]
  } else {
    currentQuestion.value = questions.value[0]
  }
  shuffle(questions.value)
}

export default {
  setup() {
    const route = useRoute()

    onMounted(async() => {
      const res = await fetch(`/decks/${route.params.id}`)
      const deck = await res.json()
      questions.value = deck.questions
      answers.value = deck.questions.map(q => ({ text: q.answer, id: q.id }))
      shuffle(questions.value)
      currentQuestion.value = questions.value[0]
    })
    return {
      questions,
      title,
      currentQuestion,
      answers,
      tryAnswer
    }
  }

}
</script>

<style scoped>
#container {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  height: 100%;
}
div#app {
  width: 1200px;
}
div.current-question {
  width: 600px;
}
div.answers {
  width: 600px;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items:center;
}
div.answers span.answer {
  cursor: pointer;
  padding: 7px 5px;
  border: 1px solid #ccc;
  margin: 10px 10px;
}
</style>