function setFbCookies(response) {
    $.cookie('fbs_862680253782909', response.authResponse.accessToken, {path: '/'}) ; 
}
$( function(){
       $("#fb_group").change(function(e) {
				 e.preventDefault();
				 if ( $(this).is(':checked') ) {
				     FB.login(function(response) {
						  FB.login(
						      function(response) {
							  if (response.authResponse) {
							      $('#connect').html('Connected! Hitting OmniAuth callback (GET /auth/facebook/callback)...');
							      // since we have cookies enabled, this request will allow omniauth to parse out the auth code from the signed request in the fbsr_XXX cookie
							      $.getJSON('/auth/facebook/callback', 
									{ signed_request : response.authResponse.signedRequest },
									function(json) {
									    alert("Test " + JSON.stringify(json));
									});
							  }
						      }, { 
							  scope: 'email,user_likes,publish_actions',
							  return_scopes: true
							 });
					      });
				 }
			     });
       $("#new_group").formToWizard() ;
       
       $("#entryLabel").text("Please enter a valid " + $("#contact_type :selected").text());
       $("#contact_type").change( function () {
				      selectedType = $('#contact_type :selected').val() ;
				      $.ajax( "/contact_type/" + selectedType + ".json" )
					  .done(
					      function(data) {
						  $("#entryLabel").text("Please enter a " + data);
					      })
					  .fail(function(jqXHR, textStatus) { console.log("Something messed up"+textStatus); } ) ; 
				  }) ; 

       $("#new_group").validate( 
	   {
	       rules: {
		   'group[name]': {
		       required:true,
		       maxlength:20
		   },
		   'group[sponsor_email]': {
		       email:true
		   }
	       },
	       messages: {
		   'group[name]': {
		       required:"You must name your group",
		       maxlength:"The name must be less than 20 characters."
		   },
		   'group[sponsor_email]': {
		       email: "The sponsor's email must be in the format of name@domain.com."
		   }
	       },
               onfocusout: function(element) { $(element).valid(); }
	   });  

}) ; 
