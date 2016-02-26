package com.springapp.mvc.controller;

import com.springapp.mvc.model.Company;
import com.springapp.mvc.util.CompanyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Random;

/**
 * Created by niravjoshi on 20/02/16.
 */
@Controller
public class CompanyDetailController {

    @Autowired
    private CompanyUtil companyUtil;

    @RequestMapping(value="/getAllCompanies", method= RequestMethod.GET)
    public String getAllCompanies(Model model) {
        List<Company> companies = companyUtil.getAllCompanies();
        model.addAttribute("companies", companies);
        return "jsonTemplate";
    }

    @RequestMapping(value="/createCompany", method=RequestMethod.POST)
    public String createCompany(@RequestParam("name") String name, @RequestParam("address") String address, @RequestParam("city")String city,
                              @RequestParam("country")String country, @RequestParam("email")String email, @RequestParam("contactNo")String contactNo,
                              @RequestParam("owners")String owners) {
        Random r = new Random();
        Integer companyId = r.nextInt(999);
        Company c = new Company(companyId, name, address, city, country, Arrays.asList(new String[]{owners}));
        if(!email.isEmpty()) c.setEmail(email);
        if(!contactNo.isEmpty()) c.setContactNo(contactNo);
        companyUtil.addCompany(c);
        return "jsonTemplate";
    }

    @RequestMapping(value="/getCompany/{id}", method=RequestMethod.GET)
    public String getCompany(@PathVariable("id")String id, Model model) {
        Company filterObj = new Company();
        filterObj.setCompanyId(Integer.parseInt(id));
        Company resultObj = companyUtil.getCompany(filterObj);
        model.addAttribute("companies", resultObj);
        return "jsonTemplate";
    }

    @RequestMapping(value="/updateCompany", method=RequestMethod.POST)
    public String updateCompany(@RequestParam("name") String name, @RequestParam("address") String address, @RequestParam("city")String city,
                                @RequestParam("country")String country, @RequestParam("email")String email, @RequestParam("contactNo")String contactNo,
                                @RequestParam("owners")String owners, @RequestParam("Id")String id) {
        int companyId = Integer.parseInt(id);
        Company c = new Company(companyId, name, address, city, country, Arrays.asList(new String[]{owners}));
        if(!email.isEmpty()) c.setEmail(email);
        if(!contactNo.isEmpty()) c.setContactNo(contactNo);
        companyUtil.updateCompanyDetail(c);
        return "jsonTemplate";
    }

    @RequestMapping(value="/updateCompanyDetail", method = RequestMethod.POST)
    public String updateCompanyDetail(@RequestParam("Id")String id, @ModelAttribute("company")Company company, BindingResult result ) {
        int companyId = Integer.parseInt(id);
        if(company != null) {
            company.setCompanyId(companyId);
            companyUtil.updateCompanyDetail(company);
        }
        return "jsonTemplate";
    }
}
