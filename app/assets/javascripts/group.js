$( function(){
       var groupId = window.location.href.split('/')[window.location.href.split('/').length-1];
       var url = '/';
       $("#sendpost").click(function(e) {
				url = $(this).attr('href');
				e.preventDefault();
				var loggedIn = false;
				dfd = new $.Deferred();
				FB.login(function(response) {
					     if (response.status == "connected" ) {
						 console.log("Saved new access Token" + response.authResponse.accessToken);
						 $.post("/facebook/refresh", 
							{"accessToken":response.authResponse.accessToken }
						       ).done(function(response) {
								  console.log("Response " + JSON.stringify(response));
							      }) ; 
					     }
					     dfd.resolve();
					   }, {scope:'publish_actions'} );
				dfd.done( function() {
				    window.location = url;
				});

				
			      }) ; 
       
       $("#new_group").formToWizard() ;
       //retrieve long description from contact_type
       var selectedItem = $("#contact_type :selected");
       $.getJSON("/contact_type/"+ selectedItem.val(), function(response) {

		     console.log("Respons is " + response);
		     
		     $("#entryLabel").html("Please enter a valid " + response);		     
		 });

       $("#contact_type").change( function () {
				      selectedType = $('#contact_type :selected').val() ;
				      $.ajax( "/contact_type/" + selectedType + ".json" )
					  .done(
					      function(data) {
						  console.log ("Data " + data);
						  $("#entryLabel").empty().append("Please enter a " + data);
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
