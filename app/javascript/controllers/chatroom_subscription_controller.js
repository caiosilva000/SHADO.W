import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "log", "input" ]

  connect() {
    this.subscription = consumer.subscriptions.create("ChatRoomChannel", {
      connected: this._connected.bind(this),
      disconnected: this._disconnected.bind(this),
      received: this._received.bind(this),
      speak: this._speak.bind(this)
    })
  }

  disconnect() {
    consumer.subscriptions.remove(this.subscription)
  }

  _connected() {
    console.log("Connected to chat room channel")
  }

  _disconnected() {
    console.log("Disconnected from chat room channel")
  }

  _received(data) {
    this.logTarget.insertAdjacentHTML("beforeend", `<p>${data.user_name}: ${data.message}</p>`)
  }

  _speak() {
    const message = this.inputTarget.value
    this.subscription.speak({ message })
    this.inputTarget.value = ""
  }
}
