import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["selectize"];

  initialize() {
    // This inits the selectize with options
    var $input = $(this.selectizeTarget).selectize({
      plugins: ["remove_button"],
      delimiter: ",",
      persist: false,
      placeholder: "Search for or Add a Tag",
      create: function(input) {
        return {
          value: input,
          text: input
        };
      }
    });
  }
}
