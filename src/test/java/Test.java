import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.model.product.ProductBrand;
import com.poojithairosha.shofy.model.product.ProductCategory;
import com.poojithairosha.shofy.model.product.ProductImages;
import com.poojithairosha.shofy.util.HibernateUtil;
import org.hibernate.Session;

import java.util.ArrayList;
import java.util.List;

public class Test {
    public static Session session = HibernateUtil.getSessionFactory().openSession();

    public static void main(String[] args) {

        try {
            session.getTransaction().begin();

//            Product p = new Product("name", "description", 100.0, 10, new ProductBrand("Samsung"), new ProductCategory("Mobiles"));
//            p.setImages(List.of(new ProductImages("imageURL", p)));

            Product p = session.find(Product.class, 7L);

            p.getImages().clear();

//            p.getImages().add(new ProductImages("imageURL123", p));

            session.merge(p);


//            session.remove(session.find(ProductCategory.class, 4L));

            session.getTransaction().commit();
            session.close();
        } catch (Exception e) {
            session.getTransaction().rollback();
            e.printStackTrace();
        }

    }
}
