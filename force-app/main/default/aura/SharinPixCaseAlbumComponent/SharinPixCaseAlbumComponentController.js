({
    doInit: function(component, event, helper) {
        component.set("v.noSelectedCase", true);
        
        var action = component.get('c.getCaseRecords');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
            	component.set('v.listCase', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    loadAlbum: function(component, event, helper) {
        component.set("v.noSelectedCase", false);
        component.set("v.showAlbum", true);
        
        var caseId = event.currentTarget.id;
        component.set('v.recordID', caseId);
        
        var action = component.get('c.getAlbumParams');
        action.setParams({ albumId : component.get('v.recordID') });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
            	component.set('v.albumURL', response.getReturnValue());       
            }
        });
        $A.enqueueAction(action);
  	},    
})