$( function(){
       var groupId = window.location.href.split('/')[window.location.href.split('/').length-1];
       var url = '/';

				
       $("#new_group").formToWizard() ;

       //retrieve long description from contact_type
       if ($('#contact_type').length) {
	   var selectedItem = $("#contact_type :selected");
	   $.getJSON("/contact_type/"+ selectedItem.val(), function(response) {
			 console.log("Response is " + response);
			 $("#entryLabel").html("Please enter a valid " + response);		     
		     });
       }
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
