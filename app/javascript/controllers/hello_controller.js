import { Controller } from "stimulus";

export default class extends Controller {
  // connect() {
  //   this.element.textContent = "Hello World!"
  // }
  static targets = ["input", "output"];
  greet() {
    this.outputTarget.textContent = this.input;
    this.inputTarget.value = null;
  }
  get input() {
    return this.inputTarget.value;
  }
}
