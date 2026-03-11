import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect(dontShow) {
    // console.log("'Tooltip' controller connected")

    if (dontShow)
      return

    const tooltip = bootstrap.Tooltip.getOrCreateInstance(this.element)
    tooltip.hide()
  }
}