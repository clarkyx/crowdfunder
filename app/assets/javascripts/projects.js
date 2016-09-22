$(function(){
  $("button").click(function(e){
    e.preventDefault;
    var idbutton = $(this).attr("id").split("|")[0];
    var project = $(this).attr("id").split("|")[1];
    $.ajax({
      url: '/users/' + $(this).attr("class") + '/pledges',
      method: 'post',
      data: {'reward': idbutton, 'project': project},
      dataType: 'json'
    }).done(function(response){
      $('p#earned' + response.projectid).text(
        parseInt($('p#earned' + response.projectid).text()) +
        parseInt(response.amount));
    });
  });
});
