$(function(){
      // instantiate the bloodhound suggestion engine
      var groups = new Bloodhound(
	  {
	      datumTokenizer: function (d) {
		  return Bloodhound.tokenizers.whitespace(d.value);
	      },
	      queryTokenizer: Bloodhound.tokenizers.whitespace,
	      remote: {
		  url: '/groups.json',
		  filter: function (groups) {
		      return $.map(groups.results, function (group) {
				       return {
					   value: group
				       };
				   });
		  }
	      }
	  });
      
      groups.initialize();
      
      $('#groupsearch').typeahead(null, 
				  {
				      name: 'groups',
				      displayKey: 'value',
				      source: groups.ttAdapter()
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