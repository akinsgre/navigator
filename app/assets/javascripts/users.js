$( function() {
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