import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["button", "textToReverse"];

  initialize() {
    console.log("Example Controller");
  }

  reverse(e) {
    console.log("button clicked!");
    this.textToReverseTarget.value = processString(
      this.textToReverseTarget.value
    );
  }
}

function processString(str) {
  return str.split("").reverse().join("");
}

function toggleButtonDisabledState(btn) {
  btn.disabled.toggle;
}
