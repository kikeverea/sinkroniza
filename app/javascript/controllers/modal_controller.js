import { Controller } from "@hotwired/stimulus"
export default class extends Controller {

  static values = { modalId: String, action: String }

  connect() {
    // console.log("'Modal' controller connected", this.modalIdValue)

    const modalElement = document.getElementById(this.modalIdValue)
    const modal = bootstrap.Modal.getOrCreateInstance(modalElement)

    switch (this.actionValue) {
      case 'show':
      case 'open':
        modal.show()
        break

      case 'hide':
      case 'close':
        modal.hide()
        break

      default:
        throw new Error(`Unknown action value: ${this.actionValue}`)
    }
  }
}
