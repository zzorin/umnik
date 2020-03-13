$(function() {
  $('.users_autocomplete').autocomplete({
    source: ['qwe', 'qw', 'q']
  });

  //$('.users_autocomplete').autocomplete({
    //source: function(request, response) {
      //$.ajax({
        //url: '/users/search',
        //data: {
          //term: request.term
        //},
        //success: function(data) {
          //return response(data);
        //}
      //});
      //return {
        //error: function(data) {
          //if (data.status === 500) {
            //return window.location = '/';
          //}
        //}
      //};
    //}
  //});
  //return {
    //minLength: 2,
    //select: function(event, ui) {
      //$('#permission_user_id').val(ui.item.id);
      //$('.users_autocomplete').val(ui.item.label);
      //return false;
    //}
  //};
});
