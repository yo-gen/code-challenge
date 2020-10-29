import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["source", "notice"];

  copy(event) {
    event.preventDefault;
    this.noticeTarget.classList.remove("d-none");
    this.element.querySelector(".clipboard-button").classList.add("d-none");
    navigator.clipboard.writeText(this.sourceTarget.value);
  }
}
