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
	Mousetrap.bind('g i', function(e) {
		window.parent.location.replace('/links');
	});
})
	