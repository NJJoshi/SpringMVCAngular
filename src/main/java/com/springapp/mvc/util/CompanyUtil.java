package com.springapp.mvc.util;

import com.springapp.mvc.model.Company;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * Created by niravjoshi on 20/02/16.
 */
public class CompanyUtil {
    private final List<Company> companyStore = Collections.synchronizedList(new ArrayList<Company>());

    public CompanyUtil() {
        Company c = new Company(1, "NJ Infotech Pvt Ltd", "Navsari, Gujarat", "Navsari", "India", Arrays.asList(new String[]{"Nirav Joshi"}));
        companyStore.add(c);
    }

    public List<Company> getAllCompanies() {
        return companyStore;
    }

    public int addCompany(Company c) {
        int companyId = -1;
        if(c != null) {
            companyStore.add(c);
            companyId = c.getCompanyId();
        }
        return companyId;
    }

    public Company getCompany(Company filterObj) {
        Company result = null;
        if(filterObj != null && filterObj.hasAllMandatoryFields() && companyStore.contains(filterObj)) {
            int objIndex = companyStore.lastIndexOf(filterObj);
            result = companyStore.get(objIndex);
        } else if( filterObj != null && filterObj.getCompanyId() > 0){
            int companyId = filterObj.getCompanyId();
            for(Company c : companyStore) {
                int id = c.getCompanyId();
                if(id == companyId) {
                    result = c;
                    break;
                }
            }

        }
        return result;
    }

    public void updateCompanyDetail(Company newObj) {
        int companyId = newObj.getCompanyId();
        Company oldObj = null;
        for(Company c : companyStore) {
            int id = c.getCompanyId();
            if(id == companyId) {
                oldObj = c;
                break;
            }
        }
        if(oldObj!= null && companyStore.contains(oldObj)) {
            int objIndex = companyStore.lastIndexOf(oldObj);
            if(objIndex >=0) {
                companyStore.remove(objIndex);
                companyStore.add(objIndex, newObj);
            }
        }
        return;
    }
}
