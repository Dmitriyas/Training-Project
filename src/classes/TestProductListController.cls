@isTest
public class TestProductListController {
    @isTest static void testGetProductList(){
        ProductListController controller = new ProductListController();
        System.assertEquals(0, controller.getRecords().size());
    }
}