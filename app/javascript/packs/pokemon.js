$(document).on('turbolinks:load',
    function() {
        $input = $("[data-behavior='autocomplete']")
        $locale = window.location.pathname.substr(1).split("/")[0]
        var options = {
            url: function(phrase) {
                return "/" + $locale + "/autocomplete?query=" + phrase;
            },
            getValue: "name",
            list: {
                onChooseEvent: function() {
                    var url = $input.getSelectedItemData().url
                    Turbolinks.visit(url)
                },
                // only show results matching current query
                match: {
                    enabled: true
                }
            },
            // keep search box full width
            cssClasses: "col px-0 custom-suggestion"
        };
        $input.easyAutocomplete(options);
    }
)
