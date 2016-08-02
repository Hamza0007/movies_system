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

  $('#show_advanced-search').click(function(event){
    event.preventDefault();
    $('div#advanced-search').toggle();
  });

  $('#trailer-iframe').focusout(function(){
    var value = $(this).val();
    if (value.indexOf('script') > -1)
    {
      alert('Enter iframe code only');
      return;
    }
    if(!(value.indexOf('iframe') > -1))
    {
       alert('Enter iframe code');
    }
  });

  $('.txt_box').keypress(function (e) {
    if (e.charCode != 0) {
      var regex = new RegExp("^[a-zA-Z0-9\\-\\s]+$");
      var key = String.fromCharCode(!e.charCode ? e.which : e.charCode);
      if (!regex.test(key)) {
        e.preventDefault();
        return false;
      }
    }
  });

  $('.pop').on('click', function() {
    $('.imagepreview').attr('src', $(this).find('img').attr('src'));
    $('#imagemodal').modal('show');
  });

});
