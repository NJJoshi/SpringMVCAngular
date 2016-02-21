package com.springapp.mvc.config;

import com.springapp.mvc.util.CompanyUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by niravjoshi on 20/02/16.
 */
@Configuration
public class CompanyConfig {
    @Bean
    public CompanyUtil companyUtil() {
        return new CompanyUtil();
    }
}
