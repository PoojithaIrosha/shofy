import com.poojithairosha.shofy.email.EmailService;
import com.poojithairosha.shofy.model.product.*;
import com.poojithairosha.shofy.util.HibernateUtil;
import com.poojithairosha.shofy.util.ThreadPoolExecutorUtil;
import org.hibernate.Session;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Test {

    public static void main(String[] args) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

//            ProductCategory productCategory = session.find(ProductCategory.class, 3L);
//            ProductBrand productBrand = session.find(ProductBrand.class, 12L);
//            ProductColors productColors = session.find(ProductColors.class, 9L);
//
//            Product product = new Product("Oppo A96 5G Mobile Phone 123", "Oppo A96 5G Mobile Phone 128GB", 350000.00, 100, productBrand, productCategory);
//            product.setColors(List.of(productColors));
//            product.setImages(List.of(new ProductImages("/shofy/assets/img/product/product-sm-1.jpg", product)));
//
//            session.beginTransaction();
//            session.persist(product);
//            session.getTransaction().commit();
//            session.close();
            session.beginTransaction();
            session.createQuery("from Product", Product.class).list().forEach(System.out::println);
            session.getTransaction().commit();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
