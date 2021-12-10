package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.atguigu.crud.bean.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import javax.validation.Valid;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    /**
     * 检查用户名是否可用
     *
     * @param empName
     * @return
     */

    @ResponseBody
    @RequestMapping("/checkuse")
    public Msg checkuse(@RequestParam("empName") String empName) {
        //先判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";

        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名必须6-16位数字和字母的组合");
        }

        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }

    }

    /**
     * 员工保存
     * 1.JSR303校验
     * 2.导入hibernate validator
     *
     * @param employee
     * @return
     */

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {

            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名" + fieldError.getField());
                System.out.println("错误信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }


    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //需要分页查询，引入PageHelper分页插件
        //查询前调用,传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        //startPage紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
        //封装了详细的信息，包括查询的数据,传入连续显示的页码（1，2，3，4，5;2，3，4，5，6）
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 查询员工数据（分页查询）
     *
     * @return
     * @Description
     * @author GGG
     * @date 2021年12月3日下午10:02:08
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //需要分页查询，引入PageHelper分页插件
        //查询前调用,传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        //startPage紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
        //封装了详细的信息，包括查询的数据,传入连续显示的页码（1，2，3，4，5;2，3，4，5，6）
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);

        return "list";
    }


    /**
     * 查询员工的请求
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    /**
     *
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee) {

        System.out.println(employee);

        employeeService.update(employee);


        return Msg.success();
    }


    /**
     * 单个批量二合一
     *批量：1-2-3
     * 单个：1
     *
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpId(@PathVariable("ids")String ids){

       //批量删除
        if(ids.contains("-")){

            List<Integer> del_ids = new ArrayList<>();

            String[] str_ids = ids.split("-");


            for(String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }


            employeeService.deleteBatch(del_ids);
            //单个删除
        }else {

            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }



        return Msg.success();
    }


}
