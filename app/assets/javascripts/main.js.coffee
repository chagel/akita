$('a.invite').live 'click', ->
	$("#new_invite").reveal()

$('a.shortcuts').live 'click', ->
	open_shortcuts()	

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

# application menu items
$('li.link_new').live 'click', -> 
	links_new()

# highlight item
$('div.links div.link').live 'mouseenter', -> 
	highlight this

normalize = (row) ->
	$(row).removeClass 'active'
	$(row).find('div.action').addClass 'hide'

# shortcuts functions
highlight = (row) ->
	normalize @highlighted_row if @highlighted_row
	$(row).toggleClass 'active'
	$(row).find('div.action').removeClass 'hide'
	@highlighted_row = row

goto = (top, offset) ->
	$('html, body').animate(scrollTop: top + offset, 200)

next = (jump) ->
 	startRow = $('div.links').find('div.active')
 	if (row=$(startRow).next()).length
 		highlight row
 		goto row.offset().top, -10 if jump
 	else
 		first()
	
previous = (jump) ->
	startRow = $('div.links').find 'div.active'
	if (row = $(startRow).prev()).length
		highlight row
		goto row.offset().top, -10 if jump

first = ->
	if (row = $('div.links div.link:first-child')).length
		highlight row
		goto row.offset().top, -10

links_new = ->
	$("#new_link").reveal()
	# $('form #link_url').focus()

open_shortcuts = ->
	$('#help').reveal()

# keyboard shortcut bindings
Mousetrap.bind 'shift+/', (e) -> open_shortcuts()
Mousetrap.bind 'n', (e) -> links_new()
Mousetrap.bind 'u', (e) -> window.history.back()
Mousetrap.bind 'g h', (e) -> window.parent.location.replace('/')
Mousetrap.bind 'g t', (e) -> window.parent.location.replace('/tags')
Mousetrap.bind 'g l', (e) -> window.parent.location.replace('/links')
Mousetrap.bind 'g f',  (e) -> window.parent.location.replace('/favorites')
Mousetrap.bind 'j', (e) -> next(true) 
Mousetrap.bind 'k', (e) -> previous(true) 
Mousetrap.bind 'shift+j', (e) -> next(false) 
Mousetrap.bind 'shift+k', (e) -> previous(false) 
Mousetrap.bind 'g g', (e) -> first() 
Mousetrap.bind 'v', (e) -> $('div.links div.active').find('img.favorite').trigger('click')
Mousetrap.bind 'd d', (e) -> $('div.links div.active').find('a.delete').trigger('click')
Mousetrap.bind 'o', (e) -> window.open $('div.links div.active').find('a.ext').attr('href')
