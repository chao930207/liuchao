; (function ($) {
    $.fn.extend ({
        menushow : function() {
            $(".div_locked").css("opacity", 1);
            $(".div_locked").css("visibility", "visible");
            $("#main_container").css("left", 0);
        },
        menuclose : function() {
            $(".div_locked").css("opacity", 0);
            $(".div_locked").css("visibility", "hidden");
            $("#main_container").css("left", "-285px");
        },
    });
}) (jQuery);
