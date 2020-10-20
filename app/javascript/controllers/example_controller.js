import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["button", "textToReverse", "inputWarning"];

  initialize() {
    console.log("Example Controller initialize()");
  }

  entry(e) {
    if (this.textToReverseTarget.value.length !== 0) {
      hideButtons(this.buttonTargets);
      this.inputWarningTarget.classList.add("d-none");
    } else {
      showButtons(this.buttonTargets);
      this.inputWarningTarget.classList.remove("d-none");
    }
  }

  reverse(e) {
    this.textToReverseTarget.value = reverseString(
      this.textToReverseTarget.value
    );
  }

  uppercase(e) {
    this.textToReverseTarget.value = this.textToReverseTarget.value.toUpperCase();
  }
}

function reverseString(str) {
  return str.split("").reverse().join("");
}

function hideButtons(btns) {
  btns.forEach(function (element) {
    element.classList.remove("d-none");
  });
}

function showButtons(btns) {
  btns.forEach(function (element) {
    element.classList.add("d-none");
  });
}
