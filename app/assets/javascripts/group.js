$( function(){
       
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
}) ; 
