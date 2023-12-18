import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ['slider', 'image', 'switchLeft', 'switchRight']
  connect() {
    let numberOfImages = this.imageTargets.length - 1
    let currentPlace = 0
    if (numberOfImages === 0) {
      document.querySelector('.left-slider-arrow').classList.add('hidden')
      document.querySelector('.right-slider-arrow').classList.add('hidden')
    }

    this.sliderTarget.children[0].classList.remove('hidden')
    this.switchLeftTarget.addEventListener('click', () => {
      if (currentPlace === 0) {
        this.sliderTarget.children[currentPlace].classList.add('hidden')
        this.sliderTarget.children[numberOfImages].classList.remove('hidden')
        currentPlace = numberOfImages
        this.disableVideo()
      } else {
        this.sliderTarget.children[currentPlace].classList.add('hidden')
        currentPlace -= 1
        this.sliderTarget.children[currentPlace].classList.remove('hidden')
        this.disableVideo()
      }
    })

    this.switchRightTarget.addEventListener('click', () => {
      if (currentPlace === numberOfImages) {
        this.sliderTarget.children[numberOfImages].classList.add('hidden')
        currentPlace = 0
        this.sliderTarget.children[currentPlace].classList.remove('hidden')
        this.disableVideo()
      } else {
        this.sliderTarget.children[currentPlace].classList.add('hidden')
        currentPlace += 1
        this.sliderTarget.children[currentPlace].classList.remove('hidden')
        this.disableVideo()
      }
    })
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
