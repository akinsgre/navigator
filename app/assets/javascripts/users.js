var createMessageChunks = function() {
    $("#message-render").empty();
    var maxMessageLength = 160;
    var groupId = window.location.pathname.split('/')[1] ; 
    console.log("GroupId = " + groupId);
    var groupMessage = $("#groupmessage").text()+": ";
    var adMessage = "--" + $("#admessage").text() + " Respond with STOP"+groupId+" to stop receiving messages";
    var message = groupMessage + "" + $("#message_message").val() + "" + adMessage ; 
    var messageResult = [];
    var i= 0;
    while (message.length > 1) {
	messageResult[i] = message.substring(0,maxMessageLength);
	message = message.substring(maxMessageLength);
	i++ ; 
    }

    for (var i=0; i<messageResult.length; i++) {

	if($("#message_text_" + i).length == 0) {
	    //it doesn't exist
	    $("#message-render").append("<p class=\"message_text\" id=\"message_text_"+ i +"\"></p>");
	}
	$("#message_text_"+i).html(messageResult[i]+"<br/>");
    }
} ; 

$( function() {
       createMessageChunks();
       $('#message_message').keyup(createMessageChunks);

       $('#contactsubmit').editable({
					type: 'checklist',    
					source: function() { 

					    var results = [{0:'No contacts Found'}];
					    $.ajax({
						       url: '/contacts/search?entry='+$("#contactsearch").val(),
						       dataType: 'json',
						       async: false
						   }).always(function(data){ 

								 if ($.isEmptyObject(data.responseText)) {
								     console.log("responseText is empty");
								 }
								 else {
								     results = data.responseText ; 								     
								 }

							     } );
					    return results;
					},
					url: '/contacts/assign',     
					pk: 1,    
					title: 'Select contacts',
					placement: 'right',
					display: function(value, sourceData, response) {
					    checked = $.fn.editableutils.itemsByValue(value, sourceData);



					    var $el = $('#list'),
					    checked, html = '';
					    if(!value) {
						return;
					    }            
					    
					    checked = $.grep(sourceData, function(o){
								 return $.grep(value, function(v){ 
										   return v == o.value; 
									       }).length;
							     });

					    $.each(checked, function(i, v) { 
						       html+= '<li class="list-group-item">'+$.fn.editableutils.escape(v.text)+'</li>';
						   });
					    if(html) html = '<ul class="list-group">'+html+'</ul>';
					    $el.html(html);
					}
				    });

       $("#new_user").validate( 
	   {
	       rules: {
		   'user[email]': {
		       required:true,
		       email:true
		   },
		   'user[password]': {
		       required: true,
		       minlength: 6
		   },
		   'user[password_confirmation]': {
		       required: true,
		       minlength: 6,
		       equalTo: "#user_password"
		   }
	       },
	       messages: {
		   'user[email]': {
		       required: "We need your email address to contact you",
		       email: "Your email address must be in the format of name@domain.com"
		   },
		   'user[password]': {
		       required: "What is your password?",
		       minlength: "Your password must contain more than {0} characters"
		   },
		   'user[password_confirmation]': {
		       required: "You must confirm your password",
		       minlength: "Your password must contain more than {0} characters",
		       equalTo: "Your Passwords Must Match" 
		   }
	       }
	   });  
   });