trigger CriaturaTrigger on Criatura__c (after insert, after update, after delete) { 
    
    // Identificar os bunkers;
    Map<id, Bunker__c> bunkersUpdateMap = new Map<id, Bunker__c>();
        
    for(Criatura__c cr: trigger.new)
    {
        Criatura__c nova = cr;
        Criatura__c antiga = trigger.oldMap.get(nova.id);
        if(nova.Bunker__c != antiga.bunker__c){
    		bunkersUpdateMap.put(cr.Bunker__c, new Bunker__c(id = cr.bunker__c));   
    	}      
    }
    for(Criatura__c cr: trigger.old)
    {
        if(trigger.isDelete && cr.Bunker__c != null)
            bunkersUpdateMap.put(cr.Bunker__c, new Bunker__c(id = cr.bunker__c));   
    }
    
    system.debug(bunkersUpdateMap);
    
    // totalizar todas as criaturas dos bunkes identificados;
    List<Bunker__c> bkList = [SELECT id, (Select id from Criaturas__r) FROM Bunker__c WHERE id in : bunkersUpdateMap.keySet()];
    for(Bunker__c bk: bkList) {
        bunkersUpdateMap.get(bk.id).Populacao__c = bk.Criaturas__r.size();
    }
    // atualizar os bunkes; 
  	update bunkersUpdateMap.values();
}