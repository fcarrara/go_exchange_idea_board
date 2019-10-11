import css from "../css/app.scss"
import "phoenix_html"
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

import 'bootstrap'
import {Draggable} from '@shopify/draggable'


// LiveView

let liveSocket = new LiveSocket("/live", Socket)
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


// Datepicker

$('.datepicker').datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true,
    todayHighlight: true
});


// Modal events

$('.add-note').on("click", function () {
    let note = $('#note_content')
    note.val("")
    setTimeout(function () { note.trigger("focus") }, 300);
})

$('.edit-note').on("click", function () {
    let note = $('#note_content')
    setTimeout(function () { note.trigger("focus") }, 300);
})


// Select2

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

    $('[data-toggle="tooltip"]').tooltip()
});
