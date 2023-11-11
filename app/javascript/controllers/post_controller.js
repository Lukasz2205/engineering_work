import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ['content', 'button']

    connect() {
        const content = this.contentTarget

        if (content.textContent.length >= 500) {
            const showMoreLink = document.createElement('a')
            const showMoreText = document.getElementById('show-more')
            showMoreLink.setAttribute('href', '#');
            showMoreLink.setAttribute('data-action', 'click->post#showMore');
            showMoreLink.text = "Pokaż więcej..."
            content.parentElement.querySelector('.show-more').appendChild(showMoreLink)
        }
    }

    showMore(event) {
        event.preventDefault()
        this.contentTarget.classList.remove('post-limit')
        this.buttonTarget.classList.add('hidden')
    }
}