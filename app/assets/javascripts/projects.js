$(document).on('turbolinks:load', function(){
  var responsefunction = function(response){
    var outdiv = $('<div>');
    var projectinfo = response.projectinfo;
    var pledgedinfo = response.pledgedinfo;
    projectinfo.forEach(function(project){
      var newdiv = $('<p>');
      var newa = $('<a>');
      newa.attr('href', 'http://localhost:3000/projects/' + project.id);
      newa.text(project.title);
      newdiv.text(project.description);

      outdiv.append(newa);
      if(pledgedinfo && pledgedinfo[project.id] == 'true'){
        var newp = $('<p>');
        newp.text('you backed this project');
        outdiv.append(newp);
      }
      outdiv.append(newdiv);
    });
    $('.projects').html(outdiv);
  }
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
    }).done(responsefunction);
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

  $("#searchbar").submit(function(event){
    event.preventDefault;
    if($("input:first").val()){
      $.ajax({
        url: '/projects',
        method: 'get',
        dataType: 'json',
        data: {'taginfo': $("input:first").val() }
      }).done(responsefunction);
    };
    return false;
  });

  $('#messagereview').submit(function(event){
    event.preventDefault;
    if($("#rd").val()){
      $.ajax({
        url: '/users/' + $('#rd').data("user") + '/messages',
        method: 'post',
        dataType: 'json',
        data: {'infomation': $("textarea:first").val(),
              'projectinfo' : $('#rd').attr("data-project")}
      }).done(function(response){
        console.log(response)
        var newp = $('<p>');
        newp.text(response.infomation);
        $('.message_box').append(newp);
      });
    };
    return false;
  });

  $('#messagereviewuser').submit(function(event){
    event.preventDefault;
    if($("#rdr").val()){
      $.ajax({
        url: '/users/' + $('#rdr').data("user") + '/messages',
        method: 'post',
        dataType: 'json',
        data: {'infomation': $("#rdr").val(),
              'userinfo' : $('#rdr').attr("data-user")}
      }).done(function(response){
        console.log('nice');
      });
    };
    return false;
  });
});
