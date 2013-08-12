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
$('div.links div.link').live 'mouseenter click tap', -> 
	highlight this

normalize = (row) ->
	$(row).removeClass 'active'
	$(row).find('div.action').addClass 'hide'

#lists - add more links
$('a.action_add_urls').live "click tap",  ->
	for [1..3]
		$('div.more_urls').append("<input type='text' name='list[urls][]' class='eleven' placeholder='http://' />")

#list - action footer toggle
$('div.list').live 'mouseenter', ->
	$(this).find('.footer').removeClass 'invisiable'

$('div.list').live 'mouseleave', ->
	$(this).find('.footer').addClass 'invisiable'

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
	init_modal_with_form()
	$('dd.linktab a').click()

lists_new = ->
	init_modal_with_form()	
	$('dd.listtab a').click()

init_modal_with_form = ->
	$('#new_link').reveal()
	$("#link_tag_names").tagit({fieldName: 'link[tag_names]', singleField: true, singleFieldDelimiter: ' ', autocomplete: {delay: 0, minLength: 2, source: '/search/tag'}})
	$("#list_tag_names").tagit({fieldName: 'list[tag_names]', singleField: true, singleFieldDelimiter: ' ', autocomplete: {delay: 0, minLength: 2, source: '/search/tag'}})

loop_link = (current, targets, step) ->
	for link, index in targets
		if current == link && targets.length > (index+step) > -1
			window.parent.location.replace(targets[index+step])
			return false

fore_or_backward = (step) ->
	current_link = window.location.pathname
	current_link = '/home/links' if current_link == '/'
	console.log current_link
	targets1 = ['/home/links', '/home/lists']
	targets2 = ['/links', '/lists', '/favorites']
	loop_link(current_link, targets1, step)
	loop_link(current_link, targets2, step)

open_shortcuts = ->
	$('#help').reveal()

# keyboard shortcut bindings
Mousetrap.bind 'shift+/', (e) -> open_shortcuts()
Mousetrap.bind ']', (e) -> fore_or_backward(1)
Mousetrap.bind '[', (e) -> fore_or_backward(-1)
Mousetrap.bind 'n', (e) -> links_new()
Mousetrap.bind 'shift+n', (e) -> lists_new()
Mousetrap.bind 'u', (e) -> window.history.back()
Mousetrap.bind 'g h', (e) -> window.parent.location.replace('/')
Mousetrap.bind 'g t', (e) -> window.parent.location.replace('/tags')
Mousetrap.bind 'g l', (e) -> window.parent.location.replace('/links')
Mousetrap.bind 'g s', (e) -> window.parent.location.replace('/lists')
Mousetrap.bind 'g f',  (e) -> window.parent.location.replace('/favorites')
Mousetrap.bind 'j', (e) -> next(true) 
Mousetrap.bind 'k', (e) -> previous(true) 
Mousetrap.bind 'shift+j', (e) -> next(false) 
Mousetrap.bind 'shift+k', (e) -> previous(false) 
Mousetrap.bind 'g g', (e) -> first() 
Mousetrap.bind 'f', (e) -> $('div.links div.active').find('img.favorite').trigger('click')
Mousetrap.bind 'o', (e) -> window.open $('div.links div.active').find('a.ext').attr('href')
Mousetrap.bind 'e', (e) -> $('div.links div.active').find('a.edit').trigger('click')
Mousetrap.bind 'd d', (e) -> $('div.links div.active').find('a.delete').trigger('click')

