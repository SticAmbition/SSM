package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 *
 *
 * @author GGG
 * @create 2021-12-05 17:07
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

@RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){

      List<Department> list =  departmentService.getDepts();

        return Msg.success().add("depts",list);

    }
}
