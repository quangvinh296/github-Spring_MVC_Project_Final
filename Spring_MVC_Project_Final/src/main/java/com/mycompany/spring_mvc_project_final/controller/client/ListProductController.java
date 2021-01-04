/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.client;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.service.CategoryProImpl;
import com.mycompany.spring_mvc_project_final.service.ImageServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ProductServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PromotionAdService;
import com.mycompany.spring_mvc_project_final.service.PromotionServiceImpl;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
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
public class ListProductController {

    @Autowired
    private CategoryProImpl categoryService;

    @Autowired
    private ProductServiceImpl productService;

    @Autowired
    public PromotionServiceImpl promotionService;
    
     @Autowired
    private PromotionAdService proService;
     
    @Autowired
    private ImageServiceImpl imageService;

    @RequestMapping("/listCategory")
    public String ListCategory(Model model) {
        return "listCategory";
    }

    @RequestMapping(value = {"/listProduct", "/listProduct/page", "/ListProduct/page/{byorder}", "ListProduct/{byorder}"}, method = RequestMethod.GET)
    public String viewAllProduct(Model model,
            @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
            @RequestParam(name = "size", required = false, defaultValue = "8") Integer size,
            @RequestParam(name = "start", required = false, defaultValue = "0") Integer start,
            @PathVariable(name = "byorder", required = false) String byorder) {

        int n = productService.getTotalItem();
        Pageable pageable = PageRequest.of(page, size);
        if (n % size != 0) {
            model.addAttribute("numberPages", (n / size) + 1);
        } else {
            model.addAttribute("numberPages", (n / size));
        }

        if (byorder == null) {
            model.addAttribute("products", productService.getProductsPage(page, size).getContent());
        } else {
            if (byorder.equalsIgnoreCase("selling")) {
                model.addAttribute("products", productService.listProductOrderSelling(page, size).getContent());
                model.addAttribute("by", "selling");
            }
            if (byorder.equalsIgnoreCase("price")) {
                model.addAttribute("products", productService.listProductOrderPrice(page, size).getContent());
                model.addAttribute("by", "price");
            }
            if (byorder.equalsIgnoreCase("new")) {
                model.addAttribute("products", productService.listProductOrderNew(page, size).getContent());
                model.addAttribute("by", "new");
            }
        }
        model.addAttribute("countProducts", productService.getTotalItem());
        model.addAttribute("message", "ByProduct");
        model.addAttribute("promotion", promotionService.getPromotionsActive());
        model.addAttribute("images", imageService.getImagesDistinct());
        model.addAttribute("page", page);
        model.addAttribute("start", start);
        model.addAttribute("size", 8);
        model.addAttribute("n", n);

        return "listProduct";

    }

    @RequestMapping(value = {"/cate/{nameCategory}/{byorder}", "/listProduct/{byorder}"}, method = RequestMethod.GET)
    public String ListProductByCategory(Model model,
            @PathVariable(name = "byorder", required = false) String byorder,
            @PathVariable(name = "nameCategory", required = false) String name) {

        if (productService.findListProductNewByCategory(byorder) != null) {
            model.addAttribute("products", productService.findListProductNewByCategory(byorder));
            model.addAttribute("category", byorder);
        }
        if (byorder.equalsIgnoreCase("new") && name != null) {
            model.addAttribute("products", productService.findListProductNewByCategory(name));
            model.addAttribute("category", name);
        }
        if (byorder.equalsIgnoreCase("price") && name != null) {
            model.addAttribute("products", productService.findListProductPriceByCategory(name));
            model.addAttribute("category", name);

        }
        if (byorder.equalsIgnoreCase("selling") && name != null) {
            model.addAttribute("products", productService.findListProductSellingByCategory(name));
            model.addAttribute("category", name);
        }

        model.addAttribute("countProducts", productService.getTotalItem());
        model.addAttribute("message", "byCategory");
        model.addAttribute("promotion", promotionService.getPromotionsActive());
        model.addAttribute("images", imageService.getImagesDistinct());
        return "listProduct";

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
