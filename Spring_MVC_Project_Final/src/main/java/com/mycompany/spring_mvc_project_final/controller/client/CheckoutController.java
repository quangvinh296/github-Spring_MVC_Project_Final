/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.client;

import static com.mycompany.spring_mvc_project_final.controller.client.CartController.getOrderDetails;
import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.service.CategoryProImpl;
import com.mycompany.spring_mvc_project_final.service.OrderServiceImpl;
import com.mycompany.spring_mvc_project_final.service.UserServiceImpl;
import com.mycompany.spring_mvc_project_final.utils.UserUtils;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author my
 */
@Controller
public class CheckoutController {

    @Autowired
    private OrderServiceImpl orderService;

     @Autowired
    private CategoryProImpl categoryService;
     
      @Autowired
    private UserServiceImpl userService;
      
    @RequestMapping("/checkout")
    public String Checkout(Model model, HttpServletRequest request,
            @RequestParam("totalBill") double totalBill,
            @RequestParam(name = "discount", required = false) double discount,
            HttpSession session) {
        HashMap<Integer, OrderDetailEntity> orderDetails = getOrderDetails(request, session);

        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        OrderEntity order = new OrderEntity();
        if (user != null) {
            order.setUser(user);
            order.setEmail(user.getEmail());
            model.addAttribute("user", user);
            orderService.save(order);
        }
        if (user == null) {
            model.addAttribute("user", new UserEntity());
        }
        request.getSession().setAttribute("myorder", order);
        session.setAttribute("myCart", orderDetails);
        session.setAttribute("myCartTotal", totalPrice(orderDetails));
        session.setAttribute("myCartTotalQuantity", totalQuantityProduct(orderDetails));
        model.addAttribute("categories", categoryService.getCategory());
        model.addAttribute("totalBill", totalBill);
        model.addAttribute("discount", discount);
        return "checkout";
    }
    
       @ModelAttribute(name = "categories")
    public List<CategoryEntity> getCategories() {
        List<CategoryEntity> categories = categoryService.getCategory();
        if (CollectionUtils.isEmpty(categories)) {
            return new ArrayList<>();
        }
        return categories;
    }
    
       public double totalPrice(HashMap<Integer, OrderDetailEntity> orderDetails) {
        int count = 0;
        for (Map.Entry<Integer, OrderDetailEntity> list : orderDetails.entrySet()) {
            count += Math.round(list.getValue().getDiscount()) * list.getValue().getQuantity();
        }
        return count;
    }

    public double totalQuantityProduct(HashMap<Integer, OrderDetailEntity> orderDetails) {
        int sumquantity = 0;
        for (Map.Entry<Integer, OrderDetailEntity> list : orderDetails.entrySet()) {
            sumquantity += list.getValue().getQuantity();
        }
        return sumquantity;
    }
    
    

}
