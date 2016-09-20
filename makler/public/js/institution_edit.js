$(document).ready(function() {
    function noResults() {
        return 'Nema rezultata';
    }

    $('button.disabled').on('click', function (e) {
        e.preventDefault();
    });

    $('#instrument-types-list').select2({
        'placeholder': 'Izaberite model analizatora',
        'formatNoMatches': noResults
    });

    $('#instrument-types-list').on("select2-selecting", function (e) {
        var button = $('button.disabled')
        button.removeClass('disabled');
        button.off('click');
    });

    $('#lis_list').select2({
        'placeholder': 'Izaberite lis',
        'formatNoMatches': noResults
    });

    $('.supplier_list').select2({
        'placeholder': 'Izaberite isporučioca',
        allowClear: true,
        'formatNoMatches': noResults
    });

    $('.cancel').on('click', function (e) {
        e.preventDefault();
        $(this).foundation('reveal', 'close');
    });

    $('.delete').on('click', function (e) {
        e.preventDefault();

        url = $(this).parent().attr('action');
        data = $(this).parent().serialize();
        row = $(this).parents().eq(2);

        $.post(url, data, function (d) {
            row.fadeOut();
        });
    });

    $('.instrument-activation').click(function () {
        var url = '/instrument/' + $(this).attr('name');

        // TODO: There has to be a better way to do this
        if ($(this).is(':checked')) {
            var data = {
                'active': 'True'
            };
        }
        else {
            var data = {}
        }

        $.post(url, data)
    });
});

// Thi function is for uploading files
$(function(){
    $('.file_input_replacement').click(function(){
        //This will make the element with class file_input_replacement launch the select file dialog.
        var assocInput = $(this).siblings("input[type=file]");
        console.log(assocInput);
        assocInput.click();
    });
    $('.file_input_with_replacement').change(function(){
        //This portion can be used to trigger actions once the file was selected or changed. In this case, if the element triggering the select file dialog is an input, it fills it with the filename
        var thisInput = $(this);
        var assocInput = thisInput.siblings("input.file_input_replacement");
        if (assocInput.length > 0) {
          var filename = (thisInput.val()).replace(/^.*[\\\/]/, '');
          assocInput.val(filename);
        }
    });
});

$(document).ready(
    function(){
        $('input:file').change(
            function(){
                if ($(this).val()) {
                    $('input:submit').attr('disabled',false);
                }
            }
        );
});

$(document).ready(function() {
  var toogleText = jQuery(".more-toggle").html();
  jQuery(".more-toggle").prev().hide();
  jQuery(".more-toggle").addClass('closed');
  jQuery(".more-toggle").click(function() {
    jQuery(this).prev().slideToggle(100, function() {
      if ($(this).is(':hidden')) {
        jQuery(this).next().removeClass('open');
        jQuery(this).next().addClass('closed');
        jQuery(this).next().html(toogleText);
      } else {
        jQuery(this).next().removeClass('closed');
        jQuery(this).next().addClass('open');
        jQuery(this).next().html('<i class="fa fa-minus fa-1x color_light_grey" aria-hidden="true"></i>');
      }
    });
  });
});
