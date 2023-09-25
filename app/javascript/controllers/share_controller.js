import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['author', 'content', 'result']

    connect() {
        console.log(this.contentTarget.textContent);
        console.log(this.authorTarget.textContent);
        console.log(this.data.get('urlValue'));
    }

    async share(e) {
        e.preventDefault()


        const shareData = {
            content: this.contentTarget.textContent,
            author: this.authorTarget.textContent,
            url: this.data.get('urlValue')
        };
        try {
            await navigator.share(shareData);
            this.resultTarget.textContent = 'Thanks for sharing';
        } catch (err) {
            this.resultTarget.textContent = `something went wrong ${err}`;
        }

        console.log(shareData);
    }
}