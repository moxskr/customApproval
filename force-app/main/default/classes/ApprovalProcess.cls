public inherited sharing class ApprovalProcess {
    
    private Id id;
    private Id recordId;
    private Id approvalProcessTemplateId;
    private String status;

    public Id getId() {
        return this.id;
    }

    public void setId(Id id) {
        this.id = id;
    }

    public Id getRecordId() {
        return this.recordId;
    }

    public void setRecordId(Id recordId) {
        this.recordId = recordId;
    }

    public Id getApprovalProcessTemplateId() {
        return this.approvalProcessTemplateId;
    }

    public void setApprovalProcessTemplateId(Id approvalProcessTemplateId) {
        this.approvalProcessTemplateId = approvalProcessTemplateId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }

}