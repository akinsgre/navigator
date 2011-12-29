// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(function() {
	jQuery('#table_id').dataTable({
		"bProcessing" : true,
		    "sAjaxSource" : '/groups.json'
	    });
 jQuery('a[id^="addContactBtn"]').click( function() { 
	var group_id = jQuery(this).attr('id').replace(/addContactBtn/g, "");

	jQuery('#addContactPopup').dialog({ 
	    autoOpen : false, 
	    width: '400px', 
	    title: 'Subscribe to this Group' 
	}) ;
	jQuery('#addContactPopup').load('/groups/'+ group_id + '/join');
	var notice = jQuery('#flash_notice') ; 
	notice.fadeOut('slow');
	jQuery('#addContactPopup').dialog('open');
    });

    });