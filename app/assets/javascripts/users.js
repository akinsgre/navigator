$( function(){

       // $('#groupsearch').typeahead(null, 
       // 				      {
       // 					  name: 'groups',
       // 					  displayKey: 'value',
       // 					  source: groups.ttAdapter()
       // 				      });
       //  $('#groupsearch').bind('typeahead:selected', function(obj, datum, name) {      
       // 				     window.location = "/groups/"+datum.id + "/add_contact" ;
       
       // 				 });


       $("#emailForm").validate(
       	  {
       	      rules: {
       		  email: {
       		      required: true,
       		      email: true
       		  }
       	      },
       	      messages: {
       		  email: "Please enter a valid email address"
       	      }
       	  }) ; 

   });
