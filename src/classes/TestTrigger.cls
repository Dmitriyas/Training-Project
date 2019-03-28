@isTest(seeAllData=true)
public class TestTrigger {
     @isTest static void testTestInsertMethods() {
         List<Warehouse__c> warehouses = TestHelper.insertWarehouseData();  
         List<Product_Table__c> productTables = TestHelper.insertProductTableData();
        
        System.assert(warehouses.size() > 0);
        System.assert(productTables.size() > 0);
    }
    
    @isTest static void testWarehouseSave() {
        List<Warehouse__c> warehouses = TestHelper.insertWarehouseData();
        
        Test.startTest();
        Database.SaveResult[] result = Database.insert(warehouses, false);
        Test.stopTest();
        
        for(Database.SaveResult whs : result) {
            System.assert(whs.isSuccess());
        	System.assert(whs.getErrors().size() == 0);
        }
    }
    
    @isTest static void testProductTableSave() {
        List<Warehouse__c> warehouses = TestHelper.insertWarehouseData();
        insert warehouses;
        
        List<Product_Table__c> productTables = TestHelper.insertProductTableData();
        
        Test.startTest();
        Database.SaveResult[] result = Database.insert(productTables, false);
        Test.stopTest();
        
        for(Database.SaveResult tbs : result) {
            System.assert(tbs.isSuccess());
            System.assert(tbs.getErrors().size() == 0);
        }
    }
    
    
}