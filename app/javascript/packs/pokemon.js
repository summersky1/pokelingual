$(document).on('turbolinks:load',
    function() {
        $input = $("[data-behavior='autocomplete']")
        $locale = window.location.pathname.substr(1).split("/")[0]
        var options = {
            url: function(phrase) {
                return "/" + $locale + "/autocomplete?query=" + phrase;
            },
            getValue: "name",
            // only show results matching current query
            list: {
                match: {
                    enabled: true
                },
                onChooseEvent: function() {
                    var url = $input.getSelectedItemData().url
                    Turbolinks.visit(url)
                }
            },
            // keep search box full width
            cssClasses: "col px-0 custom-suggestion"
        };
        $input.easyAutocomplete(options);
    }
)
