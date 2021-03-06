import Rails from "@rails/ujs"
import turbolinks from 'turbolinks'
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

Rails.start()
turbolinks.start()

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
