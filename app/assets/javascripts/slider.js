$( function() {
    var year = new Date().getFullYear();
    var min_year = Number($("#min_year").val());
    var max_year = Number($("#max_year").val());

    $( "#slider-range" ).slider({
    range: true,
    min: min_year,
    max: max_year,
    values: [ $("#miny").val(), $("#maxy").val() ],
    slide: function( event, ui ) {
      $("#year").val(ui.values[0] + "-" + ui.values[1]);
      $("#miny").val(ui.values[0]);
      $("#maxy").val(ui.values[1]);
    }
  });
  $("#year").val($("#slider-range").slider("values", 0) + "-" + $("#slider-range").slider("values", 1));
} );
