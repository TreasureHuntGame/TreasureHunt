$(function() {
    if ($.cookie("contrast") === "true") {
        $('#contrast').prop('checked', true);
    }

    $(".navbar-collapse>.navbar-nav>.nav-item>label").click(function() {
        $("#collapse-btn").prop("checked", false);
    });

    $(".label-link").keydown(function(event) {
        if (event.which == 13 || event.which == 32) {
            $(this).click();
        }
    });


    $("#contrast").change(function() {
        if ($(this).is(":checked")) {
            $.cookie("contrast", "true", { expires: 60, path: "/" });
        } else {
            $.cookie("contrast", "false", { expires: 60, path: "/" });
        }

    });

});