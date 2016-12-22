$(document).ready(function() {
    function noResults() {
        return 'Nema rezultata';
    }

    $('#institutions-list').select2({
        'placeholder': 'Izaberite ustanovu',
        'formatNoMatches': noResults
    });

    $('#instrument-types-list').select2({
        'placeholder': 'Izaberite model aparata',
        'formatNoMatches': noResults
    });

    $('#institutions-list').on("select2-selecting", function (e) {
        var url = "/institution/" + e.val
        window.location.href = url
    });

    $('#instrument-types-list').on("select2-selecting", function (e) {
        var url = "/instrument_type/" + e.val
        window.location.href = url
    });
    
    $('#users-list').select2({
        'placeholder': 'Lista registrovanih korisnika',
        'formatNoMatches': noResults
    });

    $('#users-list').on("select2-selecting", function (e) {
        var url = "/user_edit/" + e.val
        window.location.href = url
    });

});
