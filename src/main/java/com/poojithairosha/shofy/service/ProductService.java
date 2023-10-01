package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.model.product.ProductBrand;
import com.poojithairosha.shofy.model.product.ProductCategory;
import com.poojithairosha.shofy.model.product.ProductImages;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.inject.Inject;
import jakarta.persistence.criteria.Predicate;
import jakarta.ws.rs.core.Response;
import org.apache.commons.io.FilenameUtils;
import org.glassfish.jersey.media.multipart.BodyPart;
import org.glassfish.jersey.media.multipart.ContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.hibernate.Session;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;
import org.hibernate.query.criteria.JpaCriteriaQuery;
import org.hibernate.query.criteria.JpaRoot;

import java.io.InputStream;
import java.util.*;

public class ProductService {

    @Inject
    private FileUploadService fileUploadService;

    public List<Product> getProducts() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            List<Product> resultList = session.createQuery("from Product p where p.active = :active", Product.class).setParameter("active", true).getResultList();
            session.getTransaction().commit();
            return resultList;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Product fetching failed");
        }
    }

    public Map<String, Object> getProductsPagination(Integer page, String search, Long categoryId, Long minPrice, Long maxPrice) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            List<Predicate> predicatesList = new ArrayList<>();
            List<Predicate> countPredicatesList = new ArrayList<>();

            HibernateCriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            JpaCriteriaQuery<Product> query = criteriaBuilder.createQuery(Product.class);
            JpaRoot<Product> root = query.from(Product.class);

            JpaCriteriaQuery<Long> countQuery = criteriaBuilder.createQuery(Long.class);
            JpaRoot<Product> countRoot = countQuery.from(Product.class);



            if (!search.equals("all")) {
                predicatesList.add(criteriaBuilder.or(criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(root.get("description")), "%" + search.toLowerCase() + "%")));
                countPredicatesList.add(criteriaBuilder.or(criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("name")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("description")), "%" + search.toLowerCase() + "%")));
            }

            if (categoryId != null && categoryId != 0) {
                predicatesList.add(criteriaBuilder.equal(root.get("category").get("id"), categoryId));
                countPredicatesList.add(criteriaBuilder.equal(countRoot.get("category").get("id"), categoryId));
            }

            if (minPrice != null && minPrice != 0) {
                predicatesList.add(criteriaBuilder.greaterThanOrEqualTo(root.get("price"), minPrice));
                countPredicatesList.add(criteriaBuilder.greaterThanOrEqualTo(countRoot.get("price"), minPrice));
            }

            if (maxPrice != null && maxPrice != 0) {
                predicatesList.add(criteriaBuilder.lessThanOrEqualTo(root.get("price"), maxPrice));
                countPredicatesList.add(criteriaBuilder.lessThanOrEqualTo(countRoot.get("price"), maxPrice));
            }

            predicatesList.add(criteriaBuilder.equal(root.get("active"), true));
            countPredicatesList.add(criteriaBuilder.equal(countRoot.get("active"), true));

            int pageCount = 0;
            int limit = 6;
            Long count = null;

            if (predicatesList.isEmpty()) {
                countQuery.select(criteriaBuilder.count(countRoot));
                count = session.createQuery(countQuery).uniqueResult();
                pageCount = (int) Math.ceil((double) count / limit);
            } else {
                countQuery.select(criteriaBuilder.count(countRoot)).where(criteriaBuilder.and(countPredicatesList.toArray(new Predicate[0])));
                count = session.createQuery(countQuery).uniqueResult();
                pageCount = (int) Math.ceil((double) count / limit);
            }


            if (page > pageCount) {
                throw new CustomException(Response.Status.NOT_FOUND, "Page does not exist");
            }

            List<Product> resultList = null;

            if (predicatesList.isEmpty()) {
                resultList = session.createQuery(query.select(root))
                        .setFirstResult((page > 0 ? page - 1 : 0) * limit)
                        .setMaxResults(limit)
                        .getResultList();
            } else {
                query.select(root).where(criteriaBuilder.and(predicatesList.toArray(new Predicate[0])));
                resultList = session.createQuery(query)
                        .setFirstResult((page > 0 ? page - 1 : 0) * limit)
                        .setMaxResults(limit)
                        .getResultList();
            }
            session.getTransaction().commit();

            Map<String, Object> result = new HashMap<>();
            result.put("count", pageCount);
            result.put("products", resultList);
            result.put("search", search);
            result.put("page", page);

            return result;
        } catch (Exception e) {
            throw new CustomException(Response.Status.NOT_FOUND, e.getMessage());
        }
    }

    public Map<String, Object> getAllProductsPagination(Integer page, String search, Long categoryId, Long minPrice, Long maxPrice) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            List<Predicate> predicatesList = new ArrayList<>();
            List<Predicate> countPredicatesList = new ArrayList<>();

            HibernateCriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            JpaCriteriaQuery<Product> query = criteriaBuilder.createQuery(Product.class);
            JpaRoot<Product> root = query.from(Product.class);

            JpaCriteriaQuery<Long> countQuery = criteriaBuilder.createQuery(Long.class);
            JpaRoot<Product> countRoot = countQuery.from(Product.class);



            if (!search.equals("all")) {
                predicatesList.add(criteriaBuilder.or(criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(root.get("description")), "%" + search.toLowerCase() + "%")));
                countPredicatesList.add(criteriaBuilder.or(criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("name")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("description")), "%" + search.toLowerCase() + "%")));
            }

            if (categoryId != null && categoryId != 0) {
                predicatesList.add(criteriaBuilder.equal(root.get("category").get("id"), categoryId));
                countPredicatesList.add(criteriaBuilder.equal(countRoot.get("category").get("id"), categoryId));
            }

            if (minPrice != null && minPrice != 0) {
                predicatesList.add(criteriaBuilder.greaterThanOrEqualTo(root.get("price"), minPrice));
                countPredicatesList.add(criteriaBuilder.greaterThanOrEqualTo(countRoot.get("price"), minPrice));
            }

            if (maxPrice != null && maxPrice != 0) {
                predicatesList.add(criteriaBuilder.lessThanOrEqualTo(root.get("price"), maxPrice));
                countPredicatesList.add(criteriaBuilder.lessThanOrEqualTo(countRoot.get("price"), maxPrice));
            }

            int pageCount = 0;
            int limit = 6;
            Long count = null;

            if (predicatesList.isEmpty()) {
                countQuery.select(criteriaBuilder.count(countRoot));
                count = session.createQuery(countQuery).uniqueResult();
                pageCount = (int) Math.ceil((double) count / limit);
            } else {
                countQuery.select(criteriaBuilder.count(countRoot)).where(criteriaBuilder.and(countPredicatesList.toArray(new Predicate[0])));
                count = session.createQuery(countQuery).uniqueResult();
                pageCount = (int) Math.ceil((double) count / limit);
            }


            if (page > pageCount) {
                throw new CustomException(Response.Status.NOT_FOUND, "Page does not exist");
            }

            List<Product> resultList = null;

            if (predicatesList.isEmpty()) {
                resultList = session.createQuery(query.select(root))
                        .setFirstResult((page > 0 ? page - 1 : 0) * limit)
                        .setMaxResults(limit)
                        .getResultList();
            } else {
                query.select(root).where(criteriaBuilder.and(predicatesList.toArray(new Predicate[0])));
                resultList = session.createQuery(query)
                        .setFirstResult((page > 0 ? page - 1 : 0) * limit)
                        .setMaxResults(limit)
                        .getResultList();
            }
            session.getTransaction().commit();

            Map<String, Object> result = new HashMap<>();
            result.put("count", pageCount);
            result.put("products", resultList);
            result.put("search", search);
            result.put("page", page);

            return result;
        } catch (Exception e) {
            throw new CustomException(Response.Status.NOT_FOUND, e.getMessage());
        }
    }

    public String addProduct(String name, String description, Double price, Integer quantity, String brand, String category, FormDataBodyPart formDataBodyPart) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            session.beginTransaction();

            Product productResult = session.createQuery("from Product p where p.name = :name", Product.class).setParameter("name", name).uniqueResult();
            if (productResult != null) {
                throw new CustomException(Response.Status.BAD_REQUEST, "Product already exists");
            }

            ProductBrand productBrand = session.createQuery("from ProductBrand b where b.name = :name", ProductBrand.class).setParameter("name", brand).uniqueResult();
            if (productBrand == null) {
                productBrand = new ProductBrand(brand);
            }

            // Do the same for Category
            ProductCategory productCategory = session.createQuery("from ProductCategory c where c.name = :name", ProductCategory.class).setParameter("name", category).uniqueResult();
            if (productCategory == null) {
                productCategory = new ProductCategory(category);
            }

            Product product = new Product(name, description, price, quantity, productBrand, productCategory);

            List<ProductImages> productImages = new ArrayList<>();

            for (BodyPart part : formDataBodyPart.getParent().getBodyParts()) {
                ContentDisposition meta = part.getContentDisposition();
                InputStream is = part.getEntityAs(InputStream.class);

                System.out.println(meta.toString());
                System.out.println(is.toString());

                if(meta.toString().contains("name=\"images\"")) {
                    String ext = FilenameUtils.getExtension(meta.getFileName());
                    String fileName = System.currentTimeMillis() + "." + ext;
                    FileUploadService.FileItem uploaded = fileUploadService.upload("products", is, meta, fileName);
                    productImages.add(new ProductImages(uploaded.getUrl(), product));
                }
            }

            product.setImages(productImages);

            session.persist(product);
            session.getTransaction().commit();
            return "Product added successfully";
        } catch (CustomException e) {
            e.printStackTrace();
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Product getActiveProductById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            Product product = session.createQuery("from Product p where p.id = :id and p.active = :active", Product.class).setParameter("id", id).setParameter("active", true).uniqueResult();
            session.getTransaction().commit();
            return product;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Product getProductById(Long id) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(Product.class, id);
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Product fetching failed");
        }
    }

    public Integer getProductQty(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Product product = session.get(Product.class, id);
            return product.getQuantity();

        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Product fetching failed");
        }
    }

    public String editProduct(Long id, String name, String description, Double price, Integer quantity, String brand, String category, FormDataBodyPart formDataBodyPart, boolean active) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            Product productResult = session.find(Product.class, id);
            if (productResult == null) {
                throw new CustomException(Response.Status.BAD_REQUEST, "Product not found");
            }

            ProductBrand productBrand = session.createQuery("from ProductBrand b where b.name = :name", ProductBrand.class).setParameter("name", brand).uniqueResult();
            if (productBrand == null) {
                productBrand = new ProductBrand(brand);
            }

            // Do the same for Category
            ProductCategory productCategory = session.createQuery("from ProductCategory c where c.name = :name", ProductCategory.class).setParameter("name", category).uniqueResult();
            if (productCategory == null) {
                productCategory = new ProductCategory(category);
            }

            productResult.setName(name);
            productResult.setDescription(description);
            productResult.setPrice(price);
            productResult.setQuantity(quantity);
            productResult.setBrand(productBrand);
            productResult.setCategory(productCategory);
            productResult.setActive(active);

            boolean isImageChanged = false;

            List<FileUploadService.FileItem> uploadedImages = new ArrayList<>();

            if(formDataBodyPart == null) {
                session.merge(productResult);
                session.getTransaction().commit();
                return "Product updated successfully";
            }

            for (BodyPart part : formDataBodyPart.getParent().getBodyParts()) {
                ContentDisposition meta = part.getContentDisposition();
                InputStream is = part.getEntityAs(InputStream.class);

                if(meta.toString().contains("name=\"images\"")) {
                    isImageChanged = true;

                    String ext = FilenameUtils.getExtension(meta.getFileName());
                    String fileName = System.currentTimeMillis() + "." + ext;

                    FileUploadService.FileItem uploaded = fileUploadService.upload("products", is, meta, fileName);
                    uploadedImages.add(uploaded);
                }
            }

            if(isImageChanged) {

                productResult.getImages().clear();

                for(ProductImages image : productResult.getImages()) {
                    fileUploadService.deleteFile(image.getImageURL());
                }

                for(FileUploadService.FileItem uploaded : uploadedImages) {
                    productResult.getImages().add(new ProductImages(uploaded.getUrl(), productResult));
                }
            }

            session.update(productResult);

            session.getTransaction().commit();
            return "Product updated successfully";
        } catch (CustomException e) {
            e.printStackTrace();
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
