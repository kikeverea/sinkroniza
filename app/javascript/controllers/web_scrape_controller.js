import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ 'scrapeButton', 'scrapeLoader' ]

  connect() {
    // console.log("Controller 'Web scrape controller' connected")
  }

  scrape() {
    const form = this.element.closest('form')

    this.scrapeLoaderTarget.classList.remove('d-none')
    this.scrapeButtonTarget.classList.add('d-none')

    form.action = `/webs/scrape`
    form.querySelector('input[name=_method]').value = 'post'
    form.requestSubmit()
  }
}
