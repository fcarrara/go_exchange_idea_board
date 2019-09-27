// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

import 'bootstrap';
import {Draggable} from '@shopify/draggable';
import MicroModal from 'micromodal';

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

// Drag and drop feature

let originalColumn;
let lastOverColumn;
let originalNote;
let lastOverNote;

const draggable = new Draggable(document.querySelectorAll('.dropzone'), {
    draggable: '.drag-drop',
    mirror: {
        constrainDimensions: true,
    }
});

draggable.on('drag:start', (evt) => {
    originalColumn = evt.data.sourceContainer
    originalNote = evt.data.source
});

draggable.on('drag:over', (evt) => {
    lastOverNote = evt.data.over
});

draggable.on('drag:out', (evt) => {
    lastOverNote = originalNote;
});

draggable.on('drag:over:container', (evt) => {
    lastOverColumn = evt.data.overContainer;
});

draggable.on('drag:out:container', (evt) => {
    lastOverColumn = originalColumn;
});

$(function(){
    draggable.on('drag:stop', (evt) => {

        if (originalNote.id != lastOverNote.id) {
            var original_note_id = (evt.data.source.id).split("_")[1];
            var over_note_id = (lastOverNote.id).split("_")[1];

            liveSocket.owner(originalNote, view => view.pushWithReply("event", {
                event: 'group-notes',
                type: "click",
                value: { "source_note_id": original_note_id, "target_note_id": over_note_id }
            }));
        } else {
            if (originalColumn.id != lastOverColumn.id) {
                var note_id = (evt.data.source.id).split("_")[1];
                var new_column_id = (lastOverColumn.id).split("_")[1];

                liveSocket.owner(originalColumn, view => view.pushWithReply("event", {
                    event: 'update-note-column-id',
                    type: "click",
                    value: { "note_id": note_id, "new_column_id": new_column_id }
                }));
            }
        }

        return
    });
});

$(function () {
    $('.datepicker').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        todayHighlight: true
    });
    
    MicroModal.init({
        onShow: modal => document.getElementById('note_content').focus(), 
        onClose: modal => document.getElementById('note_content').value = "",
        openTrigger: 'data-modal-open',
        closeTrigger: 'data-modal-close',
        disableScroll: true,
        disableFocus: false,
        awaitOpenAnimation: false,
        awaitCloseAnimation: true
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

    // $('#note-modal').on('show.bs.modal', function () {
    //     let note = $('#note_content')
    //     note.val("")
    //     note.trigger('focus')
    // });

    // $('#note-modal').on('shown.bs.modal', function () {
    //     let note = $('#note_content')
    //     note.trigger('focus')
    // });

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


