$( function() {
       $("#new_user").validate( 
	   {
	       rules: {
		   'user[email]': {
		       required:true,
		       email:true
		   }
	       },
	       messages: {
		   'user[email]': {
		       required: "We need your email address to contact you",
		       email: "Your email address must be in the format of name@domain.com"
		   }
	       }
	   });  
   });