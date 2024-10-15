public inherited sharing class ApprovalProcessAction {
    
    private Id id;
    private String type;
    private String actionJSON;
    private Integer order;

    public Id getId() {
        return this.id;
    }

    public void setId(Id id) {
        this.id = id;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getActionJSON() {
        return this.actionJSON;
    }

    public void setActionJSON(String actionJSON) {
        this.actionJSON = actionJSON;
    }

    public Integer getOrder() {
        return this.order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

}