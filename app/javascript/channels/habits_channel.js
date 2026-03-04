// app/javascript/channels/habits_channel.js
import consumer from "./consumer"

consumer.subscriptions.create("HabitsChannel", {
  connected() {
    console.log("HabitsChannel connected")
  },

  disconnected() {
    console.log("HabitsChannel disconnected")
  },

  received(data) {
    // サーバから送られてきたデータで進捗バーを更新
    // data = { week_completion_rate: 70, month_completion_rate: 80 } みたいな想定
    const weekBar = document.querySelector(".week-completion-bar")
    const monthBar = document.querySelector(".month-completion-bar")

    if (weekBar && data.week_completion_rate !== undefined) {
      weekBar.style.width = `${data.week_completion_rate}%`
      weekBar.previousElementSibling.textContent = `今週の達成率: ${data.week_completion_rate}%`
    }

    if (monthBar && data.month_completion_rate !== undefined) {
      monthBar.style.width = `${data.month_completion_rate}%`
      monthBar.previousElementSibling.textContent = `今月の達成率: ${data.month_completion_rate}%`
    }
  }
})
