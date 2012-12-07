$("#edit_list").remove();
$('body').append("<%= escape_javascript(render(:partial => 'lists/edit')) %>");
$("#edit_list").reveal();