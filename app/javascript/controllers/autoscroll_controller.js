import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['chat']

    connect() {
        this.scrollToBottom()
        const observer = new MutationObserver(function (mutationsList, observer) {
            console.log('xxxx')
            for (let mutation of mutationsList) {
                if (mutation.target.parentElement) {
                    console.log('Zmiana wykryta!');
                    this.scrollToBottom()
                }
            }
        }.bind(this));
        const config = {childList: true, subtree: true, attributes: true};
        observer.observe(this.chatTarget, config);
    }

    scrollToBottom() {
        this.chatTarget.scrollTop = this.chatTarget.scrollHeight
    }
}
