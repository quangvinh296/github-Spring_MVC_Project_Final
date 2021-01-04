/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.client;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.enums.OrderStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryProImpl;
import com.mycompany.spring_mvc_project_final.service.CommentServiceImpl;
import com.mycompany.spring_mvc_project_final.service.CreditCardServiceImpl;
import com.mycompany.spring_mvc_project_final.service.FavoriteProServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ImageServiceImpl;
import com.mycompany.spring_mvc_project_final.service.OrderDetailServiceImpl;
import com.mycompany.spring_mvc_project_final.service.OrderServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PaymentServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ProductServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PromotionAdService;
import com.mycompany.spring_mvc_project_final.service.PromotionServiceImpl;
import com.mycompany.spring_mvc_project_final.service.UserRoleServiceImpl;
import com.mycompany.spring_mvc_project_final.service.UserServiceImpl;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    @Autowired
    private ProductServiceImpl productService;

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private CategoryProImpl categoryService;

    @Autowired
    private ImageServiceImpl imageService;

    @Autowired
    private UserRoleServiceImpl roleService;

    @Autowired
    private OrderServiceImpl orderService;

   
    @Autowired
    public PromotionServiceImpl promotionService;

    @Autowired
    private FavoriteProServiceImpl favoriteService;

    @Autowired
    private OrderDetailServiceImpl orderDetailService;

    @Autowired
    private PaymentServiceImpl paymentService;

    @Autowired
    private CreditCardServiceImpl cardService;
    

    @Autowired
    private CommentServiceImpl commentService;

    @ModelAttribute(name = "categories")
    public List<CategoryEntity> getCategories() {
        List<CategoryEntity> categories = categoryService.getCategory();
        if (CollectionUtils.isEmpty(categories)) {
            return new ArrayList<>();
        }
        return categories;
    }

   
    @RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
    public String welcomePage(Model model) {
        model.addAttribute("images", imageService.getImagesDistinct());
        model.addAttribute("products", productService.findList8ProductNew());
      model.addAttribute("promotion", promotionService.getPromotionsActive());
      List<String> roles = SecurityUtils.getRolesOfUser();
        if (!CollectionUtils.isEmpty(roles) && (roles.contains("ROLE_ADMIN")
                || roles.contains("ROLE_SELLER") || roles.contains("ROLE_MANAGER"))) {
            return "redirect:/admin/home";
        }

        return "home2";
    }

    @RequestMapping("/403")
    public String accessDenied(Model model) {
        model.addAttribute("categories", categoryService.getCategory());
        return "403";
    }

    @RequestMapping("/aboutUs")
    public String AboutUs(Model model,
            @RequestParam(name = "message", required = false) String message) {
        model.addAttribute("message", message);
        return "aboutUs";
    }

    @RequestMapping(value = "/findOrder", method = RequestMethod.GET)
    public String findOrderPage(Model model) {
        return "redirect:/aboutUs?message=find";
    }

    @RequestMapping(value = "/findOrder", method = RequestMethod.POST)
    public String findOrder(Model model,
            @RequestParam(name = "orderSearch", required = false) String orderSearch) {
        OrderEntity order = orderService.findByOrderUid(orderSearch);
        if (order == null) {
            model.addAttribute("type", "error");
        }
        model.addAttribute("message", "findOrder");
        model.addAttribute("order", order);
        model.addAttribute("orderDetail", orderDetailService.getOrderDetails());
        return "aboutUs";
    }

    @RequestMapping("/orderDetail/{orderUId}")
    public String orderDetail(Model model,
            @PathVariable(name = "orderUId", required = false) String orderUId) {
        OrderEntity order = orderService.findByOrderUid(orderUId);

        model.addAttribute("orderUId", orderUId);
        model.addAttribute("orderDetail", orderDetailService.getOrderDetailByorderId(order.getId()));
        return "orderDetail";
    }

// list all of Category
    

    @RequestMapping("/searchProduct")
    @Transactional(rollbackFor = Exception.class)
    public String searchProduct(Model model,
            @ModelAttribute("strSearch") String strSearch) {
        try {
            model.addAttribute("images", imageService.getImagesDistinct());
            model.addAttribute("products", productService.searchProduct(strSearch));
            model.addAttribute("promotion", promotionService.getPromotionsActive());
            return "listProduct";
        } catch (Exception e) {
            return "403";
        }
    }

 

    @RequestMapping("/login")
    public String loginPage(Model model, @RequestParam(value = "error", required = false) boolean error) {
        if (error) {
            model.addAttribute("message", "Login Fail!!!");
        }

        return "login";
    }

 

    @RequestMapping("/cancelOrder/{orderId}")
    public String cancelOrder(Model model,
            @PathVariable("orderId") int orderId) {
        OrderEntity order = orderService.findOrderById(orderId);
        order.setStatus(OrderStatus.WAITING);
        orderService.save(order);
        model.addAttribute("message", "findOrder");
        model.addAttribute("order", order);
        model.addAttribute("orderDetail", orderDetailService.getOrderDetails());
        model.addAttribute("cancel", "After 15 minutes, a staff will call and confirm this order");
        return "aboutUs";
    }
// them noi dung phan email
    // them orderDetail
    // them phan 
}
