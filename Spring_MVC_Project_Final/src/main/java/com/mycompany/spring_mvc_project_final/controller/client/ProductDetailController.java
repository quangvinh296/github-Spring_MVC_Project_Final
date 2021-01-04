/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.client;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.CommentEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.PromotionStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryProImpl;
import com.mycompany.spring_mvc_project_final.service.CommentServiceImpl;
import com.mycompany.spring_mvc_project_final.service.FavoriteProServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ImageServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ProductServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PromotionServiceImpl;
import com.mycompany.spring_mvc_project_final.service.UserServiceImpl;
import com.mycompany.spring_mvc_project_final.utils.UserUtils;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author my
 */
@Controller
public class ProductDetailController {

    @Autowired
    private CommentServiceImpl commentService;

    @Autowired
    private ProductServiceImpl productService;

    @Autowired
    public PromotionServiceImpl promotionService;

    @Autowired
    private CategoryProImpl categoryService;

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private ImageServiceImpl imageService;

    @Autowired
    private FavoriteProServiceImpl favoriteService;

    public double discountProduct(int productId) {
        double discount = 0;
        ProductEntity product = productService.findProductById(productId);
        List<PromotionEntity> promotions = promotionService.findProByCategoryId(product.getCategory().getId());
        for (PromotionEntity pro : promotions) {
            Date date = new Date();
            if (pro.getStatus() == PromotionStatus.ACTIVE && pro.getStartDate().compareTo(date) * date.compareTo(pro.getEndDate()) > 0) {
                discount = pro.getDiscount();
            }
        }
        return discount;
    }

    @RequestMapping("/productDetail/{idProduct}")
    public String ProductDetail(Model model,
            @RequestParam(name = "message1", defaultValue = "description") String message1,
            @PathVariable("idProduct") int idProduct) {
        ProductEntity product = productService.findProductById(idProduct);

        if (product.getQuantityProduct() == 0) {
            model.addAttribute("message", "Out of Stock");
        }
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        if (user != null) {
            model.addAttribute("favorite", favoriteService.findByUserIdAndProductId(user.getId(), idProduct));
        }
        if (user == null) {
            model.addAttribute("favorite", null);
        }

        model.addAttribute("comment", commentService.findByProductId(idProduct));
        model.addAttribute("cmt", new CommentEntity());
        model.addAttribute("count", commentService.getTotalItem(idProduct));
        model.addAttribute("discount", discountProduct(idProduct));
        model.addAttribute("img", imageService.getImagesDistinct());
        model.addAttribute("images", imageService.getImages());
        model.addAttribute("message1", message1);
        model.addAttribute("productDetail", productService.findProductById(idProduct));
        return "productDetail";
    }

    @RequestMapping("/technical/{idProduct}")
    public String detailTechnical(Model model,
            @PathVariable("idProduct") int id) {

        return "redirect:/productDetail/" + id + "?message1=technical";
    }

    @RequestMapping("/description/{idProduct}")
    public String description(Model model,
            @PathVariable("idProduct") int id) {
        return "redirect:/productDetail/" + id + "?message1=description";
    }

    @RequestMapping("/comment/{idProduct}")
    public String view(Model model,
            @PathVariable("idProduct") int id) {

        return "redirect:/productDetail/" + id + "?message1=comment";
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
