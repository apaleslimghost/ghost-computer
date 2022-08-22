import { Controller } from '@hotwired/stimulus'

export default class DragDrop extends Controller {
	static targets = ['form', 'messages']

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

			const updates = await response.json()

			this.messagesTarget.innerHTML = `<ul>
				${updates.map(update => `
					<li>
						${update.filename
							? `<a href="/post_assets/${update.filename}">${update.filename}</a> uploaded`
							: `<a href="/posts/${update.id}">${update.title}</a> created`}
					</li>
				`)}
			</ul>`
		} catch (error) {
			alert(error.message)
		}
	}
}
