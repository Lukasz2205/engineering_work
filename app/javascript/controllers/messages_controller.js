import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['notification']

  connect() {
    setTimeout(() => {
      this.notificationTarget.children[0].classList.add('hiding')
      setTimeout(() => {
        this.notificationTarget.remove()
      }, 2000)
    }, 5000);
  }
}

