import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  // Inform the controller that it has two targets in the form, which are our inputs
  static targets = [ "startTime", "endTime" ]
  static values = { availableDates: Array }

  connect() {

  if (this.hasEndTimeTarget) {
    flatpickr(this.endTimeTarget, {time_24hr: true, enableTime: true})
  }

  const options = {
    enableTime: true,
    time_24hr: true
  }

if (this.availableDatesValue && this.availableDatesValue.length) {
options["enable"] = this.availableDatesValue
}

flatpickr(this.startTimeTarget, options)
  }
};
