$(document).on('turbolinks:load', function(){
  $(".categorybuttons").delegate('button','click',function(e){
    var category = $(this).attr('value');
    if(!category){
      category = 'all'
    }
    $.ajax({
      url: '/projects',
      method: 'get',
      dataType: 'json',
      data: {'category':category}
    }).done(function(response){
      var outdiv = $('<div>');
      response.forEach(function(project){
        var newdiv = $('<div>');
        var newspan = $('<span>');
        newspan.attr('id', project.id);
        newspan.text('Project Title: ' + project.title);
        newdiv.text(project.description);

        outdiv.append(newspan);
        outdiv.append(newdiv);
      });
      $('.projects').html(outdiv);
    });
  });

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
