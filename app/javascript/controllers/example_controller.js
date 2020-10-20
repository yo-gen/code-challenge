import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["button", "source"];

  initialize() {
    console.log("Example Controller");
  }
}
