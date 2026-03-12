// Entry point for the build script
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", () => {

  // ===== モバイルメニュー =====
  const button = document.getElementById("mobile-menu-button")
  const menu = document.getElementById("mobile-menu")

  if (button && menu) {
    button.addEventListener("click", () => {
      menu.classList.toggle("hidden")

      if (menu.classList.contains("hidden")) {
        button.textContent = "☰"
      } else {
        button.textContent = "×"
      }
    })
  }

  // ===== サイドバー =====
  const toggle = document.getElementById("sidebar-toggle")
  const sidebar = document.getElementById("mobile-sidebar")
  const content = document.getElementById("content-wrapper")

  if (toggle && sidebar && content) {

    const icon = toggle.querySelector("span:first-child")

    const open = () => {
      sidebar.classList.remove("-translate-x-full")
      content.classList.add("translate-x-64")
      if (icon) icon.textContent = "×"
    }

    const close = () => {
      sidebar.classList.add("-translate-x-full")
      content.classList.remove("translate-x-64")
      if (icon) icon.textContent = "☰"
    }

    toggle.addEventListener("click", () => {
      sidebar.classList.contains("-translate-x-full") ? open() : close()
    })
  }

})

// ===== パスワード表示切替 =====
window.togglePassword = function(fieldId, button) {
  const field = document.getElementById(fieldId)
  if (!field) return

  const icon = button.querySelector("i")

  const isPassword = field.type === "password"
  field.type = isPassword ? "text" : "password"

  if (icon) {
    icon.classList.toggle("fa-eye")
    icon.classList.toggle("fa-eye-slash")
  }
}