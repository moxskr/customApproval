public inherited sharing class ApprovalProcessStep {
    
    private Id id;
    private Id userId;
    private String status;
    private Integer order;

    public Id getId() {
        return this.id;
    }

    public void setId(Id id) {
        this.id = id;
    }

    public Id getUserId() {
        return this.userId;
    }

    public void setUserId(Id userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getOrder() {
        return this.order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

}