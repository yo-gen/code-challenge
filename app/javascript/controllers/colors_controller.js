import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ["selectedColor", "formColor"];
    color;

    changebg() {
        this.color = this.selectedColorTarget.value;
        this.formColorTarget.style.backgroundColor = this.color;
    }
}
