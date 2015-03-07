$( function(){
       var groupId = window.location.href.split('/')[window.location.href.split('/').length-1];
       var url = '/';
				
       $("#new_group").formToWizard() ;
       $("#add_contact").on("click", function() {
				$("#add_contact").hide();
				$("#new_contact").show();
				$("#new_contact_save").show();
			    });
       $("#new_contact_save").on("click", function() {
				     //post email to groups.add_admin

				     var billy = { "email" : $("#new_contact").val() };
				     console.log("This is being submitted " + JSON.stringify(billy));

				     $.post('/groups/'+groupId+'/add_admin', billy)
					 .done( function(data) {
						//display response in a status popup.
						$("#admin_label").after("<p class=\"error\">"+data.message+"</p>"); 
//						alert(data.message);
					    });

				 });


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
