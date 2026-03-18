import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // console.log('Select2 controller connected')

    const data = this.element.dataset

    this.placeholder = data.selectPlaceholder
    this.createUrl = data.createUrl
    this.createParamName = data.createParamName || 'name'
    this.tagCreation = data.tagCreation ? data.tagCreation === "true" : true
    this.queryArgs = data.queryArgs ? JSON.parse(data.queryArgs) : {}
    this.createMessage = data.createMessage
    this.modelName = data.modelName
    this.buildUrl = data.buildUrl
    this.buildMethod = data.buildMethod?.toUpperCase() || "PATCH"
    this.containerSelector = data.containerCssSelector
    this.hideSearch = data.hideSearch === 'true'
    this.isMultiple = this.element.hasAttribute('multiple')
    this.filterable = data.filterable || data.filter
    this.ignoreCharacterInSearch = data.ignoreCharacterInSearch
    this.localCreation = data.localCreation
    this.sameIdAndValue = data.sameIdAndValue

    if (this.isSelect2(this.element))
      return

    this.select = $(this.element).select2(this.config())

    $(this.select).on('select2:open', function() {
      $('.select2-search__field').attr('autocomplete', 'off')
    })

    const rawValue = this.element.dataset.value
    const isPlainText = rawValue != null && !/^\s*[\[{]/.test(rawValue.trim())

    const value = isPlainText
      ? rawValue
      : rawValue && JSON.parse(rawValue)

    if (value?.length)
      this.setValue(value)

    this.propagateSelectEvents()
    this.propagateClearEvents()
    this.preventEscKeyEventPropagation()
  }

  // API
  listenToChangeEvents(listener) {
    this.selectionChangeListener = listener
  }

  // API
  disable(disabled, message='') {
    this.element.disabled = disabled

    const initialized = !!this.select

    if (initialized)
      this.changePlaceholder(message || this.placeholder)
    else
      this.disabledPlaceholder = disabled ? message : ''
  }

  // API
  listenToTagCreationRequests(listener) {
    this.tagCreationRequestsListener = listener
  }

  // API
  addAndSelectItem(id, name, data) {
    if (id && name)
      this.onItemCreated({ id, name, data })
  }

  // API
  setFilter(filter) {
    this.filter = filter
  }

  // API
  clearSelection() {
    $(this.element).val(null).trigger('change')
  }

  // API
  addTagRequestArgs(args) {
    if (!this.tagRequestArgs)
      this.tagRequestArgs = args
    else
      this.tagRequestArgs = { ...this.tagRequestArgs, ...args }
  }

  changePlaceholder(placeholder) {
    this.select = $(this.element).select2('destroy').select2({
      ...this.config(),
      placeholder: placeholder
    })
  }

  propagateSelectEvents() {
    const changeListener = this.selectionChangeListener

    this.select.on('select2:select', function () {
      let event = new Event('change', { bubbles: true }) // fires vanilla JS event
      this.dispatchEvent(event)

      changeListener && changeListener({
        selectedOn: this.id, value: this.value
      })
    })
  }

  propagateClearEvents() {
    this.select.on('select2:unselect', function () {
      let event = new Event('change', { bubbles: true }) // fires vanilla JS event
      this.dispatchEvent(event)
    })
  }

  preventEscKeyEventPropagation() {
    this.select.on('select2:open', function(e) {
      const searchInput = $(e.target).data('select2').$dropdown.find('input');

      searchInput.on('keydown', function(event) {
        if (event.key === 'Escape')
          event.stopPropagation()
      })
    })
  }

  config() {
    const defaultMatcher = $.fn.select2.defaults.defaults.matcher

    const config = {
      width: '100%',
      matcher: function(params, data) {
        return data?.element?.dataset?.hide === 'true'
          ? null
          : defaultMatcher(params, data)
      }
    }

    const createTagsUrl = this.createUrl || this.buildUrl

    if (this.placeholder || this.disabledPlaceholder)
      this.addPlaceholder(config)

    if (createTagsUrl)
      this.addTags(config)

    if (this.containerSelector)
      this.addContainer(config)

    if (this.hideSearch)
      this.addHideSearch(config)

    if (this.isMultiple)
      this.addMultiple(config)

    if (this.filterable)
      this.addFilter(config)

    if (this.ignoreCharacterInSearch)
      this.addIgnoreCharacterInSearch(config)

    if (createTagsUrl)
      this.listenForTagCreation(createTagsUrl)

    return config
  }

  isSelect2(select) {
    return $(select).hasClass("select2-hidden-accessible")
  }

  addPlaceholder(config) {
    config.placeholder = this.disabledPlaceholder || this.placeholder
  }

  addTags(config) {
    config.createTag = item => {
      this.searchValue = item.term

      return {
        id: item.term,
        text: this.createMessage || `Create '${item.term}'`,
      }
    }
    config.tags = true
  }

  addContainer(config) {
    config.dropdownParent = $(this.containerSelector)
  }

  addMultiple(config) {
    config.multiple = true
    config.closeOnSelect = false
  }

  addFilter(config) {
    config.templateResult = state => {

      if (!this.filter || state.text.startsWith(this.createMessage || 'Create '))
        return state.text

      const element = state.element

      if (!element)
        return

      return element.dataset.filter === this.filter ? state.text : null
    }
  }

  addIgnoreCharacterInSearch(config) {
    config.matcher = (params, data) => {
      const searchTerm = params.term?.trim()

      if (!searchTerm)
        return data

      const searchText = searchTerm.replaceAll(this.ignoreCharacterInSearch, '').toLowerCase()
      const text = data.text.trim().replaceAll(this.ignoreCharacterInSearch, '').toLowerCase()

      const searchWords = searchText.split(/\s+/)
      const itemWords = text.split(/\s+/)

      const isMatch = searchWords.reduce(
        (isMatch, searchWord) => isMatch && itemWords.reduce(
          (inSearch, itemWord) => inSearch || itemWord.startsWith(searchWord), false)
        , true)

      return isMatch ? data : null
    }
  }

  addHideSearch(config) {
    config.minimumResultsForSearch = -1
  }

  setValue(value) {
    if (this.isMultiple) {
      this.select.val(value.map(element => typeof element === 'object' ? element.id : element))
    }

    else this.select.val(value)

    this.select.trigger('change')
  }

  listenForTagCreation(createUrl) {

    if (!this.modelName && !createUrl.includes('.json'))
      throw Error('A model name or valid url (.json) must be provided for item creation')

    $(this.element).on('select2:select', () => {

      const selected = $(this.element).find(':selected')

      const valueDoesntExist = this.createMessage
        ? selected.text() === this.createMessage
        : selected.text().includes(`Create '${this.searchValue}'`)

      if (valueDoesntExist) {
        if (this.localCreation)
          this.onItemCreated({ [this.createParamName]: this.searchValue })
        else
          this.createSelectedValue(this.searchValue)
      }
    })
  }

  createSelectedValue(value) {
    const item = {}
    item[this.createParamName] = value

    if (this.tagRequestArgs)
      this.addArgsToItem(item, this.tagRequestArgs)

    this.createItemForSelect(item)
  }

  getModelNameFromUrl() {
    const url = this.createUrl || this.buildUrl
    const match = url.match(/\W?(\w+)\W*/)
    const name = match[1]

    return name.endsWith('s')
      ? name.substring(0, name.length - 1)
      : name
  }

  addArgsToItem(item, args) {
    for (const [key, value] of Object.entries(args))
      item[key] = value
  }

  createItemForSelect(item) {
    if (this.isMultiple)
      this.removeCreateItemMessage()

    const itemName = this.modelName || this.getModelNameFromUrl()
    const createUrl = this.createUrl
    const buildUrl = this.buildUrl && this.appendArgsToUrl(this.buildUrl, item)
    const buildMethod = this.buildMethod



    if (createUrl) {
      $.ajax({
        type: "POST",
        url: this.parseUrl(createUrl),
        contentType: 'application/json',
        data: JSON.stringify({ [itemName]: item }),
        headers: { Accept: 'application/json' },
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success: created => {
          this.tagCreationRequestsListener && this.tagCreationRequestsListener()

          this.onItemCreated(created)

          if (buildUrl) {
            $.ajax({
              type: buildMethod,
              url: this.parseUrl(`${buildUrl}/${created.id}`),
              contentType: 'application/json',
              data: JSON.stringify(created),
              headers: { Accept: 'text/vnd.turbo-stream.html; text/html; application/xhtml+xml' },
              beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
              success: res => {
                Turbo.renderStreamMessage(res)
              }
            })
          }
        }
      })
    }
    else if(buildUrl) {
      $.ajax({
        type: buildMethod,
        url: this.parseUrl(buildUrl),
        contentType: 'application/json',
        data: buildMethod !== "GET" && JSON.stringify({ [itemName]: item }),
        headers: { Accept: 'text/vnd.turbo-stream.html; text/html; application/xhtml+xml' },
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        success: res => {
          this.tagCreationRequestsListener && this.tagCreationRequestsListener()

          Turbo.renderStreamMessage(res)
        }
      })
    }
  }

  parseUrl(path) {
    const queryArgs = Object
    .entries(this.queryArgs)
    .reduce((str, [key, value]) => `${str}&${key}=${value}`, `tag_creation=${this.tagCreation}`)

    return `${path}?${queryArgs}`
  }

  appendArgsToUrl(url, item) {
    return Object
    .entries(item)
    .reduce((url, [key, value]) => url + `${key}=${value}&`,
      `${url}?`)
  }

  removeCreateItemMessage() {
    const select = this.select
    const selectedValues = select.val()
    const searchField = select.next().find('.select2-search__field')

    selectedValues.splice(selectedValues.length -1, 1)
    select.val(selectedValues)
    select.trigger('change')

    searchField.focus()
  }

  onItemCreated(created) {
    const { option, id } = this.createOptionElement(created)

    this.select.append(option)

    if (!this.isMultiple)
      this.removeSelected()

    this.selectOption(id)
  }

  createOptionElement(createdItem) {
    const param = createdItem[this.createParamName]

    const id = this.sameIdAndValue ? param : createdItem.id

    const option = $('<option>', {
      value: id,
      text: param
    })

    option.attr('data-id', id)
    option.attr(`data-${this.createParamName}`, param)

    if (createdItem.data)
      Object
      .keys(createdItem.data)
      .forEach(dataAttr => option.attr(`data-${dataAttr}`, createdItem[dataAttr]))

    return { option, id }
  }

  removeSelected() {
    this.select.find(':selected').remove()
  }

  selectOption(id) {
    const select = $(this.element)

    if (this.isMultiple)
      select.val([ id, ...select.val() ])
    else
      select.val(id)

    select.trigger('change')
  }
}
