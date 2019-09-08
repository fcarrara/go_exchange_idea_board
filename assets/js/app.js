// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"
import 'bootstrap';

window.$ = window.jQuery = require("jquery");

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

//Micromodal
// import MicroModal from 'micromodal'
// MicroModal.init({
//     onClose: modal => modal.querySelector("#note_content").value = '',
//     disableFocus: true
// })

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/live")
liveSocket.connect()

// const EVENT_ATTR = 'phx-modal-click';
// document.addEventListener('phx:update', () => {
//     document.querySelectorAll(`[${EVENT_ATTR}]`).forEach(el => {
//         el.addEventListener('click', () => {
//             if (confirm('Are you sure?')) {
//                 const target = document.querySelector('[data-phx-view]');
//                 liveSocket.owner(target, view => view.pushWithReply("event", {
//                     event: el.getAttribute(EVENT_ATTR),
//                     type: "click",
//                     value: el.getAttribute('phx-value')
//                 }));
//             }
//         });
//     });
// });

// $("#modal-1").modal('show');
