import Turbo from '@hotwired/turbo'
import { Application } from "@hotwired/stimulus"
import { registerControllers } from 'stimulus-vite-helpers'

Turbo.start()

const application = Application.start()

const controllers = import.meta.globEager('../controllers/*.js')
registerControllers(application, controllers)
