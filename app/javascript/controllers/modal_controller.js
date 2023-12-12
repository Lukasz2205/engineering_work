import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ['button', 'modal', 'imageModal']

  openModal() {
    this.modalTarget.style.display = 'block';
    document.body.classList.add('modal-open');
  }

  openImageModal() {
    this.imageModalTarget.style.display = 'block';
    document.body.classList.add('modal-open');
  }

  closeImageModal() {
    this.imageModalTarget.style.display = 'none';
    this.disableVideo()
    document.body.classList.remove('modal-open');
  }

  closeModal() {
    this.modalTarget.style.display = 'none';
    this.disableVideo()
    document.body.classList.remove('modal-open');
  }

  disableVideo() {
    const videos = document.querySelectorAll('video')
    if (videos.length > 0) {
      videos.forEach((video) => {
        video.pause()
      })
    }

  }
  }
