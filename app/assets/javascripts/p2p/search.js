
  $(document).ready(function() {
    var cache = {};
    $("#search_books_input").autocomplete({
      minLength: 2,
      source: function( request, response ) {
        var term = request.term;
        if ( term in cache ) {
          response( cache[ term ] );
          return;
        }
 
        $.getJSON( "/p2p/search/" + request,{}, function( data, status, xhr ) {
          cache[ term ] = data;
          response( data );
        });
      }
    });
  });