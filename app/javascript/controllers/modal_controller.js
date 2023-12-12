import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ['button', 'modal']

  openModal() {
    this.modalTarget.style.display = 'block';
    document.body.classList.add('modal-open');
  }

  closeModal() {
    this.modalTarget.style.display = 'none';
    document.body.classList.remove('modal-open');
  }
}
