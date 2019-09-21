// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"
import 'bootstrap';
import {Draggable} from '@shopify/draggable';

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/live")
liveSocket.connect()


let originalContainer;
let lastOverContainer;

const draggable = new Draggable(document.querySelectorAll('.dropzone'), {
    draggable: '.drag-drop',
    mirror: {
        constrainDimensions: true,
    }
});

// draggable.on('drag:over', () => console.log('Dragging over other drag elem'));
// draggable.on('drag:stop', (evt) => console.log(evt.dragEvent));
// draggable.on('drag:over:container', (evt) => console.log(evt.data.overContainer.id));
draggable.on('drag:start', (evt) => {
    originalContainer = evt.data.sourceContainer
});

draggable.on('drag:over:container', (evt) => {
    lastOverContainer = evt.data.overContainer;

//     container.classList.add("hover-container");
});

$(function(){
    draggable.on('drag:stop', (evt) => {
    if (originalContainer.id === lastOverContainer.id) {
            return;
        } else {
            var note_id = (evt.data.source.id).split("_")[1];
            var new_column_id = (lastOverContainer.id).split("_")[1];
            
            liveSocket.owner(originalContainer, view => view.pushWithReply("event", {
                event: 'update-note-column-id',
                type: "click",
                value: { "note_id": note_id, "new_column_id": new_column_id }
            }));
        }
    });
});

$(function () {
    $('#note-modal').on('show.bs.modal', function () {
        let note = $('#note_content')
        note.val("")
        note.trigger('focus')
    });
    
    $('#note-modal').on('shown.bs.modal', function () {
        let note = $('#note_content')
        note.trigger('focus')
    });

    $('.datepicker').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        todayHighlight: true
    });
});

function initSelect2(selector) {

    function formatColor(option) {
        if (!option.id) {
            return option.text;
        }
        
        var $option = $(
            '<span class="color-select ' + option.element.value + '"></span>'
        );

        return $option;
    };

    if (!isInitialized()) {
        $(selector).select2({
            templateResult: formatColor,
            templateSelection: formatColor,
            minimumResultsForSearch: -1,
            placeholder: "Color",
            width: "55px"
        })
    }

    function isInitialized() {
        return $(selector).hasClass("select2-hidden-accessible")
    }
}

$(document).on("phx:update", (e) => {
    $('.color-picker').each(function (index, value) {
        let id = $(this).attr('id')
        initSelect2('#' + id)
    });

    // $('.color-picker').each(function(){
    //     $(this).on('select2:select', function (e) {
    //         var data = e.currentTarget.value;
    //         console.log(data);
    //     });
    // })
    // $('.color-picker').find().each(function() {
    //     // var name = $($(this).html()).prop('class');
    //     // console.log(name)
    //     // $('#' + name).selectpicker();
    //     console.log($(this));
    // });

    // initSelect2(".color-picker")
});


