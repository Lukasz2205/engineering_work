import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['chat']

    connect() {
        this.scrollToBottom()
    }

    scrollToBottom() {
        this.chatTarget.scrollTop = this.chatTarget.scrollHeight
    }
}
