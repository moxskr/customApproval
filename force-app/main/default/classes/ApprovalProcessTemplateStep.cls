public inherited sharing class ApprovalProcessTemplateStep {
    private Id id;
    private Id memberId;
    private String type;
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

    public Id getMemberId() {
        return this.memberId;
    }

    public void setMemberId(Id memberId) {
        this.memberId = memberId;
    }

    public Integer getOrder() {
        return this.order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }
}