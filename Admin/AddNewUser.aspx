<%@ Page Title="اضافة مستخدم جديد" Language="C#" MasterPageFile="~/Admin/MasterPage.master" %>

<script runat="server">

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (DataBase.Insert("Users", new string[] { "name", "username", "password", "type" }, new string[] { TextBox1.Text, TextBox2.Text, TextBox3.Text, DropDownList1.SelectedValue }))
        {
            Message msg = new Message("تم اضافة المستخدم", true, "Users.aspx", "Users.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
        else
        {
            Message msg = new Message("خطأ في النظام الرجاء المحاولة مرة اخرى", false, "Users.aspx", "Users.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<center>

    <table class="LogInTable" >
        <tr>
            <td colspan="2" class="Title">
                اضافة مستخدم جديد
            </td>
            
        </tr>
        <tr>
            <td>اسم المستخدم  
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="الرجاء ادخال اسم المستخدم" ControlToValidate="TextBox1">*</asp:RequiredFieldValidator></td>
            <td>
                <asp:TextBox CssClass="Text" ID="TextBox1" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>اسم الدخول  
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage="الرجاء ادخال اسم الدخول" ControlToValidate="TextBox2">*</asp:RequiredFieldValidator></td>
            <td>
                <asp:TextBox CssClass="Text" ID="TextBox2" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>كلمة السر  
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ErrorMessage="الرجاء ادخال كلمة السر" ControlToValidate="TextBox3">*</asp:RequiredFieldValidator></td>
            <td>
                <asp:TextBox CssClass="Text" ID="TextBox3" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>نوع المستخدم</td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Text="مدير نظام" Value="1"></asp:ListItem>
                    <asp:ListItem Text="مدخل بيانات-العقبة" Value="2"></asp:ListItem>
                    <asp:ListItem Text="مدخل بيانات-عمان" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="Center">
                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">حفظ</asp:LinkButton> | 
                <a href="Users.aspx">رجوع</a>
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </td>
        </tr>
    </table>

</center>
<br />

</asp:Content>

