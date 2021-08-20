public class Zumbificacao {
	@invocableMethod (label='Transforma Zumbi')
    public static void zumbificar(List<id> ids){
        
        System.debug(ids);
        List<Criatura__c> criList = [SELECT id, Bunker__r.name, (SELECT id FROM RecursosCriatura__r) FROM Criatura__c WHERE id in : ids];
        List<RecursoCriatura__c> crDeleteList = new List<RecursoCriatura__c>();     
        for(Criatura__c cr : criList){
            String TipoZumbi = '';
            integer rand = Math.mod(Integer.valueOf(Math.random()*100000),100);
            if(rand < 50){
                TipoZumbi = 'Lerdo';
            }
            else if (rand < 80){
                TipoZumbi = 'Rápido';
            }
            else {
                TipoZumbi = 'Gordo';
            }
            cr.Tipo_do_Zumbi__c = tipoZumbi;
            if(cr.RecursosCriatura__r != null) 
            	crDeleteList.addAll (cr.RecursosCriatura__r);
        }
        update criList;
        update crDeleteList;
    }
}