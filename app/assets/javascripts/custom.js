$(document).on('ready page:load', function() {
  $('.poster_show').load(function() {
    $(this).data('height', this.height);
  }).bind('mouseenter mouseleave', function(e) {
    $(this).stop().animate({
      height: $(this).data('height') * (e.type === 'mouseenter' ? 2 : 1)
    });
  });

  $('#numeric').keypress(function(e) {
    var verified = (e.which == 8 || e.which == undefined || e.which == 0) ? null : String.fromCharCode(e.which).match(/[^0-9]/);
    if (verified)
      e.preventDefault();
  });
});
