package com.springapp.mvc.model;

import javax.xml.bind.annotation.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by niravjoshi on 20/02/16.
 */
@XmlRootElement(name = "company")
@XmlAccessorType(XmlAccessType.NONE)
public class Company implements Serializable {

    private static final long serialVersionUID = 123L;
    @XmlAttribute
    private Integer companyId;

    @XmlElement
    private String name;

    @XmlElement
    private String address;

    @XmlElement
    private String city;

    @XmlElement
    private String country;

    @XmlElement
    private String email;

    @XmlElement
    private String contactNo;

    @XmlTransient
    @XmlElement
    private List<String> owners;

    @XmlElement
    private String beneficiary;

    public Company() {
    }

    public Company(Integer companyId, String name, String address, String city, String country, List<String> owners) {
        this.companyId = companyId;
        this.name = name;
        this.address = address;
        this.city = city;
        this.country = country;
        this.owners = owners;
        this.beneficiary = getBeneficiary();
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public List<String> getOwners() {
        return owners;
    }

    public void setOwners(List<String> owners) {
        this.owners = owners;
    }

    public String getBeneficiary() {
        StringBuilder temp = new StringBuilder();
        List<String> owners = getOwners();
        if(owners != null) {
            for(String owner : owners) {
                temp.append(owner+",");
            }
        }
        beneficiary = temp.substring(0, temp.length() - 1).toString();
        return beneficiary;
    }

    public void setBeneficiary(String beneficiary) {
        this.beneficiary = beneficiary;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Company company = (Company) o;

        if (address != null ? !address.equals(company.address) : company.address != null) return false;
        if (city != null ? !city.equals(company.city) : company.city != null) return false;
        if (companyId != null ? !companyId.equals(company.companyId) : company.companyId != null) return false;
        if (country != null ? !country.equals(company.country) : company.country != null) return false;
        if (name != null ? !name.equals(company.name) : company.name != null) return false;
        if (owners != null ? !owners.equals(company.owners) : company.owners != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = companyId != null ? companyId.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + (city != null ? city.hashCode() : 0);
        result = 31 * result + (country != null ? country.hashCode() : 0);
        result = 31 * result + (owners != null ? owners.hashCode() : 0);
        return result;
    }

    public boolean hasAllMandatoryFields() {
      if(address == null || address.isEmpty()) return false;
      if(city == null || city.isEmpty()) return false;
      if(companyId == null || companyId <= 0) return false;
      if(country == null || country.isEmpty()) return false;
      if(name == null || name.isEmpty()) return false;
      if(owners == null || owners.isEmpty()) return false;
      return true;
    }
}
