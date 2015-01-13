$( function() {

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
					title: 'Select contactss',
					placement: 'right',
					display: function(value, sourceData) {
					    console.log("Value is " + value ) ; 
					    console.log("Source is " + JSON.stringify(sourceData) ) ; 
					    var $el = $('.list-group'),
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