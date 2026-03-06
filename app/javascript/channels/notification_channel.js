import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {

  const bell = document.getElementById("notification-bell")
  const list = document.getElementById("notifications")
  const badge = document.getElementById("notification-badge")

  if (!bell || !list) return

  consumer.subscriptions.create(
    { channel: "NotificationChannel", user_id: bell.dataset.userId },
    {
      connected() {
        console.log("NotificationChannel connected")
      },

      disconnected() {
        console.log("NotificationChannel disconnected")
      },

      received(data) {

        console.log("Notification received:", data)

        // 通知DOM作成
        const div = document.createElement("div")
        div.className = "notification-item unread"
        div.dataset.notificationId = data.id
        div.style.padding = "0.5rem"
        div.style.borderBottom = "1px solid #eee"
        div.style.cursor = "pointer"
        div.style.fontWeight = "bold"
        div.style.color = "#333"
        div.innerText = data.message

        // リスト先頭に追加
        list.prepend(div)

        // 未読バッジ更新
        if (badge) {
          badge.style.display = "inline-block"
          badge.innerText = Number(badge.innerText) + 1
        }

        bell.classList.add("has-new")
      }
    }
  )

  // ベルクリック
  bell.addEventListener("click", () => {

    if (list.style.display === "block") {

      list.style.display = "none"

    } else {

      list.style.display = "block"

      // バッジリセット
      if (badge) {
        badge.style.display = "none"
        badge.innerText = 0
      }

      bell.classList.remove("has-new")

      // 未読を既読に
      const unreadItems = list.querySelectorAll(".notification-item.unread")

      unreadItems.forEach(item => {

        item.classList.remove("unread")

        const id = item.dataset.notificationId

        fetch(`/notifications/${id}/mark_read`, {
          method: "PATCH",
          headers: {
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
          }
        })

      })
    }
  })

})
