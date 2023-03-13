import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  // Inform the controller that it has two targets in the form, which are our inputs
  static targets = [ "startTime", "endTime" ]
  static values = { availability: Object }

  connect() {
    console.log(this.availabilityValue)
    const days = [this.availabilityValue['sunday'], this.availabilityValue['monday'], this.availabilityValue['tuesday'], this.availabilityValue['wednesday'], this.availabilityValue['thursday'], this.availabilityValue['friday'], this.availabilityValue['saturday']]
    // console.log(days)
    // const arr =
    // days.forEach((day, i) => {
    //   if (!day) {
    //       function(date) {
    //         return (date.getDay() === i)
    //       }
    //     }
    //   })
    flatpickr(this.startTimeTarget, {
      enableTime: true,
      onChange: this.validateDateRange,
      minTime: this.availabilityValue["start"],
      maxTime: this.availabilityValue["end"],
      time_24hr: true,
      disable: [
        function(date) {
          if (!days[0]) {
              return (date.getDay() === 0 )
            }
          },
        function(date) {
          if (!days[1]) {
              return (date.getDay() === 1 )
            }
          },
        function(date) {
          if (!days[2]) {
              return (date.getDay() === 2 )
            }
          },
        function(date) {
          if (!days[3]) {
              return (date.getDay() === 3 )
            }
          },
        function(date) {
          if (!days[4]) {
              return (date.getDay() === 4 )
            }
          },
        function(date) {
          if (!days[5]) {
              return (date.getDay() === 5 )
            }
          },
        function(date) {
          if (!days[6]) {
              return (date.getDay() === 6 )
            }
          }
      ]
    })
  }

  validateDateRange = () => {
    const start = this.startTimeTarget.value ? new Date(this.startTimeTarget.value) : null;
    // const end = this.endTimeTarget.value ? new Date(this.endTimeTarget.value) : null;

    // if (start && end) {
    //   if (start.toDateString() !== end.toDateString()) {
    //     // If start and end dates are not on the same day, reset the end time to the start time
    //     this.endTimeTarget._flatpickr.setDate(start);
    //   }
    // }
  }
};
