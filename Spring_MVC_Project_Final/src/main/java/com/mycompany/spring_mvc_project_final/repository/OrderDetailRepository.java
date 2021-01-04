/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author my
 */@Repository
public interface OrderDetailRepository extends CrudRepository<OrderDetailEntity, Integer> {
List<OrderDetailEntity> findByOrder_Id(int id);

@Query("SELECT DISTINCT od FROM OrderDetailEntity od LEFT JOIN FETCH od.order o")
    List<OrderDetailEntity> findAllOrderDetail();
}
