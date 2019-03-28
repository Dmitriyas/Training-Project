public class PurchaseAndRegistrationOrder {
   
    public Product_Table__c productTable {get; set;}
    public Contact contCreate {get; set;}

    public string PageId {get; set;}
    
    public string UnitCount {get; set;}
    public string Email {get; set;}
    public string FirstName {get; set;}
    public string LastName {get; set;}
   
    public Id Contact_Id;
    
    public Database.SaveResult updateProductTable;
    public Database.SaveResult updateOrInsertNewContact;    
    public Database.SaveResult saveOrderTable;
     
   
    // get all the fields of Product_Table__c and get id each of product
    public PurchaseAndRegistrationOrder(){
        PageId = ApexPages.currentPage().getParameters().get('id');
        productTable = [SELECT Id, Name, Product_Description__c, Title__c, Unit_Price__c, Image_URL__c, Units_Available__c, Added_Date__c  
                        FROM Product_Table__c 
                        WHERE Id =: PageId];
 
    }
    
    public Product_Table__c getProductTable() {        
        return productTable;
    }
         
  

     //method by buy to selected product
     public void buyItem() {
         if(Integer.valueOf(productTable.Units_Available__c) == 0) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Sorry! There is no this product in stock.' ));
        }
          
        if(Integer.valueOf(UnitCount) > 0 ) {
            //set save point in database
            Savepoint savePoint = Database.setSavepoint();
        	//get list of contacts by email 
            List<Contact> contact = [SELECT Id, FirstName, LastName, Email 
                                     FROM Contact 
                                     WHERE Email =: Email 
                                     LIMIT 1];
        
            if(contact.size() > 0) {
                contCreate = contact[0];
                contCreate.FirstName = FirstName;
                contCreate.LastName = LastName;
                updateOrInsertNewContact = Database.update(contCreate, true);
                Contact_Id = contCreate.Id;
        
            } else {
                Contact newContact = new Contact(FirstName = FirstName, LastName = LastName, Email = Email);
                updateOrInsertNewContact = Database.insert(newContact, true);            
                Contact_Id = newContact.Id;
            
                 
            }
            
            //if the new contact is inserted then create new Order record
            if(updateOrInsertNewContact.isSuccess()) {
                Order_Table__c newOrder = new Order_Table__c(Name = 'Order [ ' + productTable.Name + ', ' + UnitCount + ' quantity ]', 
                                                             Product__c = productTable.Id, 
                                                             Units__c = Integer.valueOf(UnitCount), 
                                                             Order_Amount__c = Integer.valueOf(UnitCount) * Integer.valueOf(productTable.Unit_Price__c), 
                                                             Contact__c = Contact_Id);
                
            saveOrderTable = Database.insert(newOrder, true);
 
            }
            
            //if the new Order is inserted then create variable which displays residue of Units_Available__c  
            if(saveOrderTable.isSuccess()) {
                Integer purchaseQuantity = Integer.valueOf(productTable.Units_Available__c) - Integer.valueOf(UnitCount);
                //if residue of Units_Available__c >= 0 then update Product_Table__c
                if(purchaseQuantity >= 0) {
                    productTable.Units_Available__c = purchaseQuantity;
                    updateProductTable = Database.update(productTable, true);
                                    
                 //if order is success then displays message about success or not
                 if(updateProductTable.isSuccess()) {                         
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Purchase is successfully completed!')); 
                    }
                  
                } else { 
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You can`t buy products more then it`s available!' ));
                    
                    // rollBack all database operations
                    Database.rollback(savePoint);


                    
                }
            }              
        }   
    }
}