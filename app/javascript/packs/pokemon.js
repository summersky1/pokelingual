$(document).on('turbolinks:load',
    function() {
        $input = $("[data-behavior='autocomplete']")
        var options = {
            url: function(phrase) {
                return "/autocomplete?query=" + phrase;
            },
            // only show results matching current query
            list: {
                match: {
                    enabled: true
                }
            },
            // keep search box full width
            cssClasses: "col px-0"
        };
        $input.easyAutocomplete(options);
    }
)
