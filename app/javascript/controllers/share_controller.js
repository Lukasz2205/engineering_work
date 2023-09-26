import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['author', 'content', 'result']

    connect() {
    }

    async share(e) {
        e.preventDefault()
        const shareData = {
            content: this.contentTarget.textContent,
            author: this.authorTarget.textContent,
            url: this.data.get('urlValue')
        }
        try {
            await navigator.share(shareData);
            this.resultTarget.textContent = 'Thanks for sharing';
        } catch (err) {
            this.resultTarget.textContent = `something went wrong ${err}`;
        }

    }
}