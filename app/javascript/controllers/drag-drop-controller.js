import { Controller } from 'stimulus'

export default class DragDrop extends Controller {
	static targets = ['form']

	showOverlay(event) {
		event.preventDefault()
		this.element.classList.add('dropping')
	}

	hideOverlay() {
		this.element.classList.remove('dropping')
	}

	async uploadFiles(event) {
		try {
			event.preventDefault()
			this.hideOverlay()

			const form = this.formTarget
			const data = new FormData(form)
			const files = event.dataTransfer.files

			if (!files.length) {
				throw new Error('no files were dropped')
			}

			// TODO use webkitGetAsEntry and traverse tree
			for (const file of files) {
				data.append('files[]', file)
			}

			const response = await fetch(form.action, {
				method: 'POST',
				body: data
			})

			if (!response.ok) {
				const message = await response.text()
				throw new Error(message)
			}
		} catch (error) {
			alert(error.message)
		}
	}
}
