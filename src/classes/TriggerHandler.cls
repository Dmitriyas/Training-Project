public class TriggerHandler {
    public static void CreateNewProductTables(List<Product_Table__c> incomingProductTables) {
        
        List<Warehouse__c> warehouses = new List<Warehouse__c>([SELECT Id, Name, Period_Start__c, Period_End__c FROM Warehouse__c]);
        OrgConfigurations__c configuration = OrgConfigurations__c.getInstance();
        List<Product_Table__c> ProdTablesForWarehouseCreate = new List<Product_Table__c>();
        List<Warehouse__c> newWarehouses = new List<Warehouse__c>();

        for (Product_Table__c prodTable : incomingProductTables) {
            Boolean existWarehouse = false;
            for (Warehouse__c warehouse : Warehouses) {
                if (warehouse.Period_Start__c <= prodTable.Added_Date__c && warehouse.Period_End__c >= prodTable.Added_Date__c) {
                    existWarehouse = true;
                    prodTable.Warehouse__c = warehouse.Id;
                    break;
                }
            }
            
            if (!existWarehouse) {
                ProdTablesForWarehouseCreate.add(prodTable);
                String warName = 'Warehouse ' + prodTable.Added_Date__c + ' ' + prodTable.Added_Date__c.addDays((Integer)configuration.Period_Term__c);
                Date warPeriodEnd = prodTable.Added_Date__c.addDays((Integer)configuration.Period_Term__c);
                Warehouse__c newWarehouse = new Warehouse__c(Name = warName, Period_Start__c = prodTable.Added_Date__c, Period_End__c = warPeriodEnd);
                newWarehouses.add(newWarehouse);
            }
        }
        insert newWarehouses;
        
        for (Product_Table__c prodTable : ProdTablesForWarehouseCreate) {
            for (Warehouse__c warehouse : newWarehouses) {
                if (prodTable.Added_Date__c >= warehouse.Period_Start__c && prodTable.Added_Date__c < warehouse.Period_End__c) {
                    prodTable.Warehouse__c = warehouse.Id;
                    break;
                }
            }
        }
    }
}