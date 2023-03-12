import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar-link"
export default class extends Controller {
  navigateToRoot(event) {
    event.preventDefault()
    Turbo.visit("/")
  }

  navigateToMessages(event) {
    event.preventDefault()
    Turbo.visit("/messages")
  }

  navigateToPayments(event) {
    event.preventDefault()
    Turbo.visit("/payments")
  }
}
