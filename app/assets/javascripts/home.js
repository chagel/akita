function next(jump){
	var startRow = $('div.links').find('div.active');
	if(startRow.length == 0)
		startRow = $('div.links div:first-child');
	var the = $(startRow).next();
	if(the.length > 0) {
		the.trigger('click');
		if(jump){
			$('html, body').animate({
			  scrollTop: the.offset().top - 10
			}, 200);	
		}
	}
}

function previous(jump){
	var startRow = $('div.links').find('div.active');
	var the = $(startRow).prev();
	if(the.length > 0){
		the.trigger('click');
		if(jump){
			$('html, body').animate({
			  scrollTop: the.offset().top - 10
			}, 200);
		}
	}
}

function first(){
	var first = $('div.links div:first-child');	
	if(first.length > 0){
		$(first).trigger('click');
		$('html, body').animate({
		  scrollTop: first.offset().top - 10
		}, 200);	
	}
}

$(function(){
	Mousetrap.bind('shift+/', function(e) {
		$('#help').reveal();
	});
	Mousetrap.bind('n', function(e) {
		window.parent.location.replace('/links/new');
	});
	Mousetrap.bind('u', function(e) {
		window.history.back();
	});
	Mousetrap.bind('g h', function(e) {
		window.parent.location.replace('/');
	});
	Mousetrap.bind('g l', function(e) {
		window.parent.location.replace('/links');
	});
	Mousetrap.bind('j', function(e) {
		next(true);
	});
	Mousetrap.bind('k', function(e) {
		previous(true);
	});
	Mousetrap.bind('shift+j', function(e) {
		next(false);
	});
	Mousetrap.bind('shift+k', function(e) {
		previous(false);
	});
	Mousetrap.bind('g g', function(e) {
		first();
	});
})
	