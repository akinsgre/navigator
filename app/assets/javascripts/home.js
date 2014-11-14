$( function(){

       // instantiate the bloodhound suggestion engine
       var groups = new Bloodhound(
	   {
	       datumTokenizer: function (d) {  return Bloodhound.tokenizers.obj.whitespace('value');  },
	       queryTokenizer: Bloodhound.tokenizers.whitespace,
	       remote: {
		   url: '/groups.json?search=%QUERY',
		   filter: function (groups) {
		       console.log('### test ' + JSON.stringify(groups) );
		       return $.map(groups.results, function (group) {
		   			return {
		   			    value: group.name,
		   			    id: group.id
		   			};
		   		    });
		   }
	       }
	   });
       
       var initPromise = groups.initialize();
       initPromise.done(function() {}).fail(function() { console.log('Fail');});
       
       $('#groupsearch').typeahead({}, 
       				      {
       					  source: groups.ttAdapter()
       				      });
        $('#groupsearch').bind('typeahead:selected', function(obj, datum, name) {   
				   console.log("#### Datam avlue " + datum.value);
				   console.log("#### Datam id " + datum.id);
				   console.log("#### name " + name);
       				     window.location = "/groups/"+datum.id + "/contacts/new" ;
       
       				 });


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
