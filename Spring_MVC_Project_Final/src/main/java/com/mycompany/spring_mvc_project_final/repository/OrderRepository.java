/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import java.util.List;
import java.util.Set;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 *
 * @author my
 */
@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Integer> {

    @Query(value = "select max(id) from order_bill", nativeQuery = true)
    String getMaxId();
    
    Set<OrderEntity> findByUser_IdOrderByDateOrderDesc(int id);
    
    @Query("SELECT DISTINCT o FROM OrderEntity o LEFT JOIN FETCH o.orderDetail od")
    List<OrderEntity> findAllOrder();
    
    OrderEntity findByOrderUId(String orderUid);
    
}
