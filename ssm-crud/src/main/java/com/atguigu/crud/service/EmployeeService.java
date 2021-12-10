package com.atguigu.crud.service;

import java.util.List;

import com.atguigu.crud.bean.EmployeeExample;
import org.mybatis.generator.codegen.ibatis2.model.ExampleGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.EmployeeMapper;
@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 查询所有员工
	 * @Description 
	 * @author GGG
	 * @date 2021年12月3日下午10:08:40
	 * @return
	 */
	public List<Employee> getAll() {
		
		return employeeMapper.selectByExampleWithDept(null);
	}



    public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
    }


	/**
	 * 检验用户名是否可用
	 * true可用
	 * @param empName
	 * @return true，代表可用
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example  = new EmployeeExample();
		EmployeeExample.Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long cout =  employeeMapper.countByExample(example);
		return cout == 0;
	}

    public Employee getEmp(Integer id) {

        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     *
     * @param employee
     */
    public void update(Employee employee) {

	    employeeMapper.updateByPrimaryKeySelective(employee);


    }


	/**
	 *
	 * @param id
	 */
	public void deleteEmp(Integer id) {
	employeeMapper.deleteByPrimaryKey(id);

	}

	public void deleteBatch(List<Integer> ids) {

		EmployeeExample example = new EmployeeExample();

		EmployeeExample.Criteria criteria = example.createCriteria();

		criteria.andEmpIdIn(ids);

	employeeMapper.deleteByExample(example);



	}

}
