/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.client;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.enums.PromotionStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryProImpl;
import com.mycompany.spring_mvc_project_final.service.ImageServiceImpl;
import com.mycompany.spring_mvc_project_final.service.OrderServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ProductServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PromotionServiceImpl;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

/**
 *
 * @author my
 */
@Controller
public class CartController {

    @Autowired
    private CategoryProImpl categoryService;

    @Autowired
    private OrderServiceImpl orderService;

    @Autowired
    private ProductServiceImpl productService;

    @Autowired
    private ImageServiceImpl imageService;

    @Autowired
    public PromotionServiceImpl promotionService;

    // create new cart
    @RequestMapping("/updateQuantity/{productId}")
    public String updateQuantity(Model model, HttpServletRequest request,
            HttpSession session,
            @RequestParam(name = "priceDiscount", required = false) Double priceDiscount,
            @RequestParam(name = "quantity_input", required = false) String quantity_value,
            @PathVariable("productId") int productId) {
        HashMap<Integer, OrderDetailEntity> orderDetails = getOrderDetails(request, session);
        int quantity = Integer.parseInt(quantity_value);
        ProductEntity product = productService.findProductById(productId);
        if (product != null) {
            if (product.getQuantityProduct() >= quantity) {
                if (orderDetails.containsKey(productId)) {
                    OrderDetailEntity item = orderDetails.get(productId);
                    item.setProduct(product);
                    item.setDiscount(priceDiscount);
                    item.setQuantity(item.getQuantity() + quantity);
                    orderDetails.put(productId, item);
                } else {
                    OrderDetailEntity item = new OrderDetailEntity();
                    item.setProduct(product);
                    item.setDiscount(priceDiscount);
                    item.setQuantity(quantity);
                    orderDetails.put(productId, item);
                }
            } else {
                model.addAttribute("error", "Product have " + product.getQuantityProduct() + " item");
            }
        }
        session.setAttribute("myCart", orderDetails);
        session.setAttribute("myCartTotal", totalPrice(orderDetails));
        session.setAttribute("myCartTotalQuantity", totalQuantityProduct(orderDetails));

        return "redirect:/productDetail/" + productId + "?message1=description";
    }

    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public String orderProduct(Model model, HttpServletRequest request,
            HttpSession session,
            @RequestParam(name = "discount", required = false) Double discount,
            @RequestParam(name = "promotion", required = false) String promotion) {
        HashMap<Integer, OrderDetailEntity> orderDetails = getOrderDetails(request, session);

        for (Map.Entry<Integer, OrderDetailEntity> list : orderDetails.entrySet()) {
            if (list.getValue().getDiscount() != list.getValue().getProduct().getPrice()) {
                model.addAttribute("message", "notPromotion");
                break;
            }
        }

        model.addAttribute("images", imageService.getImagesDistinct());
        model.addAttribute("discount", discount);
        model.addAttribute("pro", promotion);
        session.setAttribute("myCart", orderDetails);
        session.setAttribute("myCartTotal", totalPrice(orderDetails));
        session.setAttribute("myCartTotalQuantity", totalQuantityProduct(orderDetails));
        return "cart";

    }

    @RequestMapping("/promotion")
    public String addPromo(Model model,
            @RequestParam(name = "coupon_input", required = false) String strPromo,
            HttpServletRequest request, HttpSession session) {

        PromotionEntity pro = promotionService.findPromotionByCode(strPromo);
        Date date = new Date();
        if (pro != null) {
            if (pro.getStatus().equals(PromotionStatus.ACTIVE) && pro.getStartDate().compareTo(date) * date.compareTo(pro.getEndDate()) > 0) {
                request.getSession().setAttribute("promotionCode", pro);
                return "redirect:/cart?promotion=success&discount=" + pro.getDiscount();

            } else {
                return "redirect:/cart?promotion=error";
            }
        } else {
            return "redirect:/cart?promotion=error";
        }
    }

    // update quantity on cart page
    @RequestMapping(value = "/update/{productId}", method = RequestMethod.POST)
    public String orderProduct(Model model, HttpServletRequest request,
            HttpSession session, @RequestParam(name = "button", required = false) String button,
            @RequestParam(name = "quantity_input", required = false) String quantity_value,
            @PathVariable("productId") int productId) {

        HashMap<Integer, OrderDetailEntity> orderDetails = getOrderDetails(request, session);
        int quantity = Integer.parseInt(quantity_value);
        ProductEntity product = productService.findProductById(productId);
        if (orderDetails.containsKey(productId)) {

            OrderDetailEntity item = orderDetails.get(productId);

            if (button.equalsIgnoreCase("-")) {
                if (quantity == 1) {
                    orderDetails.remove(productId);
                } else {
                    item.setProduct(product);
                    item.setQuantity(quantity - 1);
                    orderDetails.put(productId, item);
                }
            }
            if (button.equalsIgnoreCase("+")) {
                if (quantity == product.getQuantityProduct()) {
                    model.addAttribute("error", "Product " + product.getName() + " have " + product.getQuantityProduct() + " items");
                } else {
                    item.setProduct(product);
                    item.setQuantity(quantity + 1);
                    orderDetails.put(productId, item);
                }
            }
        }
        return "redirect:/cart";
    }

    @RequestMapping(value = "remove/{Id}", method = RequestMethod.GET)
    public String viewRemove(Model model, HttpServletRequest request,
            HttpSession session,
            @PathVariable("Id") int id) {
        HashMap<Integer, OrderDetailEntity> orderDetails = getOrderDetails(request, session);
        orderDetails.remove(id);
        return "redirect:/cart";

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

    public static HashMap<Integer, OrderDetailEntity> getOrderDetails(HttpServletRequest request, HttpSession session) {
        HashMap<Integer, OrderDetailEntity> orderDetails = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("myCart");
        if (orderDetails == null) {
            orderDetails = new HashMap<>();
        }
        return orderDetails;
    }

    @ModelAttribute(name = "categories")
    public List<CategoryEntity> getCategories() {
        List<CategoryEntity> categories = categoryService.getCategory();
        if (CollectionUtils.isEmpty(categories)) {
            return new ArrayList<>();
        }
        return categories;
    }

}
