var init_friend_lookup;

init_friend_lookup = function () {


	$('#friend-lookup-form').on('ajax:before',function (event,data,staus) {
		show_spinner();
	});

	$('#friend-lookup-form').on('ajax:after',function (event,data,staus) {
		hide_spinner();
	});


	$('#friend-lookup-form').on('ajax:success',function (event,data,staus) {
		$('#friend-lookup' ).replaceWith(data);
		init_friend_lookup(); 
	});

	$('#friend-lookup-form').on('ajax:error',function (event,xhr,staus,error) {
		hide_spinner();
		$('friend-lookup-results').replaceWith(' ');
		$('friend-lookup-errors ').replaceWith('Not found');


	});


};





$(document).ready(function () {

	$('button[type="submit"]').prop('disabled', true);
     $('input[type="text"]').keyup(function() {
        if($(this).val() != '') {
           $('button[type="submit"]').prop('disabled', false);
        }else {
        $('button[type="submit"]').attr('disabled',true);
        }
     });
	init_friend_lookup();
})