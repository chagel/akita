$('form #link_url').focus()

# link form auto fetching title
$('form #link_url').live 'change', ->
	$.ajax(type: "POST", 
	url: "/urls.json", 
	data: { id: $(this).val()}, 
	beforeSend: (xhr, settings) -> $('#url_loading').toggleClass 'hide'
	).done((result) ->
		$('#link_title').val(result.title) if result.title?
		$('#url_loading').toggleClass 'hide')

# favorite actions
$('div.action a').live 'ajax:success', (event, data, status, xhr) ->
	$(this).find('img.favorite').attr('class', '').addClass('favorite ' + data.action)

# highlight item
$('div.links div.link').live 'click', -> 
		$('div.links div.active').removeClass 'active'
		$('div.links div.action').addClass 'hide'
		$(this).toggleClass 'active'
		$(this).find('div.action').removeClass 'hide'

# shortcuts functions
goto = (top, offset) ->
	$('html, body').animate(scrollTop: top + offset, 200)

next = (jump) ->
 	startRow = $('div.links').find('div.active') || $('div.links div:first-child')
 	if (the=$(startRow).next()).length
 		the.trigger 'click'
 		goto the.offset().top, -10 if jump
	
previous = (jump) ->
	startRow = $('div.links').find 'div.active'
	if (the = $(startRow).prev()).length
		the.trigger 'click'
		goto the.offset().top, -10 if jump

first = ->
	if (the = $('div.links div:first-child')).length
		$(the).trigger('click');
		goto the.offset().top, -10

# keyboard shortcut bindings
Mousetrap.bind 'shift+/', (e) -> $('#help').reveal()
Mousetrap.bind 'n', (e) -> window.parent.location.replace('/links/new')
Mousetrap.bind 'u', (e) -> window.history.back()
Mousetrap.bind 'g h', (e) -> window.parent.location.replace('/')
Mousetrap.bind 'g l', (e) -> window.parent.location.replace('/links')
Mousetrap.bind 'g f',  (e) -> window.parent.location.replace('/favorites')
Mousetrap.bind 'j', (e) -> next(true) 
Mousetrap.bind 'k', (e) -> previous(true) 
Mousetrap.bind 'shift+j', (e) -> next(false) 
Mousetrap.bind 'shift+k', (e) -> previous(false) 
Mousetrap.bind 'g g', (e) -> first() 
Mousetrap.bind 'v', (e) -> $('div.links div.active').find('img.favorite').trigger('click')
