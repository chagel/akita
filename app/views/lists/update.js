$("#edit_list").trigger('reveal:close').remove();
$('div[data-list-id="<%=@list.id%>"]').replaceWith("<%= escape_javascript(render(partial: 'lists/list', locals: {list: @list})) %>");