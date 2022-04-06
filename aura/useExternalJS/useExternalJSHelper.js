({
    showToast : function(title, msh, type) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title" :title,
            "message" :msh,
            "type" :type
        });
        toastEvent.fire();
    }
});