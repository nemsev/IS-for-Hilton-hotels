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
//= require_tree .

$(document).ready(function(){
	
  $('.closed_req').click(function(){
	var id = $(this).attr('id');
	$(this).hide();
    $.getJSON('/taxirequests.json', {id:id}, function(data){
	  var items = [];
	  $.each(data, function(i,obj){
		items.push('<li><ul class="closed_taxi_request">');
	    $.each(obj, function(key,val){
		  items.push('<li>'+val+'</li>');
	    });
	    items.push('</ul></li>');
	  });
      $('.list_for_day'+id).append(items.join(''));
    });
  });

});