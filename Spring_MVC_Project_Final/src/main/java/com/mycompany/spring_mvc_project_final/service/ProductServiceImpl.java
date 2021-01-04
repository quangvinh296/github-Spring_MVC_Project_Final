/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.repository.ProductRepository;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

/**
 *
 * @author my
 */
@Service
@Transactional
public class ProductServiceImpl {

    @Autowired
    private ProductRepository productRepository;

    public void save(ProductEntity product) {
        productRepository.save(product);
    }

     public List<ProductEntity> getProducts() {
        return (List<ProductEntity>) productRepository.findAll();
    }
     
     public void saveAll(List<ProductEntity> products) {
        productRepository.saveAll(products);
    }
     
    public Page<ProductEntity> getProductsPage(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return this.productRepository.findAll(pageable);
    }

    public ProductEntity findProductById(int productId) {
        Optional<ProductEntity> product = productRepository.findById(productId);
        if (product.isPresent()) {
            return product.get();
        } else {
            return new ProductEntity();
        }
    }

    public int getTotalItem() {
        return (int) productRepository.count();
    }

    

    public Set<ProductEntity> searchProduct(String strSearch) {
        return productRepository.findByNameContaining(strSearch);

    }

     public Page<ProductEntity> listProductOrderPrice(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return this.productRepository.findAllByOrderByPriceDesc(pageable);
    }
     
//    public Set<ProductEntity> listProductOrderPrice() {
//        return productRepository.findAllByOrderByPriceDesc();
//    }

    public Page<ProductEntity> listProductOrderNew(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return productRepository.findAllByOrderByUpdateDateDesc(pageable);
    }

    public Page<ProductEntity> listProductOrderSelling(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return productRepository.findAllByOrderByQuantitySaleDesc(pageable);
    }

    public Set<ProductEntity> findListProductPriceByCategory(String nameCategory) {
        return productRepository.findByCategory_NameOrderByPriceDesc(nameCategory);
    }

    public Set<ProductEntity> findListProductNewByCategory(String nameCategory) {
        return productRepository.findByCategory_NameOrderByUpdateDateDesc(nameCategory);
    }

    public Set<ProductEntity> findListProductSellingByCategory(String nameCategory) {
        return productRepository.findByCategory_NameOrderByQuantitySaleDesc(nameCategory);
    }

    public Set<ProductEntity> findList8ProductNew() {
        return productRepository.findTop8ByOrderByUpdateDateDesc();
    }
}
