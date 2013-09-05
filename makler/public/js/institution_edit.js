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

    $('#cancel-instrument-add').on('click', function (e) {
        e.preventDefault();
        $(this).foundation('reveal', 'close');
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
