import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["video"];

  connect() {
    this.videoTarget.play();
  }

  disconnect() {
    this.videoTarget.pause();
  }
}
