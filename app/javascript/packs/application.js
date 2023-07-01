// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import "popper.js"
import "bootstrap"
import "../stylesheets/application"
window.$ = window.jQuery = require('jquery'); //windowオブジェクト
import Raty from "raty.js"
window.raty = function(elem,opt) {            //raty.jsから Raty というオブジェクトをインポートして、
  let raty =  new Raty(elem,opt)              //グローバル変数の window.raty に設定
  raty.init();                                //function(関数)で様々な処理をひとつにまとめている。
  return raty;                                //動的。ループさせている。
}

Rails.start()
Turbolinks.start()
ActiveStorage.start()


