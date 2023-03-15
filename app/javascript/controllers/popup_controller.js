import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="popup"
export default class extends Controller {
  static targets = [ "pageContainer" ];
  connect() {
    this.pageContainer = this.pageContainerTarget;
  }

  toggle(event) {
    this.pageContainer.style.left = '0';
  }

  close(event) {
    if (event.target === this.pageContainer) {
      this.pageContainer.style.left = '-100%';
    }
  }
}
