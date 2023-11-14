import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ['button', 'sidebar']

  toggle() {
    let button = this.buttonTarget
    this.sidebarTarget.classList.toggle('active');

    if(button.classList.contains('bxs-right-arrow')) {
      button.classList.remove('bxs-right-arrow')
      button.classList.add('bxs-left-arrow')
    } else {
      button.classList.add('bxs-right-arrow')
      button.classList.remove('bxs-left-arrow')
    }
  }
}
