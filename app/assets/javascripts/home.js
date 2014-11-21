function popUpWindow(id, title, containerId) {
    var divObj = $('#' + id);
    divObj.dialog({'title':title});
    divObj.dialog({
		      // Hack to make the 'X' appear in JQuery Titlebar close 
		      // http://stackoverflow.com/questions/17367736/jquery-ui-dialog-missing-close-icon
		      open: function() {
			  $(this).closest(".ui-dialog")
			      .find(".ui-dialog-titlebar-close")
			      .removeClass("ui-dialog-titlebar-close")
			      .html("<span class='ui-button-icon-primary ui-icon ui-icon-closethick'></span>");
		      }});
    divObj.dialog('open');
}

$( function(){


       $( "#popups" ).scrollTop(0);
       $("#popups").dialog({autoOpen:false, 
			    width:"80%", 
			    height:500, 
			    draggable: false,
			    modal:true});

       $(".openwindow").each(function() {
			     $(this).click( function(e) {
				   var link = $(this).attr("href");
				   $( "#popups" ).load(link);
				   var title = $(this).attr("title");
       				   e.preventDefault();
       				   popUpWindow('popups', title, 'showterms') ;
       			       });
			     }) ; 
       
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




   });
