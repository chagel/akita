$("#edit_link").remove();
$('body').append("<%= escape_javascript(render(:partial => 'links/edit')) %>");
$("#edit_link").reveal();
