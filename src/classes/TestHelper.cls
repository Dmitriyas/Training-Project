@isTest
public class TestHelper {
    @isTest public static List<Warehouse__c> insertWarehouseData(){
        List<Warehouse__c> whList = new List<Warehouse__c> { 
        	new Warehouse__c(Name = 'Stock 1', Period_Start__c = date.parse('09/19/2017'), 
                          					   	   Period_End__c = date.parse('02/16/2018')),
   			new Warehouse__c(Name = 'Stock 2', Period_Start__c = date.parse('03/29/2018'), 
                          					   	   Period_End__c = date.parse('09/13/2018')),
    		new Warehouse__c(Name = 'Stock 3', Period_Start__c = date.parse('05/08/2018'), 
                          					   	   Period_End__c = date.parse('01/01/2019'))};
 		return whList;   
    }
    
    @isTest public static List<Product_Table__c> insertProductTableData() {        
		List<Product_Table__c> prodtableList = new List<Product_Table__c> {
    	new Product_Table__c(Name = 'Product Table 1', Added_Date__c = date.parse('01/09/2018'), Unit_Price__c = 100.13),  //must to insert in Stock 1      
    	new Product_Table__c(Name = 'Product Table 2', Added_Date__c = date.parse('08/10/2018'), Unit_Price__c = 200.23), // must to insert in Stock 2      
        new Product_Table__c(Name = 'Product Table 3', Added_Date__c = date.parse('05/10/2018'), Unit_Price__c = 300.33), // must to insert in Stock 3
    	new Product_Table__c(Name = 'Product Table 4', Added_Date__c = date.parse('04/01/2019'), Unit_Price__c = 400.44), // must be create new Warehouse       
    	new Product_Table__c(Name = 'Product Table 5', Added_Date__c = date.parse('01/17/2019'), Unit_Price__c = 500.55), // must be create new Warehouse
        new Product_Table__c(Name = 'Product Table 6', Added_Date__c = date.parse('05/02/2019'), Unit_Price__c = 600.36)};// must be create new Warehouse 
            
 		return prodtableList;
    }    
  }