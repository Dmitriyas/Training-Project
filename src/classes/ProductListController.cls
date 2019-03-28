public class ProductListController {
  
    public ApexPages.StandardSetController prodItems {

        get {
            if(prodItems == null) {
                prodItems = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, Name, Product_Description__c, Title__c, Unit_Price__c, Image_URL__c 
                                                                                     	  FROM Product_Table__c]));
            }
            return prodItems;
        }
        set;
    }
    public List<Product_Table__c> getRecords() {
        return (List<Product_Table__c>) prodItems.getRecords();  
        

    }
    

}