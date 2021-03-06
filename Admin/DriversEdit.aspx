﻿<%@ Page Title="تعديل معلومات السائق" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PID"] != null)
        {
            if (!Page.IsPostBack)
            {
                TextBox1.Text = DataBase.GetPName("Drivers", "name", "id", Session["PID"].ToString());
                TextBox2.Text = DataBase.GetPName("Drivers", "phone", "id", Session["PID"].ToString());
            }
        }
        else
        {
            Response.Redirect("Drivers.aspx");
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Page.Validate();
        if (Page.IsValid)
        {
            if (DataBase.UpdateData("Drivers", new string[] { "name", "phone" }, new string[] { TextBox1.Text, TextBox2.Text }, "id", Session["PID"].ToString()))
            {
                Message msg = new Message("تم تعديل معلومات السائق", true, "Drivers.aspx", "Drivers.aspx");
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
            else
            {
                Message msg = new Message("خطا في النظام الرجاء المحاولة مرة اخرى", false, "Drivers.aspx", "Drivers.aspx");
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
        }
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (!TextBox1.Text.Equals(DataBase.GetPName("Drivers", "name", "id", Session["PID"].ToString())))
        {
            if (DataBase.GetPName("Drivers", "name", "name", TextBox1.Text).Trim().Length != 0)
            {
                args.IsValid = false;
            }
            else
            {

                args.IsValid = true;
            }
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>  
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
    
    <center>
        <table align="center" class="LogInTable">
        <tr>
            <td colspan="2" class="Title">
                تعديل معلومات سائق
            </td>
        </tr>
        <tr class="tr2">
            <td>
                اسم السائق 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="الرجاء ادخال اسم السائق" Text="*" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                <asp:CustomValidator ControlToValidate="TextBox1" ID="CustomValidator1" Text="*" runat="server" ErrorMessage="اسم السائق مدخل من قبل" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            </td>
            <td>
                <asp:TextBox ID="TextBox1" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr class="tr2">
            <td>
                رقم الهاتف 
                
            </td>
            <td>
                <asp:TextBox ID="TextBox2" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="Center">
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">تعديل</asp:LinkButton> | 
                <a href="Drivers.aspx">رجوع</a>
                <br />
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </td>
        </tr>
    </table>
    </center>
    
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

