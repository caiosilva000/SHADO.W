// app/javascript/controllers/login_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.centerCard();
    window.addEventListener("resize", this.centerCard.bind(this));
  }

  disconnect() {
    window.removeEventListener("resize", this.centerCard.bind(this));
  }

  centerCard() {
    let card = this.element;
    let windowHeight = window.innerHeight;
    let cardHeight = card.offsetHeight;
    card.style.top = ((windowHeight - cardHeight) / 2) + "px";
  }
}
