<%@ Page Title="تعديل مستخدمين النظام" Language="C#" MasterPageFile="~/Admin/MasterPage.master" %>

<script runat="server">

    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("Users.aspx");
        }
        else
        {
            if (!Page.IsPostBack)
            {
                TextBox1.Text = DataBase.GetPName("Users", "name", "id", Session["UserId"].ToString());
                TextBox2.Text = DataBase.GetPName("Users", "username", "id", Session["UserId"].ToString());
                TextBox3.Text = DataBase.GetPName("Users", "password", "id", Session["UserId"].ToString());
                DropDownList1.Items.FindByValue(DataBase.GetPName("Users", "type", "id", Session["UserId"].ToString())).Selected = true;
            }
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (DataBase.UpdateData("Users", new string[] { "name", "username", "password", "type" }, new string[] { TextBox1.Text, TextBox2.Text, TextBox3.Text, DropDownList1.SelectedValue }, "id", Session["UserId"].ToString()))
        {
            Message msg = new Message("تم تعديل المستخدم", true, "Users.aspx", "Users.aspx");
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

<table class="LogInTable" width="80%">
    <tr>
        <td colspan="2" class="Title">
            تعديل بيانات المستخدم
        </td>
        
    </tr>
    <tr>
        <td>اسم المستخدم</td>
        <td>
            <asp:TextBox CssClass="Text" ID="TextBox1" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>اسم الدخول</td>
        <td>
            <asp:TextBox CssClass="Text" ID="TextBox2" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>كلمة السر</td>
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
            <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تعديل</asp:LinkButton> | 
            <a href="Users.aspx">رجوع</a>
        </td>
    </tr>
</table>
    
</center>
<br />
</asp:Content>

