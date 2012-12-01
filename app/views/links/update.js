$("#edit_link").trigger('reveal:close').remove();
$('div[data-link-id="<%=@link.id%>"]').replaceWith("<%= escape_javascript(render(partial: 'links/link', locals: {link: @link})) %>");
$('div[data-link-id="<%=@link.id%>"]').trigger('click');