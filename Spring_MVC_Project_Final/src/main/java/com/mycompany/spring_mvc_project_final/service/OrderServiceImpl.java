/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.repository.OrderPDFRepository;
import com.mycompany.spring_mvc_project_final.repository.OrderRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

/**
 *
 * @author my
 */
@Service
@Transactional
public class OrderServiceImpl {

    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private OrderPDFRepository orderPDFRepository;

    public List<OrderEntity> getOrders() {
        return (List<OrderEntity>) orderRepository.findAll();
    }

    public void save(OrderEntity order) {

        orderRepository.save(order);
    }

     public List<OrderEntity> getAllOrders() {
        List<OrderEntity> orderdetails = (List<OrderEntity>) orderRepository.findAllOrder();
        if (!CollectionUtils.isEmpty(orderdetails)) {
            return orderdetails;
        }
        return new ArrayList<>();
    }
     
      public List<OrderEntity> listAll() {
        return orderPDFRepository.findAll(Sort.by("email").ascending());
    }

 
    
    public OrderEntity findOrderById(int Id) {
        Optional<OrderEntity> order = orderRepository.findById(Id);
        if (order.isPresent()) {
            return order.get();
        } else {
            return new OrderEntity();
        }
    }

    public String getMaxOrderId() {
        return orderRepository.getMaxId();
    }
    
    public OrderEntity findByOrderUid(String orderUID){
        return orderRepository.findByOrderUId(orderUID);
    }

    public Set<OrderEntity> findByUserId(int userId){
        return orderRepository.findByUser_IdOrderByDateOrderDesc(userId);
    }
   
}
