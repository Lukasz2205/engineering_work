import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ['button', 'sidebar']

  toggle() {
    let button = this.buttonTarget
    this.sidebarTarget.classList.toggle('active');

    if(button.classList.contains('bxs-right-arrow')) {
      document.cookie = 'sidebar_active' + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
      document.cookie = "sidebar_active=true;path=/";
      button.classList.remove('bxs-right-arrow')
      button.classList.add('bxs-left-arrow')
    } else {
      document.cookie = 'sidebar_active' + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
      document.cookie = "sidebar_active=false;path=/";
      button.classList.add('bxs-right-arrow')
      button.classList.remove('bxs-left-arrow')
    }
  }
}
