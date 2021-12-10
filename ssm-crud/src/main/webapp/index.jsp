<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <script type="text/javascript"
            src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet"
          href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script
            src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--添加员工的模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <%--for可指可不指--%>
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input name="empName" type="text" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="email_add_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--修改员工的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <%--for可指可不指--%>
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_staic"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="email_update_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_upate_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>


<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>

    </div>
    <!-- 显示表格数据 -->
    <div class="row"></div>
    <div class="col-md-12">
        <table class="table table-hover" id="emps_table">
            <thead>
            <tr>
                <th>
                    <input type="checkbox" id="check_all">

                </th>
                <th>#</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>

            </tbody>


        </table>

    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页文字信息--%>
        <div class="col-md-6c" id="page_nav_area">

        </div>


    </div>

</div>
<script type="text/javascript">


    var totalRecord, currentPage;

    //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",

            success: function (result) {
                // console.log(result);
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条
                build_page_nav(result)
            }
        });
    }

    function build_emps_table(result) {

        //清空
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxId = $("<td> <input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /**
             * <button class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
             编辑
             </button>
             */

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

            editBtn.attr("edit_id", item.empId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            delBtn.attr("del_id", item.empId);

            var btnId = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            //var delBtn
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxId)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnId)
                .appendTo("#emps_table tbody");
        })


    }

    //显示分页信息
    function build_page_info(result) {

        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum +
            "页,总共" + result.extend.pageInfo.pages +
            "页，总共" + result.extend.pageInfo.total + "条记录");

        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条,点击分页能跳转
    function build_page_nav(result) {

        $("#page_nav_area").empty();
        //page_nav_area
        var ul = $("<ul></ul>").addClass("pagination")

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }


        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页 ").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });

            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {


            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }

    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");

        $(ele).find(".help-block").text("");

    }


    //点击新增按钮弹出模态框
    $("#emp_add_model_btn").click(function () {

        reset_form("#empAddModal form");


        //发生ajax请求，查出部门信息，下拉列表
        getDepts("#dept_add_select");

        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    function getDepts(ele) {

        //清空下拉列表的值
        $(ele).empty();

        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //"extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]
                //console.log(result)
                //显示部门信息到下拉列表
                // $("#dept_add_select").append("")
                $.each(result.extend.depts, function () {

                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单数据
    function validate_add_form() {
        //1、拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

        if (!regName.test(empName)) {

            //  //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            //  show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            //  return false;
            // }else{
            //  show_validate_msg("#empName_add_input", "success", "");
            // alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");

            return false;
        } else {

            show_validate_msg("#empName_add_input", "success", "");


        }
        ;


        //2、校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {

            //    alert("邮箱格式不正确")
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");


            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");

            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("");
        }
        ;
        return true;
    }

    function show_validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);

        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);

        }
    }


    $("#empName_add_input").change(function () {

        var empName = this.value;
        //发ajax请求检验用户名是否可用
        $.ajax({
            url: "${APP_PATH}/checkuse",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {

                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");

                    $("#emp_save_btn").attr("ajax-va", "success");

                } else {

                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });

    });


    //点击保存
    $("#emp_save_btn").click(function () {


        if (!validate_add_form()) {
            return false;
        }
        ;

        //1.判断之前的用户名校验是否成功，如果成功，才继续执行

        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        ;

        //发ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {


                if (result.code == 100) {
                    $("#empAddModal").modal('hide');

                    //
                    //2.发送ajax请求显示最后一页数据即可

                    to_page(totalRecord);

                } else {
                    //显示失败信息

                    if (undefined != result.extend.errorFields.email) {

                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email)


                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //显示员工错误信息
                        show_validate_msg("#empNameadd_input", "error", result.extend.errorFields.empName)

                    }

                }


            }
        });

    });


    //1、我们是按钮创建之前就绑定了click，所以绑定不上。
    //1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
    //jquery新版没有live，使用on进行替代
    $(document).on("click", ".edit_btn", function () {
        // alert("edit")

        //  1.查出部门信息，显示部门列表
        getDepts("#empUpdateModal select");

        //查出员工信息，显示员工信息
        getEmp($(this).attr("edit_id"));

        //3.把员工id传送给模态框的更新按钮

        $("#emp_update_btn").attr("edit-id", $(this).attr("edit_id"));

        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });


    });

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {

                //  console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_staic").text(empData.empName);

                $("#email_update_input").val(empData.email);

                $("#empUpdateModal input[name=gender]").val([empData.gender]);

                $("#empUpdateModal select").val([empData.dId]);


            }


        });
    }


    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        //1、校验邮箱信息

        var email = $("#email_update_input").val();
        var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确2");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        //2.发生ajax请求保存员工数据
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            //  type:"POST",
            type: "PUT",
            //   data:$("#empUpdateModal form").serialize() + "&_method=put",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                //1.关闭对话框
                $("#empUpdateModal").modal("hide");
                //回到本页面
                to_page(currentPage);


            }
        })

    });
    //单个删除
    $(document).on("click", ".delete_btn", function () {

        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del_id");
        //弹出是否确认删除
        //alert($(this).parents("tr").find("td:eq(1)").text());

        if (confirm("确认删除【" + empName + "】吗")) {
            //确认，发生ajax请求
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);

                    //回到本页面
                    to_page(currentPage);
                }
            });
        }

    });

    //完成全选/全不选
    $("#check_all").click(function () {
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        // alert($(this).prop("checked"));
        //$(this).prop("checked");
        $(".check_item").prop("checked", $(this).prop("checked"));

    });


    $(document).on("click", ".check_item", function () {
        //判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });


    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {

        if($(".check_item:checked").length==0){
            alert("未选则删除人员");
        }else {
            //
            var empNames = "";
            var del_idstr = ""
            $.each($(".check_item:checked"), function () {

                empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
                //组装员工id字符串
                del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";

            });
            //empNames去掉多余的，
            empNames = empNames.substring(0, empNames.length - 1);
            //去除删除的id多余的-
            del_idstr = del_idstr.substring(0, del_idstr.length - 1);

            if (confirm("确认删除【" + empNames + "】吗？")) {
                //发送ajax请求

                $.ajax({
                    url: "${APP_PATH}/emp/" + del_idstr,
                    type: "DELETE",
                    success: function (result) {
                        alert(result.msg);

                        to_page(currentPage);
                    }
                });

            }
        }

    });


</script>


</body>
</html>