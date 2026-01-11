// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", () => {
  const button = document.getElementById("mobile-menu-button");
  const menu = document.getElementById("mobile-menu");

  if (!button || !menu) return;

  button.addEventListener("click", () => {
    menu.classList.toggle("hidden");
  });
});

document.addEventListener("turbo:load", () => {
  const toggle = document.getElementById("sidebar-toggle");
  const sidebar = document.getElementById("mobile-sidebar");
  const content = document.getElementById("content-wrapper");
  const icon = document.getElementById("sidebar-icon");

  if (!toggle) return;

  const open = () => {
    sidebar.classList.remove("-translate-x-full");
    content.classList.add("translate-x-64");
    icon.textContent = "×";
  };

  const close = () => {
    sidebar.classList.add("-translate-x-full");
    content.classList.remove("translate-x-64");
    icon.textContent = "☰";
  };

  toggle.addEventListener("click", () => {
    sidebar.classList.contains("-translate-x-full") ? open() : close();
  });
});