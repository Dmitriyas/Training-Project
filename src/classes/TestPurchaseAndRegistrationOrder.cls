@isTest(seeAllData=true)
public class TestPurchaseAndRegistrationOrder { 
    @isTest static void getProductTableTest(){
        
       Product_Table__c productTable = new Product_Table__c(Name='test', Product_Description__c='test', Unit_Price__c=10, 
                                         Units_Available__c=1, Added_Date__c = Date.valueOf('2019-03-28'));
        insert productTable;
        PageReference pRefSetted = Page.DetailViewProductVisualForce;
        pRefSetted.getParameters().put('id', productTable.Id); 
        Test.setCurrentPage(pRefSetted);
        
        PurchaseAndRegistrationOrder controller = new PurchaseAndRegistrationOrder();
         
        System.assertEquals(controller.PageId, productTable.Id);
         
        Product_Table__c pt = controller.getProductTable();
        System.assertEquals(productTable, pt);
  
    }
    
    @isTest static void testBuy_Success() {
        Product_Table__c productTable = new Product_Table__c(Name='test', Product_Description__c='test', Unit_Price__c=10, 
                         Units_Available__c=1, Added_Date__c = Date.valueOf('2019-03-28'));
        insert productTable;    
        PageReference pRefSetted = Page.DetailViewProductVisualForce;
        pRefSetted.getParameters().put('id', productTable.Id); 
        Test.setCurrentPage(pRefSetted); 
        
        PurchaseAndRegistrationOrder controller = new PurchaseAndRegistrationOrder();
        controller.Email = 'dimas@gmail.com';
        controller.FirstName = 'Dima';
        controller.LastName = 'Chekhouski';
        controller.UnitCount = '15';
        Contact newtestContact = new Contact(FirstName=controller.FirstName, LastName=controller.LastName, Email=controller.Email);
        insert newtestContact;
        
        Test.startTest();
        controller.buyItem();
        Test.stopTest();
        
        Contact testContact = [select Id, FirstName, LastName, Email from Contact where Email =: controller.Email LIMIT 1];
        System.assertNotEquals(null, testContact);
        System.assertEquals(controller.Contact_Id, testContact.Id);
        System.assert(controller.updateOrInsertNewContact.isSuccess());

}
    
}