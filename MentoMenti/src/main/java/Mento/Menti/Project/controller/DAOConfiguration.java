package Mento.Menti.Project.controller;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

import Mento.Menti.Project.dao.UserDAO;
import lombok.Getter;

@Configuration
@MapperScan(basePackages="Mento.Menti.Project.dao")
@Getter
public class DAOConfiguration {
    @Autowired
    private UserDAO userDAO;
}
