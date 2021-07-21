import { Controller } from "stimulus";

export default class extends Controller {
  // connect() {
  //   this.element.textContent = "Hello World!"
  // }
  initialize() {
    //this.num = 0;
  }
  static targets = ["number"];
  static values = { num: Number };
  call() {
    this.numValue++;
  }
  numValueChanged() {
    this.numberTarget.textContent = this.numValue;
    console.log(this.numValue);
  }
  // get number() {
  //   const nb = parseInt(this.numberTarget.innerText);
  //   return nb + 1;
  // }
}
