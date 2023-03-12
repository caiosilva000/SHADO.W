import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "stimulus/webpclearack-helpers"
import * as Turbo from "@hotwired/turbo"
const application = Application.start()
// const context = require.context("./controllers", true, /\.js$/)
// application.load(definitionsFromContext(context))

window.Turbo = Turbo
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
