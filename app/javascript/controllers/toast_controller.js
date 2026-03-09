import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

  static values = { delay: Number, manual: Boolean }

  connect() {
    // console.log("'Toast' controller connected")

    if (!this.manualValue)
      this.show()
  }

  show() {
    const toast = new bootstrap.Toast(this.element, { animation: true, delay: this.delayValue || 2500 })
    toast.show()
  }
}