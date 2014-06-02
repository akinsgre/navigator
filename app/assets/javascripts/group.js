
$( function(){
       
       $("#new_group").formToWizard({ submitButton: 'SaveAccount' }) ;
       
       $("#entryLabel").text("Please enter a valid " + $("#contact_type :selected").text());
       $("#contact_type").change( function () {
						 selectedText = $('#contact_type :selected').text() ;
						 $("#entryLabel").text("Please enter a valid " + selectedText);
					     });
   });