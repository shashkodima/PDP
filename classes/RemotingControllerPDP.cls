public with sharing class RemotingControllerPDP {
    public String accountIdActionFunction{get;set;}
    public List<Opportunity> foundOpportunity{get;set;}

    public RemotingControllerPDP() { }

    @RemoteAction
    public static List<Opportunity> getOpportunitiesByAccountId(String accountId) {
        if (String.isBlank(accountId)) {
            return new List<Opportunity>();
        }
        List<Opportunity> foundOpportunities = [
                SELECT Name,
                        Amount
                FROM Opportunity
                WHERE AccountId = :accountId
        ];

        return foundOpportunities;
    }

    public void getOpportunitiesByAccountIdActionFunction() {
        if (String.isBlank(accountIdActionFunction)) {
            foundOpportunity = new List<Opportunity>();

            return;
        }

        foundOpportunity = [
                SELECT Name,
                        Amount
                FROM Opportunity
                WHERE AccountId = :accountIdActionFunction
        ];
    }
}