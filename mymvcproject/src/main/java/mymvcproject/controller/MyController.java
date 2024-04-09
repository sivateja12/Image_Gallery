package mymvcproject.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.AbstractView;
import org.springframework.web.servlet.view.RedirectView;

import com.google.protobuf.TextFormat.ParseException;

import mymvcproject.dao.imageDao;
import mymvcproject.model.Image;

@Controller
public class MyController {
    
    @Autowired
    private imageDao imagedao;
    
    @RequestMapping("/")
    public String index(Model model) {
        List<Image> allImages = this.imagedao.getAllImages();
        model.addAttribute("allImages", allImages);
        
        List<String> imageDataList = new ArrayList<>();
        for (Image image : allImages) {
            if (image.getImage() != null) {
                byte[] imageData=null;
				try {
					imageData = image.getImage().getBytes(1, (int) image.getImage().length());
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
                String imageDataBase64 = Base64.getEncoder().encodeToString(imageData);
                imageDataList.add(imageDataBase64);
            } else {
                // If image is null, add an empty string
                imageDataList.add("");
            }
        }
        model.addAttribute("imageDataList", imageDataList);
        
     

        return "index";
    }


    @RequestMapping("/getImages")
    public ModelAndView handler() {
        ModelAndView model = new ModelAndView();
        try {
            List<Image> allImages = this.imagedao.getAllImages();
            Map<String, String> imageDataMap = new LinkedHashMap<>(); // Using LinkedHashMap to preserve insertion order
            
            // Encode images to Base64 and add to the map with descriptions
            for (Image image : allImages) {
                if (image.getImage() != null) {
                    byte[] imageData = image.getImage().getBytes(1, (int) image.getImage().length());
                    String imageDataBase64 = Base64.getEncoder().encodeToString(imageData);
                    imageDataMap.put(imageDataBase64, image.getDescription());
                }
            }

            model.addObject("imageDataMap", imageDataMap);
            model.setViewName("allimages");
        } catch (Exception e) {
            e.printStackTrace();
            model.setViewName("errorPage");
        }
        return model;
    }


    @RequestMapping("/addImage")
    public String addProduct() {
        System.out.println("Adding image");
        return "addForm";
    }

    @RequestMapping(path = "/processadd", method = RequestMethod.POST)
    public ModelAndView form(HttpServletRequest request, @RequestParam("image") CommonsMultipartFile[] images,
            @RequestParam("description") String description, @RequestParam("location") String location,
            @RequestParam("date") String date) {
    	List<String> mulImages=new ArrayList<>();
        ModelAndView model = new ModelAndView();
        try {
            for (CommonsMultipartFile image : images) {
                if (image != null && !image.isEmpty()) {
                    Image im = new Image();
                    im.setDescription(description);
                    im.setLocation(location);
                    im.setDate(date.substring(0, 10));
                    // Convert String date to Date object
                    
                    byte[] bytes = image.getBytes();
                    SerialBlob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
                    im.setImage(blob);
                    int insert = imagedao.insert(im);
                    model.addObject("image", im);
                    model.addObject("row", "Inserted Successfully");
                    // Fetch image from database as byte array
                    byte[] imageData = imagedao.get(im.getId()).getImage().getBytes(1, (int) im.getImage().length());
                    // Convert byte array to Base64 String
                    String imageDataBase64 = Base64.getEncoder().encodeToString(imageData);
                    // Add Base64 String to the model
                    model.addObject("imageData", imageDataBase64);
                    mulImages.add(imageDataBase64);
                }
            }
            model.setViewName("addImage");
            model.addObject("mulImages",mulImages);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Image insertion error");
        }
        return model;
    }

    
    //delete handler
    @RequestMapping("/delete/{id}")
    public RedirectView delete(@PathVariable("id")int id,HttpServletRequest request) {
    	RedirectView redirectView = new RedirectView();
    	redirectView.setUrl(request.getContextPath()+"/");
    	this.imagedao.delete(id);
    	return redirectView;
    }
    
    //update handler
    @RequestMapping("/update/{id}")
    public String update(@PathVariable("id")int id,Model model) {
    	Image image = this.imagedao.get(id);
    	model.addAttribute("image",image);
    	model.addAttribute("row","Image Details Updated Successfully!!!");
    	return "update_form";
    }
    
    //download image from the database
    @RequestMapping("/download/{id}")
    public void downloadImage(@PathVariable("id") int id, HttpServletResponse response) throws IOException {
        Image image = this.imagedao.get(id);

        // Set response headers
        response.setContentType("image/jpeg");
        response.setHeader("Content-Disposition", "attachment; filename=image.jpg");

        // Write image data to response output stream
        try (InputStream inputStream = image.getImage().getBinaryStream();
             OutputStream outputStream = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}