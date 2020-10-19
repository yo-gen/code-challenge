import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["button", "source"];

  connect() {
    console.log("Connecting example controller");
  }

  example_action(event) {
    event.preventDefault();
    console.log("JavaScript Action Taken");
  }
}
