
$( function(){
       
       $("#new_group").formToWizard() ;
       
       
       $("#entryLabel").text("Please enter a valid " + $("#contact_type :selected").text());
       $("#contact_type").change( function () {
						 selectedText = $('#contact_type :selected').text() ;
						 $("#entryLabel").text("Please enter a valid " + selectedText);
					     });
   });
