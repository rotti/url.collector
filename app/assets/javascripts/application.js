// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require jquery.tokeninput

// bootstrap tooltip
$(function(){
  $("a[rel='tooltip']").tooltip();
})


// <%= javascript_include_tag "application" %>

//$(document).ready(function() 
//    { 
//        $("#myTable").tablesorter( {sortList: [[0,0], [1,0]]} ); 
//    } 
//);

//$(function () {  
//  $('#posts th a').live('click', function () {  
//    $.getScript(this.href);  
//    return false;  
//  });  
//})


function remove_fields(link) {
        $(link).prev("input[type=hidden]").val("1");
        $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
        var new_id = new Date().getTime();
        var regexp = new RegExp("new_" + association, "g");
        $(link).parent().before(content.replace(regexp, new_id));
}


    // tokeninput
    $(function () {  
      $('#post_tag_tokens').tokenInput('/tags.json', {
        //crossDomain: false,
        preventDuplicates: true,
        prePopulate: $(this).data('pre'),
        theme: 'facebook',
        hintText: 'search for tags ...',
        noResultsText: 'no tag found',
        searchingText: 'searching for tags ...'
      });  
    });  


$(function () {  
  // sorting and pagination
  $('#posts th a, #posts .pagination a').live('click', function () {  
    $.getScript(this.href);  
    return false;  
  });
  // search
  $('#posts_search input').keyup(function () {  
    $.get($('#posts_search').attr('action'),
    $('#posts_search').serialize(), null, 'script');  
  return false;  
});
})
