import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ 'searchInput', 'indicator', 'perPage' ]
  static values = [ 'ransackQuery', 'page', 'perPage' ]

  connect() {
    console.log("'Ransack' controller connected")

    this.sendSearchRequest = this.debounce(() => this.sendRansack())
    this.form = this.element

    if (this.ransackQueryValue)
      this.searchInputTarget.focus()
  }

  search() {
    this.indicatorTarget.classList.remove('d-none')
    this.sendSearchRequest()
  }

  debounce(func) {
    let timeout
    return () => {
      clearTimeout(timeout)
      timeout = setTimeout(func, 300)
    }
  }

  setItemsPerPage(perPage) {
    this.perPageTarget.value = perPage
    this.form.requestSubmit()
  }

  sendRansack() {
    this.form.requestSubmit()
    setTimeout(() => this.indicatorTarget.classList.add('d-none'), 100)
  }
}
