import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('turbo:submit-end', () => {
      let searchInput = document.getElementById('search[query]');
      let errorAlert = document.getElementById('error-alert');
      // removes the Error Alert if it exists
      if (errorAlert) {
        errorAlert.remove();
      }
      searchInput.blur();
      searchInput.value = '';
    })
  }
}
